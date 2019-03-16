function [valp vecp] = PutereInv(d, s, h, y, maxIter, tol)
	
	%copii pentru valorile initaiale ale lui d si s
	dd = d;
	ss = s;
	%initializam valoarea proprie cu 0
	valp = 0;
	%sunt copii pentru cele 3 coloane ale matricii
	% cu ajutorul careia vom aplica Thomas , in timp doar 
	%am folosit si o variabila cc deoarece este mult mai usor sa lucram
	%cu metoda din laborator daca avem 3 variabile, pentr fiecare
	%diagonala/subdiagonala in parte
	bb = d;
	aa = [0  s];	
	cc = s;
	%valoarea in care va fi stocata valoare proprie la fiecare pas
	%o initializam cu o 
	L=0;
	%conditia de iesire din metoda bisectiei ( prima conditie), cea de-a
	%doua fiind pusa in finalul while-ului
	while maxIter > 0
		%d nu va mai avea valorile pe care le-a primit ca parametru
		% el va fi egal cu aproximatia lui vectorului propriu la fiecare pas
		d = y; 
		%in aceasta Thomas valorile diagonalelor se modifica , astfel
		% le vom intializa la fiecare pas cu valorile originale 
		%pentru ca programul sa convearga
		b = bb;
		a = aa;
		c = cc;
		%decrementam maxiter
		maxIter = maxIter - 1;
		%modificam diagonala principala ( aceasta modificare
		%apartine de metofa puterii inverse , 
		b = b - ones(1,length(b)) * h;
		%acum matricea tridiagonala are valorile exact cu care 
		%putem incepe sa afla z-ul la pasul curent
		
		%operatiile la limita
		c(1) = c(1)/b(1);
		d(1) = d(1)/b(1);
		
		%calculam coeficientii pe cazul general
		for i = 2 : length(b) - 1
			temp = b(i) - a(i) * c(i-1);
			c(i) = c(i) / temp;
			d(i) = (d(i) - a(i) * d(i-1)) / temp;
		endfor
		
		%aflam lungimea lui d pentru a afla ultimul coeficient
		n=length(d);
		d(n) = (d(n) - a(n) * d(n-1)) / (b(n) - a(n) *c(n-1));
		%z va fi un vector coloana , asa ca la fiecare pas il
		%vom initializa cu 0 
		z=zeros(n,1);
		%Facem substitutia inapoi pentru rezolvarea sistemului de ecuatii
		z(n) = d(n);
		for i = n - 1 : -1 :1
			z(i) = d(i) - c(i) *z(i+1);
		endfor
		%odata aflat z-ul , aflam y-ul impartind z ul la norma sa
		y=z/norm(z);
		
		%Pentru aflarea valorii proprii este nevoie de a inmulti
		%matricea A la stanga si la dreapta cu y si y transpus
		%cum nu avem voie sa construim matricea A , aici obtinem
		%in variabila aux , produsul dintre y transpus si A
		aux = zeros(1,n);
		for i = 1 : n-2
			aux(i+1) = y(i) *ss(i) +y(i+1) * dd(i+1)+y(i+2) *ss(i+1);
		endfor
		aux(1) = y(1) * dd(1) +y(2) * ss(1);
		aux(n) = y(n) * dd(n)+y(n-1) * ss(n-1);
		 
		 %Iar acum obitnem adevarata valoare a lui L inmultind "produsl
		 %dintre y transpus si" cu y , si astfel obtinem un numar real
		 L = aux * y;	
		 %deplasarea la fiecare pas va fi egala cu , valoarea curenta 
		 % a valorii proprii L 
		 h = L;
		
		%Initializam vectorul aux cu 0 de data aceasta , acest vector
		%'auxiliar' il vom solosi pentru a stoca rezultatul calculului
		%A*vecp -valP*vecp , unde valp este L ( valoare proprie ) , iar
		%vecp este y ( vectorul propriu) 
		aux = zeros(n,1);
		for i = 1 : n-2
		 	aux(i+1) = y(i) *ss(i) +y(i+1) * dd(i+1)+y(i+2) *ss(i+1);
		endfor
		 aux(1) = y(1) * dd(1) +y(2) * ss(1);
		 aux(n) = y(n) * dd(n)+y(n-1) * ss(n-1);
		 aux = aux - y * L;
		 %conditia de oprire a cautarii valorii proprii si a vec
		 %torului propriu
		 if norm(aux) < tol
		 	break
		 endif
		 
	endwhile
	%in final iniatlizam valp si vecp cu valoarea proprie , respectiv
	%vectorul propriu corespunzator datelor de intreare 
	vecp = y;
	valp = L;
	
endfunction
