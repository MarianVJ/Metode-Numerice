function vp = CalculezValProprii(d, s, m, tol)
	%verific daca valoarea pentru m este corecta
	%daca este prea mare , o modific
	if m > length(d)
		m = length(d);
	endif
	%apelez functia creeata anterior pentru a afla
	%intervalele intre care trebuie sa caut cu ajutorul
	%metodei bisectiei valorile proprii
	r = IntervaleValProprii(d, s, m);
	%parcurc pana la penultima valoare pentru ca eu
	%mereu voi cauta intre valoarea actuala si cea din fata
	%in total m valori ( exact cate am nevoie ) deoarece
	%vectorul r are m+1 valori ( pentru m intervale)
	for i = 1 : length(r)-1
		%memorez in a si b capetele initiale ale intervalului
		a = r(i);
		b = r(i+1);
		%in ca mijlcul intervalului initial
		c = (a + b)/2;
		%cat timp diferenta dintre capete este mai mica
		%decat toleranta primit ca parametru caut valoarea
		while b - a > tol		
			%aflu numarul de valori proprii mai mici ca c
			%pentru a stii daca sa caut mai sus sau mai
			%jos valoarea pentru intervalul curent
			nr = NrValProprii(d,s,c);
			%daca nr este mai mic decat i atunci
			%trebuie sa caut mai sus in interval 
			%si modific a-ul 
			if (nr < i)
				a = c;
			else
				b = c;
			endif	
			%mijlocu intervalului ce trebuie recalculat la fiecare pas
			c = (a + b) / 2;
		endwhile
		% la final dupa ce am gasit valoarea proprie trebuie
		%sa o adaug in vectorul nostru de valori proprii vp
		vp(i) = c;	
	endfor
endfunction
