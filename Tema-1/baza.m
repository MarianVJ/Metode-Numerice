function r = baza(sursa,b1,b2)
%flag ca sa verific daca sunt caractere invalide
flag=0;
%initializez r-ul cu vid (r- sirul de returnat)
r='';
%vector cu ajutorul caruia voi introduce mai usor si 
%voi prelucra stringurile pe care trebuie sa le transform
v="0123456789abcdefghijklmnopqrst";
%transform eventualele litere mari in litere mici
sursa=lower(sursa);
%verific daca exista caractere care nu apartin bazei b1
for i = 1:length(sursa)
	if 10+sursa(i) - 'a' > b1-1 
	    flag = 1;
	endif
endfor
%in cazul in care numarul este scris intradevar in baza b1 incep transformarile
if flag == 0
%retin nuamrul de caractere din sursa
n = length(sursa);
%bzece este un vector ("de numere mari") in care voi retine 
%echivalentul stringului in baza 10 , intiial acesta este 0
bzece(1) = 2;
bzece(2) = 0;

for i  = 1 : n
	sw = 0;
	for j = 1 : length(v)
		if v(j) == sursa(i)
			%sw este pentru a verifica daca litera este cumva 
			%majuscula ( in cazul in care nu e 1 inseamna ca 
			% este posibil sa fie majuscula
			sw = 1;
			%variabila cu ajutorul careia salvez numarul ce trebuie
			%adunat la vectorul meu ce memoreaza un numar mare
			var = (j-1) ;
			%in a salvez variabila var , adica o pun intr un vector
			a(1) = 1;
			if var == 0
				a(1) = 2;
				a(2) = 0;
			else
				while var > 0
					a(1) = a(1) + 1;
					a(a(1)) = mod(var,10);
					var = (var - a(a(1)) ) / 10;
				endwhile
			endif
	% cu un for fac cele n iteratii pentru a salva in vectorul
	%a numarul ce urmeaza a fi convertit mai apoi in baza 10
	%am ales sa l un intr un vector deoarece acesta poate fi mare
	%din start
		for z = 1 : n-i
			bufer = 0;
			for s = 2 : a(1)
				a(s) = a(s) * b1+bufer;
				bufer = (a(s) - mod(a(s),10))/10;
				a(s) = mod (a(s),10);
			endfor
				
				%cat timp exista ceva de adaugat la final
			while (bufer > 0)
				a(1) = a(1) +1;
				a(a(1)) = mod(bufer,10);
				bufer = (bufer-mod(bufer,10))/10;
			endwhile
				
		endfor 
			%in aux salvez nnumarul in baza b1	
				aux = a;			
			 % acest bufeer ne va ajuta la adunarea numerelor
			 %mari	
			%bufer este o variabila care ma va ajuta in converisa
			%unui numar mare din 
			bufer = 0;
			% cele doua numere cu care urmeaza sa lucrez 
			% le aduc la acleasi numar de "cifre" adaugand zerouri
			% la cel mai mic ( pe prima pozitie se afla nr de cifre)		
			if aux(1) > bzece(1)
				for k = (bzece(1)+1) : aux(1)
					bzece(k) = 0;
				endfor
				bzece(1) = aux(1);
			else
				for k = (aux(1) + 1) : bzece(1)
			 		aux(k) = 0;
			 	endfor
			 	aux(1) = bzece(1);
			endif
			%adunarea propriu-zisa a numerelor mari
			for k = 2 : bzece(1)
				bzece(k) = bzece(k) + aux(k) + bufer;
				bufer = (bzece(k) - mod(bzece(k),10))/10;
				bzece(k) = mod(bzece(k),10); 
			endfor
			%modific cel mai mare rang in cazul in care este
			% cazul si maresc de asemenea si numarul de cifre
			if (bufer > 0)
				bzece(1) = bzece(1) +1;
				bzece(bzece(1)) = bufer;
			endif
		endif
	endfor
endfor
% in c salvez sirul  in ordine iversa ( din cauza algoritmului)
sir='';
i=1; % cu i tin pozitia in care trebuie sa adaug mereu in c


	while bzece(1) ~= 1
	% in R retin restul
		R=0;
		for k = bzece(1):-1:2	
			R = mod((10*R+bzece(k)),b2); 	
		endfor
	%odata calculat restul incep sa caut ce caracter din baza b2 i se
	%potriveste in vectorul v si astfel il adaug in sirul c pe poztia 
	%corespunzatoare
		for j = 1 : length(v)			
			if j-1 == R;	
				sir(i) = v(j);
			endif
		endfor
	%dupa care numarul meu bzece ia valoarea catului dintre el si 
	% baza b2 ( conform algoritmului de transformare a unui numar
	%din baza 10 intr-o alta baza
		R=0;
		for k=bzece(1):-1:2
			R = 10*R+bzece(k);
			bzece(k) = (R - mod(R,b2) )/b2;
			R = mod(R,b2);
		endfor % in while verific daca mai sunt zerouri ce trebuiesc
		%eliminate din numar si de asemenea redus nr de cifre
		while  bzece(bzece(1)) == 0 && bzece(1) > 1
			bzece(1) = bzece(1)-1;
	 	endwhile
	i=i+1;
	endwhile

	for i = length(sir) : -1 :1
		%salvez cifrele numarului in ordinea corecta
		r ( length(sir) - i + 1) = sir(i);
	endfor

else
printf("Invalid Number"); %mesaj de eroare in aczul in care nuamrul nu este  
endif					% in baza corespunzatoare	

endfunction
