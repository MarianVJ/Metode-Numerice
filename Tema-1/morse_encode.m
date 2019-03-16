function x = morse_encode(c)
%inainte sa incep codarea codului
%transform literele mici in litere mari in cazul in care exista
c=upper(c);
%daca exista mai mult de o litera functia nu poate opera
% si se returneaza steluta
if length(c) > 1
	x = '*';
else
	%altfel pot incepe sa codific litera data
	%in arb voi tine arborele meu pe tot parcursul 
	%functiei 
	arb = morse();
	%in sir voi tine codul coresp literei
	sir = '';
	%nod este initial radacina dar pe parcursul prooblemei isi schimba
	%pozitia
	nod = arb;
	%nr si sw sunt variabile ajutatoare pentru a determina
	%nivelul din arbore pe care ma aflu si sw pentru a determina
	%daca nu exista caracterul cautat
	nr = 0;
	sw=0; % astfel cat am unde sa caut 
	while (sw ~= 2)
		%verific daca nu cumva am gasit elementul si ies din while
		%dar salvez in x sirul dorit
		if nod{1} == c
			x = sir;
			break;
		endif
			%daca am cum sa merg in stanga merg salvez in sir 
			%faptul ca am mers in stanga, dar trec si cu nod
			%si in nr faptul ca am trecut la un nou nivel
		if length(nod{2}) ~= 0 
			sir = [sir '.'];
			nod = nod{2};
			nr = nr+1;
		else %altfel aceleasi operatii le fac daca am 
			%cum sa merg in dreapta (in cazul cand raman fara elemente 
			% pe stanga
			if length(nod{3}) ~= 0
				sir = [sir '-'];
				nod = nod{3};
				nr = nr+1;
			else
			%altfel daca nu am nici stanga nici dreapta 
			%inseamna ca am ajuns pe o frunza care sigur nu 
			%este litera cautata asa ca o sterg din arbore
				nod = arb;	
				%in ca salvez pozitiile pe care trebuie sa 
				%merg pentru a sterge elementul din arbore
				k=[];
				for i =1: length(sir)
					if sir(i) == '.'
						k(i) = 2;
					else
						k(i) = 3;
					endif
				endfor
			%daca sunt pe niv 4 sterg elementul de pe 4
				if nr  == 4 
					arb{k(1)}{k(2)}{k(3)}{k(4)} = {};
				endif	
			%daca sunt pe nivelul 3 sterg elemetnul de pe 3
				if nr  == 3 
					arb{k(1)}{k(2)}{k(3)} = {};
				endif
			%daca sunt pe nivelul 2 sterg elementul de pe 2
				if nr  == 2
					arb{k(1)}{k(2)} = {};
				endif
			%daca sunt pe nivelul 1 sterg elementul de pe 1
			%si incrementez sw ( cand acesta va fi doi inseamna 
			%ca litera daca nu se afla in arbore ( adica acesta va fi 
			%gol)
				if nr  == 1
					sw=sw+1;
					arb{k(1)} = {};
				endif
			%aduc la 0 atat nivelul cat si sirul va fi vid
			% iar nod va fi din nou in vaful arborelui
				nr = 0;
				nod = arb;
				sir = '';
			endif
		endif
	endwhile
	%daca sw va fi doi inseamna ca am sters toate elementele din 
	%arbore deci nu am gasit si x este * , altfel acesta a fost deja
	%salvat cand a fost gasit (in while )
	if sw == 2
		x = '*';
	endif
endif
endfunction
