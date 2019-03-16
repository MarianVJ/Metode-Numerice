function r = IntervaleValProprii(d, s, m)
	%verificam daca m este mai mare decat lungimea
	% lui d, daca da atunci acesta va fi egal 
	%cu lungimea lui d
	if m > length(d)
		m = length(d);
	endif
	%apelam functia LimiteValProprii construita
	%la subpunctele anterioare pentru a vedea 
	%limita superioara si inferioara a valorilor
	%proprii
	[lim_inf lim_sup] = LimiteValProprii(d,s);
	%primul element al lui r va fi limita inferioara
	%iar pe pozitia m+2 va fi limita superioara , dar 
	%adaugam pe aceasta pozitie acest element
	%doar pentru a usura calcularea elementului
	%de pe pozitia m+1 , la final r(m+2) va fi sters
	r(1) = lim_inf;
	r(m+2) = lim_sup;

	for k = m : -1 : 1
		%aflam mijlocul intervalului r(1), r(k+2)
		mij = ( r(k+2) + r(1) ) / 2;
		%se calculeaza lungimea intervalului
		h = r(k+2) - mij;
		%k nu are cum sa fie 0 niciodata ( datorita
		%forului ) asa ca luam valoarea numvp , pentru
		%a incepe cautarea mijlocului ( cu alte cuvintea
		%cautarea elementului r(k+1)
		numvp = 0;
		%cat timp nu am gasit
		while numvp ~= k
			%se calculeaza numarul de valori proprii mai 
			%mici decat valoarea mij
			numvp = NrValProprii(d,s,mij);
			%se actualizeaza mij , daca numvp este
			%mai mica sau mai mare strict decat k
			h = h / 2;
			if numvp < k
				mij = mij+h;
			else if numvp > k
					mij = mij-h;
				 endif
			endif
		endwhile
		%la final dupa ce se paraseste while-ul vom avea
		%stocata in variabila mij , valoarea pentru r(k+1)
		r(k+1) = mij;
	endfor
	%nu uitam sa stergem elementul pe care l-am adaugat
	%pe pozitia m+2 pentru a afla elementul
	%de pe pozitia m+1
	r = r(1 : m+1);
endfunction
