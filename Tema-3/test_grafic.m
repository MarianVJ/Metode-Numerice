function [] = test_grafic()
	
		N_total = 1000;
		x_final = linspace(-pi,pi,N_total+1);
		y_final = exp(3 * cos(x_final)) / (2 * pi * besseli(0,3));
		mat = zeros(2,6) ;
		mat = [8 16 32 32 16 8 ; 2 2 32 64 128 256];
	
		%LAGRANGE
		%n ia valori de la 4 la 512
		N  = mat(1,1);
		%cele N+1 puncte in care fac interpolarea
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
			
		%vectorul in care voi interpola cele 1001 puncte pentru fiecare
		%indice de la 2 la 10
		
		yL = zeros(N_total + 1,1);
	
		%pentru fiecare polinomiala voi calcula cele 1001 puncte
		% pentru a determina eroare
		for k = 1 : N_total+1
			for i = 1 : length(x)
				produs = 1;
				for j = 1 : length(y) ;
					if i ~= j
						%calculez multiplicatorul lagrange pentru
						%fiecare din cele 1001 puncte 
						produs = produs * (x_final(k)-x(j))/(x(i) - x(j));
					endif
				endfor	
				%de fiecare data adun la solutie multiplicatorul
				%lagrange in punctul x_final(k) 
				yL(k) = yL(k) + produs * y(i);
			endfor	
		endfor
		
		
		%Newton
		N  = mat(1,2);
		%x  -  Abscisele celor N + 1 puncte
		x = linspace(-pi,pi,N+1);
		%y - ordonatele celor  N + 1 puncte
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
		
		yN = zeros(N_total + 1,1);
		yy = y;
		n = length(yy);
		for i = 1 : n-1
			yy(i+1 : n) = (yy(i+1:n) - yy(i)) ./ (x(i+1:n)-x(i));
		endfor
		
		for k = 1 : N_total+1
			prd = 1;
			for j = 2 : n 
				prd = (x_final(k) - x(j-1)) * prd;
				c(j) = prd * yy(j);
			endfor
			yN(k) = sum(c);			
		endfor	
		
		
		%Fourrier
	
		%x si y cele N + 1 puncte in care voi face interpolarea
		% la fiecare pas 
		N= mat(1,6);	
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
	
		%yN voi retine cele o mie unu puncte pe care le voi afla
		% cu ajutorul interpolantului pe care il calculez la fiecare
		%pas , am nevoie de acest yN pentru a determina eroarea functiei
		yF = zeros(N_total + 1,1);
			
		m = (length(x)-1)/2;
		%initializam cu 0 cei doi vectori de coeficienti a si b 
		a=zeros(1,m);
		b=zeros(1,m);
		
		%calculam coeficientii a
		for k = 1 : m+1
			bufer = 0;
			for j = 1 : 2 * m 
				bufer = bufer + y(j) * cos((k-1)*x(j));
			endfor
		a(k) = 1/m * bufer;
		endfor
		
		%calculam coeficientii b 
		% la b primul element este 0
		b(1) = 0 ;
		for k = 2 : m 
			bufer = 0 ;
			for j = 1 : 2 *m 
				bufer = bufer + y(j) * sin((k-1)*x(j));
			endfor
			b(k) = 1/m * bufer;
		endfor
		
		for i = 1 : N_total +1
			bufer = 0;
			for k = 2 :  m 
				bufer = bufer + a(k) * cos((k-1) * x_final(i)) + b(k) * sin((k-1) * x_final(i));
			endfor
			yF(i) = ( a(1) + a(m+1)  * cos((m+1) * x_final(i)) ) / 2 + bufer;
		endfor
		
		%SPLINE LINEAR
		N= mat(1,3);	
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
	
		ySpl = zeros(N_total + 1,1);
		n = length(x);
		a = zeros(n-1,1);
		b = zeros(n-1,1);
		
		%Calculez coeficientii a si b 
		for i = 1 : n-1
			a(i) = (y(i+1) - y(i)) / (x(i+1) - x(i));
			b(i) = (x(i+1) * y(i) - x(i) * y(i+1)) / (x(i+1) - x(i));
		endfor
		%In acest for sunt calculate toate cele 1001 puncte
		%ale functiei cu ajutorul polinomului de itnerpolare
		%de la pasul curent 	
		for k = 1 : N_total+1
			for i = n-1 :-1 : 1
				%Daca punctul pe care doresc sa il aflu
				% l-am folosit deja in interpolare , nu mai este
				%nevoie sa verific conditiile si sa il calculez
				%deoarece deja ii stiu valoarea 
				if x(i) == x_final(k)
					ySpl(k) = y(i);
					break;
				endif
				if x_final(k) > x(i) && x_final(k) < x(i+1)
					ySpl(k) = a(i) * x_final(k) + b(i);
					break;
				endif
			endfor							
		endfor
			
			%SPLINE NATURAL
		N= mat(1,4);	
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
		ySpg = zeros(N_total + 1,1);	
			
		n = length(x);
		%Primul parametru ai este chiar vectorul y 
		%Restul (b c d ) urmeaza a fi calculati
		%Mai intai vom determina c ul conform metodei prezentate
		%la curs , dupa care un ii vomdetermina si pe ceilalti 
		%doi ( b si d cu ajutorul lui c )
		a = y;
		h = zeros(1,n-1);
		for i = 1 : n-1	
			h(i)= x(i+1) - x(i);
		endfor
		%bb aa si cc sunt diagonalele matricei tridiagonale
		%iar dd este "rezultatul" 
		b1 = zeros(1,n);
		d1 = zeros(1,n);
		a1 = zeros(1,n-1);
		c1 = zeros(1,n-1);
		
		b1(1) = 1; b1(n) = 1;
		d(1) = 0;  d(n) = 0;
		%construim diagonala matricei simetrice si
		%%dd care este "rezultatul" atunci cand aplicam
		%Thomas 
		for i = 2 : n-1
			b1(i) = 2 * h(i-1) +  2 * h(i);
			d1(i) = 3 * (y(i+1) - y(i)) /h(i) - 3 * (y(i) - y(i-1)) / h(i-1);
		endfor
		
		%termenii tridiagonali ai matricei 
		%ii modificam pentru a putea aplica metoda thomas 
		a1=h(1:n-2);
		c1=h(2:n-1);
		a1(n-1) = 0;
		c1 = [0 c1];	
		%rezolvam sistemul cu ajutorul metodei Thomas
		c1(1) = c1(1) / b1(1);
		d1(1) = d1(1) / b1(1);
			
			
			for i = 2 : n-1
				temp = b1(i) - a1(i) * c1(i-1);
				c1(i) = c1(i) / temp;
				d1(i) = (d1(i) - a1(i) * d1(i-1))/temp;
			endfor
			%c1 ..... cn sunt solutiile ecuatiei 
			c(n) = d1(n);
			for i = n-1 : -1 : 1
				c(i) = d1(i) - c1(i) * c(i+1);
			endfor
			%pentru calculul parametrilor vom transforma
			%totul in functie de ci
			for i = 1 : n-1
				d(i) = (c(i+1) - c(i)) / (3 * h(i) );
				b(i) = (a(i+1) - a(i)) / h(i) - h(i) * (2 * c(i) + c(i+1)) /3;
			endfor
			
			for k = 1 : N_total +1
			
			for i = n-1 : -1 : 1
				%dupa ce am gasiti cele mai mari valori care satisfav
				%conditia calculam y in punctul k cu ajutrul interpolarii
				%%la momentul actual dupa care parasim forul si calculam
				%y in urmatorul punct
				if x_final(k) > x(i) && x_final(k) <= x(i+1)
					ySpg(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x(i)) ^ 2 + d(i)* (x_final(k) - x(i))^3;
					break;
				endif
			endfor 
			
			endfor
			
		%SPLINE TENSIONAT 
		%initializez punctele cu ajutorul carora voi construi 
		%la fiecare pas polinomul de interpolare
		N= mat(1,5);	
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
		%vectorul in care voi retine punctele 
		%pe care le voi determina cu ajutorul polinomului de interp
		%ce rumeaza sa fie construit 
		ySpt = zeros(N_total + 1,1);	
			
		n = length(x);
		%Primul parametru pe care il cunoastem de la inceput
		%este a 
		a = y;
		h = zeros(1,n-1);
		for i = 1 : n-1	
			h(i)= x(i+1) - x(i);
		endfor
		%Initializam cu 0 diagonalele matricei tridiagonale 
		b1 = zeros(1,n);
		d1 = zeros(1,n);
		a1 = zeros(1,n-1);
		c1 = zeros(1,n-1);
		%Derivatele la capete sunt cele enuntate in cerinta
		%temei 
		dy1 = ( y(2) - y(1) )/ (x(2) - x(1));
		dyn = ( y(N+1) - y(N)) / (x(N+1) - x(N));
			
		b1(1) = 2 * h(1); b1(n) = 2 * h(n-1);
		d(1) = 3 * (a(2) - a(1)) / h(1) - 3 * dy1;
		d(n) = 3 * dyn - 3 * (a(n) - a(n-1)) / h(n-1);
			
		for i = 2 : n-1
			b1(i) = 2 * (h(i-1) + h(i));
			d1(i) = 3 * (a(i+1) - a(i)) /h(i) - 3 * (a(i) - a(i-1)) / h(i-1);
		endfor
		
		a1=h;
		c1=h;
		%Calculez c ul cu ajutorul met Thomas
		c1(1) = c1(1) / b1(1);
		d1(1) = d1(1) / b1(1);
		
		for i = 2 : n-1
			temp = b1(i) - a1(i) * c1(i-1);
			c1(i) = c1(i) / temp;
			d1(i) = (d1(i) - a1(i) * d1(i-1))/temp;
		endfor
			
		c(n) = d1(n);
		for i = n-1 : -1 : 1
			c(i) = d1(i) - c1(i) * c(i+1);
		endfor
			
		%Pentru calculul parametrilot vom transforma
		%totul in functie de ci
		for i = 1 : n-1
			d(i) = (c(i+1) - c(i)) / ( 3 * h(i) );
			b(i) = (a(i+1) - a(i)) / h(i) - h(i) * (2 * c(i) + c(i+1)) /3;
		endfor
			
		for k = 1 : N_total +1
			%Odata determinati toti parametrii calculam valoarea functiei
			%in toate cele 1001 puncte cu ajutorul polinomului de
			%interpolarea  , la fiecare as 
			for i = n-1 : -1 : 1
				if x_final(k) > x(i) && x_final(k) <= x(i+1)
					ySpt(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x(i)) ^ 2 + d(i)* (x_final(k) - x(i))^3;
					break;
				endif
			endfor 
		endfor
			
		

		%TRASAREA GRAFICELOR 
		subplot(2,1,1)
		hold on 
		title("Graficul pentru evaluarea continua")
		plot(x_final,yN,'r');
		plot(x_final,yL,'g');
		plot(x_final,yF,'y');
		plot(x_final,ySpl,'b');
		plot(x_final,ySpt,'k');
		plot(x_final,ySpg,'m');
	
		legend("Newton", "Lagrange","Fourrier","Spline Linear","Spline tensionat","Spline natural",'Location','northwest') 

		%PUNCTELE FUNCTIEI PENTRU DISCRET 	
		file = fopen("sunspot.dat");
		fseek(file, 0, SEEK_SET);
		x_final = zeros(300,1);
		y_final = zeros(300,1);
		for i = 1 : 300
			x_final(i) = fscanf(file, "%lf",1);
			y_final(i) = fscanf(file, "%lf",1);
		endfor
		N_total = 299;
		x=[];
		y=[];
		N = mat(2,1);
		x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
					y(aux) = y_final(i);
					aux = aux +1;
				endif
			endfor
			x = x + 1700;
		%vectorul in care voi interpola cele 1001 puncte pentru fiecare
		%indice de la 2 la 10
	
		yL = zeros(N_total + 1,1);

		%pentru fiecare polinomiala voi calcula cele 1001 puncte
		% pentru a determina eroare
		for k = 1 : N_total+1
		
			for i = 1 : length(x)
				produs = 1;
				
				for j = 1 : length(x) ;
					if i ~= j
						%calculez multiplicatorul lagrange pentru
						%fiecare din cele 1001 puncte 
						produs = produs * (x_final(k)-x(j))/(x(i) - x(j));
					endif
				endfor
				%de fiecare data adun la solutie multiplicatorul
				%lagrange in punctul x_final(k) 
				yL(k) = yL(k) + produs * y(i);
			endfor	
		endfor
		
		
		%Newton
		N  = mat(2,2);
		%x  -  Abscisele celor N + 1 puncte
		x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
				y(aux) = y_final(i);
				aux = aux +1;
				endif
				
			endfor
			x = x + 1700;
		
		
		yN = zeros(N_total + 1,1);
		
		yy = y;
		n = length(yy);
		for i = 1 : n-1
			yy(i+1 : n) = (yy(i+1:n) - yy(i)) ./ (x(i+1:n)-x(i));
		
		endfor
		
		for k = 1 : N_total+1
			prd = 1;
			
			for j = 2 : n 
				prd = (x_final(k) - x(j-1)) * prd;
				c(j) = prd * yy(j);
			endfor
			yN(k) = sum(c);			
		endfor	
		
		
		
		%Fourrier
		
		%x si y cele N + 1 puncte in care voi face interpolarea
		% la fiecare pas 
		N= mat(2,6);	
		x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
				y(aux) = y_final(i);
				aux = aux +1;
				endif
				
			endfor
			x = x + 1700;
		%yN voi retine cele o mie unu puncte pe care le voi afla
		% cu ajutorul interpolantului pe care il calculez la fiecare
		%pas , am nevoie de acest yN pentru a determina eroarea functiei
		yF = zeros(N_total + 1,1);
			
		m = (length(x)-1)/2;
		%initializam cu 0 cei doi vectori de coeficienti a si b 
		a=zeros(1,m);
		b=zeros(1,m);
		
		%calculam coeficientii a
		for k = 1 : m+1
			bufer = 0;
			for j = 1 : 2 * m 
				bufer = bufer + y(j) * cos((k-1)*x(j));
			endfor
		a(k) = 1/m * bufer;
		endfor
		
		%calculam coeficientii b 
		% la b primul element este 0
		b(1) = 0 ;
		for k = 2 : m 
			bufer = 0 ;
			for j = 1 : 2 *m 
				bufer = bufer + y(j) * sin((k-1)*x(j));
			endfor
			b(k) = 1/m * bufer;
		endfor
		
		for i = 1 : N_total +1
		
			bufer = 0;
			for k = 2 :  m 
				bufer = bufer + a(k) * cos((k-1) * x_final(i)) + b(k) * sin((k-1) * x_final(i));
			endfor
		 
			
			yF(i) = ( a(1) + a(m+1)  * cos((m+1) * x_final(i)) ) / 2 + bufer;

		endfor
		
		%SPLINE LINEAR
		N= mat(2,3);	
			x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
				y(aux) = y_final(i);
				aux = aux +1;
				endif
				
			endfor
			x = x + 1700;
			ySpl = zeros(N_total + 1,1);
			n = length(x);
			a = zeros(n-1,1);
			b = zeros(n-1,1);
			
				%Calculez coeficientii a si b 
				for i = 1 : n-1
					a(i) = (y(i+1) - y(i)) / (x(i+1) - x(i));
					b(i) = (x(i+1) * y(i) - x(i) * y(i+1)) / (x(i+1) - x(i));
				endfor
			%In acest for sunt calculate toate cele 1001 puncte
			%ale functiei cu ajutorul polinomului de itnerpolare
			%de la pasul curent 	
			for k = 1 : N_total+1
				
				for i = n-1 :-1 : 1
					%Daca punctul pe care doresc sa il aflu
					% l-am folosit deja in interpolare , nu mai este
					%nevoie sa verific conditiile si sa il calculez
					%deoarece deja ii stiu valoarea 
					if x(i) == x_final(k)
						ySpl(k) = y(i);
						break;
					endif
					if x_final(k) > x(i) && x_final(k) < x(i+1)
						ySpl(k) = a(i) * x_final(k) + b(i);
						break;
					endif
				
				endfor							
		
			endfor
			
			%SPLINE NATURAL
			N= mat(2,4);	
			x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
				y(aux) = y_final(i);
				aux = aux +1;
				endif
				
			endfor
			x = x + 1700;
			ySpg = zeros(N_total + 1,1);	
			
			n = length(x);
			%Primul parametru ai este chiar vectorul y 
			%Restul (b c d ) urmeaza a fi calculati
			%Mai intai vom determina c ul conform metodei prezentate
			%la curs , dupa care un ii vomdetermina si pe ceilalti 
			%doi ( b si d cu ajutorul lui c )
			a = y;
			h = zeros(1,n-1);
			for i = 1 : n-1	
				h(i)= x(i+1) - x(i);
			endfor
			%bb aa si cc sunt diagonalele matricei tridiagonale
			%iar dd este "rezultatul" 
			b1 = zeros(1,n);
			d1 = zeros(1,n);
			a1 = zeros(1,n-1);
			c1 = zeros(1,n-1);
			
			b1(1) = 1; b1(n) = 1;
			d(1) = 0;  d(n) = 0;
			%construim diagonala matricei simetrice si
			%%dd care este "rezultatul" atunci cand aplicam
			%Thomas 
			for i = 2 : n-1
				b1(i) = 2 * h(i-1) +  2 * h(i);
				d1(i) = 3 * (y(i+1) - y(i)) /h(i) - 3 * (y(i) - y(i-1)) / h(i-1);
			endfor
		
			%termenii tridiagonali ai matricei 
			%ii modificam pentru a putea aplica metoda thomas 
			a1=h(1:n-2);
			c1=h(2:n-1);
			a1(n-1) = 0;
			c1 = [0 c1];
			%rezolvam sistemul cu ajutorul metodei Thomas
			c1(1) = c1(1) / b1(1);
			d1(1) = d1(1) / b1(1);
			
			
			for i = 2 : n-1
				temp = b1(i) - a1(i) * c1(i-1);
				c1(i) = c1(i) / temp;
				d1(i) = (d1(i) - a1(i) * d1(i-1))/temp;
			endfor
			%c1 ..... cn sunt solutiile ecuatiei 
			c(n) = d1(n);
			for i = n-1 : -1 : 1
				c(i) = d1(i) - c1(i) * c(i+1);
			endfor
			%pentru calculul parametrilor vom transforma
			%totul in functie de ci
			for i = 1 : n-1
				d(i) = (c(i+1) - c(i)) / (3 * h(i) );
				b(i) = (a(i+1) - a(i)) / h(i) - h(i) * (2 * c(i) + c(i+1)) /3;
			endfor
			
			for k = 1 : N_total +1
			
			for i = n-1 : -1 : 1
				%dupa ce am gasiti cele mai mari valori care satisfav
				%conditia calculam y in punctul k cu ajutrul interpolarii
				%%la momentul actual dupa care parasim forul si calculam
				%y in urmatorul punct
				if x_final(k) > x(i) && x_final(k) <= x(i+1)
					ySpg(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x(i)) ^ 2 + d(i)* (x_final(k) - x(i))^3;
				break;
				endif
			endfor 
			
			endfor
			
			%SPLINE TENSIONAT 
			%initializez punctele cu ajutorul carora voi construi 
			%la fiecare pas polinomul de interpolare
			N= mat(2,5);	
			x = floor(linspace(1,300,N+1));
			aux = 1;
			for i = 1 : 300
				if x(aux) == i
				y(aux) = y_final(i);
				aux = aux +1;
				endif
				
			endfor
			x = x + 1700;
			%vectorul in care voi retine punctele 
			%pe care le voi determina cu ajutorul polinomului de interp
			%ce rumeaza sa fie construit 
			ySpt = zeros(N_total + 1,1);	
			
			n = length(x);
			%Primul parametru pe care il cunoastem de la inceput
			%este a 
			a = y;
			h = zeros(1,n-1);
			for i = 1 : n-1	
				h(i)= x(i+1) - x(i);
			endfor
			%Initializam cu 0 diagonalele matricei tridiagonale 
			b1 = zeros(1,n);
			d1 = zeros(1,n);
			a1 = zeros(1,n-1);
			c1 = zeros(1,n-1);
			%Derivatele la capete sunt cele enuntate in cerinta
			%temei 
			dy1 = ( y(2) - y(1) )/ (x(2) - x(1));
			dyn = ( y(N+1) - y(N)) / (x(N+1) - x(N));
			
			b1(1) = 2 * h(1); b1(n) = 2 * h(n-1);
			d(1) = 3 * (a(2) - a(1)) / h(1) - 3 * dy1;
			d(n) = 3 * dyn - 3 * (a(n) - a(n-1)) / h(n-1);
			
			for i = 2 : n-1
				b1(i) = 2 * (h(i-1) + h(i));
				d1(i) = 3 * (a(i+1) - a(i)) /h(i) - 3 * (a(i) - a(i-1)) / h(i-1);
			endfor
		
			a1=h;
			c1=h;
			%Calculez c ul cu ajutorul met Thomas
			c1(1) = c1(1) / b1(1);
			d1(1) = d1(1) / b1(1);
			
			for i = 2 : n-1
				temp = b1(i) - a1(i) * c1(i-1);
				c1(i) = c1(i) / temp;
				d1(i) = (d1(i) - a1(i) * d1(i-1))/temp;
			endfor
			
			c(n) = d1(n);
			for i = n-1 : -1 : 1
				c(i) = d1(i) - c1(i) * c(i+1);
			endfor
			
			%Pentru calculul parametrilot vom transforma
			%totul in functie de ci
			for i = 1 : n-1
				d(i) = (c(i+1) - c(i)) / ( 3 * h(i) );
				b(i) = (a(i+1) - a(i)) / h(i) - h(i) * (2 * c(i) + c(i+1)) /3;
			endfor
			
		for k = 1 : N_total +1
			%Odata determinati toti parametrii calculam valoarea functiei
			%in toate cele 1001 puncte cu ajutorul polinomului de
			%interpolarea  , la fiecare as 
			for i = n-1 : -1 : 1
				if x_final(k) > x(i) && x_final(k) <= x(i+1)
					ySpt(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x(i)) ^ 2 + d(i)* (x_final(k) - x(i))^3;
					break;
				endif
			endfor 
		endfor


		subplot(2,1,2)
		hold on 
		title("Graficul pentru evaluarea discreta")
		plot(x_final,yN,'r');
		plot(x_final,yL,'g');
		plot(x_final,yF,'y');
		plot(x_final,ySpl,'b');
		plot(x_final,ySpt,'k');
		plot(x_final,ySpg,'m');
	
		legend("Newton","Lagrange","Fourrier","Spline Linear","Spline tensionat","Spline natural",'Location','northwest')
endfunction 
