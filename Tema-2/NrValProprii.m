function numvp = NrValProprii (d, s, val_lambda)
	%initializez numvp de la 0
	numvp = 0;
	%apelez functia creeata la exercitiul anterior
	%pentru a sti valoarea polinoamelor
	P = ValoriPolinoame(d, s, val_lambda);
	%aflu numarul n 
	n = length(d);
	%parcurg de la primul pana la penultimul element
	% ( sunt n+1 elemente)
	for i = 1 : n
		%daca nu este 0 si pot compara cu propriul semn
		%compar 
		if P(i) ~= 0
			if sign(P(i)) ~= sign(P(i+1))
				numvp = numvp +1;
			endif
		else
			%altfel daca valoarea actuala este 0 compar
			%cu semnul polinomului anterior
			if sign(P(i-1)) == sign(P(i+1))
				numvp = numvp + 1;
			endif
		endif
	endfor
endfunction
