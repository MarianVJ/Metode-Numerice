function N = eval_interpolator_c(tip,eps)


%INAINTE de a incepe tema vreau sa pun codul foarte nemodularizat
%si poate greu de citit pe seama  cerintei care ne precizeaza ca
%nu trebuie sa existe alte functii in afara de cele 4
%Enunt din care eu am dedus faptul ca nu trebuie sa am alte functii
%Am vazut prea tarziu pe forum ca puteam folosi functii auxiliare , acest
%Din aceasta cauza codurile pentru cele 6 interpolari 
% in loc sa apara intr o singura functie , specifica interpolarii
%A trebuie sa o rescriu de fiecare data atat in functia de 
%evaluare in continuu , discret si atunci cand trasez grafic.
%Mentionez faptul ca am facut acest lucru care este ineficient
%deoarece am vrut sa respect intocmai cerinta 



%Cele 1001 puncte in care eu am valorile functiei atat pentru 
%abscise cat si pentru ordonate 
%si cu ajutorul carora calculez punctele folosind interpolantii
%dar de asemenea folossc f_final la fiecare pas , atunci cand trebuie
%sa calculez eroarea ( cand fac diferenta dintre y ul obtinuit de mine
%si cel real)
N_total = 1000;
x_final = linspace(-pi,pi,N_total+1);
y_final = exp(3 * cos(x_final)) / (2 * pi * besseli(0,3));


switch(tip)
%LAGRANGE
case 1 
	oldEp= -Inf;
	
	for ind  = 2 : 9
		
		%n ia valori de la 4 la 512
		N  = 2^ind;
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
		
		%Calculez eroarea
		h = 2 * pi / (N_total+1);
		Ep = 0;
		%fac suma patratelor diferentelor
		for k = 1 : N_total + 1
			Ep = Ep +(y_final(k) - yL(k) )^2;
		endfor
		
		Ep = Ep * h;
		Ep = sqrt(Ep);
		%daca converge , atunci parasesc functia is N va avea
		%valoarea N-ului curent
		if (abs(Ep-oldEp) < eps)
			return ;
		endif 
	
		%Daca eroarea incepe sa fie din ce in ce mai mare
		%ma opresc din cautat si N va avea valoarea Inf conform cerintei
		if ind > 2
			if(Ep-oldEp > 0)
				N = Inf;
				return
			endif
		endif
		 
		%fostul Ep va fi noul Ep  
		oldEp = Ep;
		endfor
	
%NEWTON 
case 2
	oldEp = -10;
	for ind  = 2 : 9

		N  = 2^ind;
		%x  -  Abscisele celor N + 1 puncte
		x = linspace(-pi,pi,N+1);
		%y - ordonatele celor  N + 1 puncte
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
		
		%Vectorul in care voi tine cele 1001 puncte pe care
		%le voi calcula cu ajutorul polinomului de interpolare
		%construit de mine la fiecare pas 
		yN = zeros(N_total + 1,1);
		F = y;
		n = length(F);
		%Calculam diferentele divizate F2....Fn
		%iar F1 va fi chiar y(1) 
		for i = 1 : n-1
			F(i+1 : n) = (F(i+1:n) - F(i)) ./ (x(i+1:n)-x(i));
		endfor
		
		for k = 1 : N_total+1
			prd = 1;
			%prd va fi initial 1 , iar la fiecare pas
			% va fi produsul anterior (x - x1) (x-x2)...
			for j = 2 : n 
				prd = (x_final(k) - x(j-1)) * prd;
				%In c(j) retinem fiecare produs  F1[..] * (x-x0)..
				c(j) = prd * F(j);
			endfor
			%La final yN(k) va fi suma produselor de tipul
			%F1[x0...xn] (x-x0) (x-x2)...(x-xn)
			yN(k) = sum(c);			
		endfor
		%calculam eroarea 
		h = 2 * pi / (N_total+1);
		Ep = 0;
		for k = 1 : N_total + 1
			Ep = Ep +(y_final(k) - yN(k) )^2;
		endfor
		Ep = Ep * h;
		Ep = sqrt(Ep);
		%Conditia de convergenta a interpolantului 
		if (abs(Ep-oldEp) < eps)
			return ;
		endif 
		%Daca eroarea incepe sa creasca in loc sa scada, atunci interpolantul
		%nu converge
		if(ind > 2)
			if(Ep-oldEp > 0)
				N = Inf;
				return
			endif
		endif
		oldEp = Ep;
	endfor	

	
