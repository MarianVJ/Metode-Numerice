function P = ValoriPolinoame(d, s, val_lambda)

	%calculam valorile pentru primele 2 polinoame
	P(1) = 1;
	P(2) = d(1) - val_lambda;
	%aflam numarul n pentru a sti cate iteratii sa facem
	n = length(d);
	%pentru ca problema sa convearga corect
	%trebuie ca indicii sa corespunda atat pentru P cat si
	%pentru d si s , asa ca mai adaugam un 0 la inceputul
	%lui d si s , cu alte cuinte shiftam elementele cu o pozitie
	d = [0 ; d];
	s = [0 ; s];
	%cu un for parcurgem elementele de la 3 pana la n+1
	%deoarece in total sunt n+1 elemente si primele doua au
	%fost deja determinate si cu ajutorul formulei
	%calculam si restul polinoamelor
	for i = 3 : n+1
		P(i) = (d(i) - val_lambda) * P(i-1) - s(i-1)^2  * P(i-2);
	endfor

endfunction
