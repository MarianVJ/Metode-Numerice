function Z = zigzag(n)
%initial matricea in care calculez este 0
A=zeros(n,n); 
count = 0; % cu count trec prin fiecare numar  ce trebuie adaugat
for s = 2: (2*n) %parcurg sumele indicilor de pe fiecare diagonala
	%daca suma este para eu trebuie sa urc in sus
	% ca sa adaug in matrice
	if mod(s,2) == 0
		%astfel caut indicii care adunati dau s si adaug 
		% pe pozitia corespunzatoare numarul corect
		%de asemenea i ul il parcurg in ordine inversa
		%deoarece valorile cresc
		for i = n : -1 :1
			for j = 1 : n
				if (i+j) == s
					A(i,j) = count;
					count = count+1;
				endif
			endfor
		endfor
	endif
	%daca suma indicilor este para eu treuie sa cobor ca sa 
	%adaug in matrice		
	if mod(s,2) == 1
		%caut indicii care adunati sa dea un numar impar
		% merg cu j ul de la n deoarece
		% pe fiecare din aceste diagonale elementele descresc
		%odata gasit doi indici care insumati sa dea suma
		%dorita , se salveaza pe pozitia dorita numarul count
		%dupa care se incrementeaza si acesta cu 1
		for i = 1 : n
			for j = n : -1:1
				if (i+j) == s
					A(i,j) = count;
					count = count+1;
				endif
			endfor
		endfor
	endif						
endfor
%in final salvez in Z numarul corespunzator 
Z=A;
endfunction