%FOURRIER	
case 6
	oldEp = -10;
	
	for ind = 2 : 9
		%x si y cele N + 1 puncte in care voi face interpolarea
		% la fiecare pas 
		N= 2^ind;	
		x = linspace(-pi,pi,N+1);
		y = exp(3 * cos(x)) / (2 * pi * besseli(0,3));
	
		%yN voi retine cele o mie unu puncte pe care le voi afla
		% cu ajutorul interpolantului pe care il calculez la fiecare
		%pas , am nevoie de acest yN pentru a determina eroarea functiei
		yN = zeros(N_total + 1,1);
			
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
			%in bufer voi retine fiecare suma dintre(ak cos(kx) + bk 
			%sin kx 
			bufer = 0;
			for k = 2 :  m 
				bufer = bufer + a(k) * cos((k-1) * x_final(i))+ b(k) * sin((k-1) * x_final(i));
			endfor
		 
			%calculam y odata ce stim si suma calcullata la pasul anteior r
			%si pe care o avem salvata in variabila bufer, si
			%care este de fiecare data alta pentru
			%fiecare x_final(i)
			yN(i) = ( a(1) + a(m+1)  * cos((m+1) * x_final(i)) ) / 2 + bufer;

		endfor
		%Calcul erorii conform formulei din enunt
		h = 2 * pi / (N_total+1);
		Ep = 0;
		for k = 1 : N_total + 1
			Ep = Ep +(y_final(k) - yN(k) )^2;
		endfor
		Ep = Ep * h;
		Ep = sqrt(Ep);
		%Conditia de oprire in cazul in care eroarea
		%converge catre 0 
		if (abs(Ep-oldEp) < eps)
			return ;
		endif 
		%Daca eroarea incepe sa creasca parasesc functia
		if ind > 2
			if(Ep-oldEp > 0)
				N = Inf;
				return
			endif
		endif
		%Initializez vechea eroare cu eroare de la pasul curent 		 
		oldEp = Ep;
	endfor 

	%SPLINE LINEAR
	case 3
	oldEp = -Inf;
		for ind = 2 : 9
		
			N= 2^ind;	
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
			
			h = 2 * pi / (N_total+1);
			Ep = 0;
			for k = 1 : N_total + 1
				Ep = Ep +(y_final(k) - ySpl(k) )^2;
			endfor
			Ep = Ep * h;
			Ep = sqrt(Ep);
			%Conditia de convergenta a interpolantului
			if (abs(Ep-oldEp) < eps)
				return ;
			endif 
	
			%Daca interpolantul creste de la un pas la altul
			%atunci interpolantul diverge
			if ind > 2
				if(Ep-oldEp > 0)
					N = Inf;
					return;
				endif
			endif
		 %Vechea eroare ia valoarea erorii de la pasul curent 
			oldEp = Ep;
			
		endfor
	
	%Natural Spline
	case 4
		oldEp = -Inf;
		for ind = 2 : 9
			%Punctele cu ajutorul carora construiesc
			%plinomul de interpolare la fiecare pas 
			N= 2^ind;	
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
			%b1 a1 si c1 sunt diagonalele matricei tridiagonale
			%iar d1 este "rezultatul" 
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
					ySpg(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x(i))^ 2 + d(i)* (x_final(k) - x(i))^3;
					break;
				endif
			endfor 
			
			endfor
			
			%calculul Erorii la fiecare pas 
			h = 2 * pi / (N_total+1);
			Ep = 0;
			for k = 1 : N_total + 1
				Ep = Ep +(y_final(k) - ySpg(k) )^2;
			endfor
			Ep = Ep * h;
			Ep = sqrt(Ep);
			%conditia de convergenta a interpolantului 
			if (abs(Ep-oldEp) < eps)
				return ;
			endif 
			%Atunci cadn eroarea creste in loc sa scada 
			%interpolantul nu converge
			if ind > 2
				if(Ep-oldEp > 0)
					N = Inf;
					return
				endif
			endif
		 
			oldEp = Ep;
		endfor
	
	%SPLINE CUBIC
	case 5
		oldEp = -Inf;
		for ind = 2 : 9
			%initializez punctele cu ajutorul carora voi construi 
			%la fiecare pas polinomul de interpolare
			N= 2^ind;	
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
			%construim diagonala matricei simetrice si
			%%dd care este "rezultatul" atunci cand aplicam
			%Thomas 
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
			%c1...cn sunt solutiile ecuatiei de tipul Ac = d1 
			%unde a este o matrice tridiagonala cu diagonalele
			%a1 b1 c1 
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
			%Calculez eroarea la fiecare pas 
			%care este stocata in variabila Ep
			%iar eroarea de la pasul precedent in oldEp
			h = 2 * pi / (N_total+1);
			Ep = 0;
			for k = 1 : N_total + 1
				Ep = Ep +(y_final(k) - ySpt(k) )^2;
			endfor
			Ep = Ep * h;
			Ep = sqrt(Ep);
			%Daca diferenta dintre erori este mai mica decat Epsilon
			%parasesc programul , iar N ul va fi ultimul Nk gasit
			if (abs(Ep-oldEp) < eps)
				return ;
			endif 
			%Altfel daca eroarea va creste de la un pas la altul
			%in loc sa scada, Parasim functia si N va fi infinit
			%conform cerintei 
			if ind > 2
				if(Ep-oldEp > 0)
					N = Inf;
					return
				endif
			endif
		 	%eroarea veche va fi eroarea actuala 
			oldEp = Ep;
		endfor
		
endswitch
 

endfunction 
