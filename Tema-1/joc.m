function [] = joc()

function x = verifica_linii_calculator(semn)
	%aceasta functie cauta daca pe fiecare linie exista
	%doua elemente si un loc liber cu semn ul calculatorului
	% astfel daca exista acesta muta in acea pozitie si
	%castiga partida ; initial x este 0 , semn ca nu am gasit
	% o pozitie castigatoare pe coloane
	x = 0;	
	for i = 1 : 3
		for j = 1 :2
			%cazul cand elementele sunt una langa alta
			%si cel de adaugat este pe poz 1 sau 3 ( coloane)
			if tabela(i,j) == tabela (i,j+1) && tabela(i,j+1) == semn
				if j == 2
					if tabela(i,1) > 0 
						tabela(i,1) = semn;
						x=1;
					endif
				else
				 	if tabela (i,3) > 0				
 						tabela(i,3) = semn;	
 						x=1;
 					endif
 				endif					
 			endif	
		%acest if verifica daca poate puta pe pozitia 2 a fiecarei linii
		%desigur in cazul prezent , cel in care cautam sa punem pe o
		%pozitie castigatoare 
 			if x == 0  && tabela(i,2) > 0 && tabela(i,1) == tabela(i,3) && tabela(i,1) == semn	 					
 						tabela(i,2) = semn;	 
 						x=1;				
			endif	
		endfor
	endfor
endfunction

function x = verifica_coloane_calculator(semn)
	%initial x este 0 si va fi incrementat cu 1 daca 
	% se va gasit o pozitie casgtigatoare pe coloane
	x = 0; 
	for j = 1 : 3
		for i = 1 :2
		%cazul in care elementele sunt pe coloana egale
		%iar elementul de adaugat este pe pozitia 1 sau 3 (linia)
		%daca gasesc x ul devine 1 semna ca am gasit o pozitie
		%care sa mi asigure castigul
			if tabela(i,j) == tabela (i+1,j) && tabela (i,j) == semn	 
				if i == 2
					if tabela(1,j) > 0 
						tabela(1,j) = semn;
						x = 1;
					endif
				else
					if tabela (3,j) > 0				
 						tabela(3,j) = semn;	
 						x=1;
 					endif
 				endif
			endif
		%Aici verific cazul in care pozitia castigatoare ar putea
		%fi intre alte doua elemente de acelasi "semn"	
			if x == 0  && tabela(2,j) > 0 && tabela(1,j) == tabela(3,j) && tabela(1,j) == semn	
 				tabela(2,j) = semn;	 
 				x=1;					
			endif					
		endfor
	endfor				
endfunction

function x = verifica_diagonale_calculator(semn)
%x este 0 semn ca nu am gasit o pozitia castigatoare momentan
%va fi incrementat cu 1 in cauzl in care vom gasi una
x = 0;
	%diagonala principala elementul de pe poztiaia 3 3
	if tabela(1,1) ==  tabela(2,2) && tabela(3,3) > 0 && tabela(1,1) == semn
	 	x=1;
		tabela(3,3) = semn;
	 else
	 	%verific elementul de pe diag  principala, pozitia 1 1
		 if tabela(2,2) ==  tabela(3,3) && tabela(1,1)>0 && tabela(2,2) == semn	
		 	x = 1;
			tabela(1,1) = semn;	 
		else
		%verific elementul de pe diagonala secundara pozitia 3 1
		  if tabela(1,3) ==  tabela(2,2) && tabela(3,1)>0 && tabela(2,2) == semn
			x = 1;
			tabela(3,1) = semn;
		else
		%verific elementul de pe diagonala secundara pozitia 1 3
			if tabela(3,1) ==  tabela(2,2) && tabela(1,3) >0 && tabela(2,2) == semn
				x=1;
				tabela(1,3) = semn;
		 	endif
		  endif
		endif
	   endif
endfunction

%Aceasta functii este aproape identica cu cea de verificare_linii_calculator
%singura diferenta este aceeea ca , aceasta cauta sa impiedice victoria
%jucatorului , astfel nu se mai tine cont de natura elementelor asemanatoare
%ele for fi blocate indiferent , pentru ca acesta sa nu castiga
%Pasii sun la fel , doar ca aici nu conteaza natura elementelor
function x = verifica_linii_adversar(semn)
	
	x = 0;	
	for i = 1 : 3
		for j = 1 :2
			if tabela(i,j) == tabela (i,j+1) 	
				if j == 2
					if tabela(i,1) > 0 
						tabela(i,1) = semn;
						x=1;
					endif
				else
					if tabela (i,3) > 0				
 						tabela(i,3) = semn;	
 						x=1;
 					endif
 				endif					
 			endif

 			if x == 0  && tabela(i,2) > 0 && tabela(i,1) == tabela(i,3) 	 
				tabela(i,2) = semn;	 
 				x=1;				
			endif		
		endfor
	endfor
endfunction

%Aceasta functie este aproape identica cu cea de verificare_coloane
%La fel ca si cea pentru linii , nu se mai tine cont de natura 
% elementelor invecinate , aici nu se mai doreste victoria , ci se cauta
% o posibila impiedicare a castigului ., celui care joaca
function x = verifica_coloane_adversar(semn)

	x = 0;
	for j = 1 : 3
		for i = 1 :2
			if tabela(i,j) == tabela (i+1,j) 		 
				if i == 2
					if tabela(1,j) > 0 
						tabela(1,j) = semn;
						x = 1;
					endif
				else
					if tabela (3,j) > 0				
 						tabela(3,j) = semn;	
 						x=1;
 					endif
				endif
			endif	
			if x == 0  && tabela(2,j) > 0 && tabela(1,j) == tabela(3,j)			
 				tabela(2,j) = semn;	 
 				x=1;					
			endif	
		endfor
	endfor		
endfunction

%Aceasta functie este foarte asemanatoare cu cea de verificare_
%diagonale calculator , doar ca aici se doreste impierdicarea
%victoriei oponentului si nu se mai tine cont de semn , 
function x = verifica_diagonale_adversar(semn)

	x = 0;
	if tabela(1,1) ==  tabela(2,2) && tabela(3,3) >0 
		x=1;
	 	tabela(3,3) = semn;
	else
		if tabela(2,2) ==  tabela(3,3) && tabela(1,1)>0
			x=1;
	 		tabela(1,1) = semn;		 
		else
		 if tabela(1,3) ==  tabela(2,2) && tabela(3,1)>0 
		 	x=1;
			tabela(3,1) = semn;
		else
     		if tabela(3,1) ==  tabela(2,2) && tabela(1,3) >0 
				 x=1;
				tabela(1,3) = semn;
			endif
		  endif
	   endif
    endif
endfunction

%Aceasta functie joaca rolul ecranului , si afiseaza 
%mereu intr-o forma usor de recunoscut , situatia jocului
%tabela cu elementele puse pe pozitiile corespunzatoare , si
%pozitiile care unst libere ( 1 2 ..9)
function [] = afisare_tabela(M)
	%citesc valorile numerice din M si le pun in matricea Mat
	%care este o matrice de stringuri , sub o forma usor de 
	%recunoscut , reprezentate sub forma de x si 0 , adica asa
	% cum este normal x este corespunzator lui -1 so 0 lui 0
	Mat= [ '147' ;'258';'369'];
	for i = 1 : 3
		for j= 1 : 3
			if M(i,j) == -1
				Mat(i,j) = 'X';
			else
				if M(i,j) == 0
					Mat(i,j) = '0';
				endif
			endif
		endfor
	endfor
	%Afisarea intr-un mod usor de recunoscut si delimitat de
	%celelalte mesaje care vor mai aparea pe ecran , pentru
	%ca jucatorul sa poata analiza cu atentie miscarile
	printf("----------------\n");
	printf(" %c | %c | %c \n",Mat(1,1),Mat(1,2),Mat(1,3) );
	printf(" %c | %c | %c \n",Mat(2,1),Mat(2,2),Mat(2,3) );
	printf(" %c | %c | %c \n",Mat(3,1),Mat(3,2),Mat(3,3) );
	printf("----------------\n");
endfunction

%variabile in care voi retine numarul de partide castigate de 
%utilizator si respectiv de calculator
scor_pc = 0;
scor_gm = 0;

%tabela pe care se va desfasura intreg jocul
tabela = [1 4 7; 2 5 8; 3 6 9];

%mesaj de inceput la pornirea jocului si mesaje de informare
printf("Bine ai venit !!! Suntem onorati ca ai ales jocul nostru \n \n");
printf("Dupa fiecare comanda va rugam sa apasati tasta Enter ! Va multumim !!!\n \n")
printf("Pentru a parasi jocul apasati tasta 'q' oricand doriti \n \n")

%Se doreste trecerea la joc , si daca nu corespunde 
raspuns = input("Doriti sa incepeti un joc nou ? (da / nu) ",'s');
while raspuns == ['n' 'u'] && raspuns ~= 'q' 
 	%mesaje pentru utilizator pentru a-l informa cum poate parasi
 	%jocul si ca 
 	printf("Pe tot parcursul jocului daca doriti sa parasiti jocul apasati tasta q \n \n  ")
 	raspuns =  input("Pentru a reveni la meniul anterior apasati tasta m ",'s');
 	if raspuns == 'm'
 		raspuns = input("Doriti sa incepeti un joc nou ? (da / nu) ",'s');
 	endif	
endwhile



while raspuns ~= 'q'
	
	%Utilizatorul alege daca vrea sa joaca x sau cu 0 
	% x incepe primul 0 incepe ultimul 
	printf("\nATENTIE!!!!Incepe cel care are semnul x!!!!\n")
	semn = input("Va rugam sa alegeti semnul cu care doriti sa jucati (x / 0) ",'s');
	%daca se apasa q parasesc functia 
	if semn  == 'q'
		break;
	endif
	%se fac setarile pentru modul de joc pe care jocaurl il alege
	%daca nu tasteaza x automat va fi al doilea
	if ( semn  == 'x')
		sgn = -1;
		sgn_pc = 0;
		flagg = 0;
	else
		sgn = 0;
		sgn_pc = -1;
		flagg = 1;
	endif
	%daca avem permisiunea jucatorului inccepem meciul
	if raspuns == ['d' 'a']
		%dupa 5 mutari se ttermina jocul 
		nr = 5;
		%se afiseaza tabela sa stie unde sa mute
		afisare_tabela(tabela);
		while raspuns ~= 'q' && nr > 0
		  	nr = nr - 1;
		  	if flagg == 1
			  	printf("Calculatorul este cel care a facut prima mutare \n")
		  	else
	   			%primesc si execut mutarea jocatorului
				mutare = input('va rugam sa introduceti o mutare valida de la 1 la 9: ','s');
				while length(mutare) == 0 || length(mutare) > 1
					afisare_tabela(tabela);
					printf("Va rugam sa nu apasati enter inainte sa tastati pozitia\n");
					mutare = input('va rugam sa introduceti din nou mutarea ','s');
				endwhile	
				%daca se tasteaza q se paraseste jocul instantaneu	
				if mutare  == 'q' 
					raspuns = 'q';
					break;
				endif
				while mutare  == '0'
					afisare_tabela(tabela);
					printf("Va rugam sa nu alegeti pozitii invalide invalide\n");
					mutare = input('va rugam sa introduceti din nou mutarea ','s');
				endwhile
				%conditie daca mutarea este valida 
				%pana nu se introduce o mutare valid nu se incepe runda
				%din meciul curent
				while (mutare-48 < 0 || mutare-48 > 9) || tabela(mutare-48) < 1 ||length(mutare) > 1 || length(mutare) == 0
				
					afisare_tabela(tabela);
					printf("Pozitia este deja ocupata \n")
					mutare = input('va rugam sa introduceti o mutare valida de la 1 la 9:  ','s');	
					if mutare  == 'q' 
						raspuns = 'q';
						break;
					endif
				endwhile
		
				if mutare  == 'q' 
					raspuns = 'q';
					break;
				endif
			endif
		
		%daca flag este 1 atunci acesta nu va pune primul
		%iar calculatorul isi va face prima mutare	
		%in cazul in playerul alege sa aiba 0
			if flagg  < 1
				tabela(mutare-48) = sgn;		
			else %se face flag -1 si se reincepe mutarea de catre player
				flagg=flagg-2;
			endif	
		%de fiecare data pun in mijloc daca este liber
		if tabela(2,2) == 5
			tabela(2,2) = sgn_pc;
		else
			%cu sw pot verifica oricand daca am facut mutare 
			%adica este 1 sau daca inca trebuie sa fac o mutare
			sw = 0;
			%daca prima mutare a playerului este mijlocul 
			%pun in colt 					
			if 	nr == 4 && tabela(1,1) > 0
				tabela(1,1) = sgn_pc;
				sw = 1;
			endif
			
			%dacam incearca sa puna pe colturi 
			%si sa poata inchide din doua pozitie la mutarea
			%3 pun eu pe laterala si il fortez pe el 
			% sa ma blocheze sau sa piarda
			if nr == 3 && tabela(1,3) == tabela(3,1) && sw == 0 
				tabela(2,1) = sgn_pc;
				sw = 1;
			end
			
			if nr == 3 && tabela(1,1) == tabela(3,3) && sw == 0 
				tabela(2,1) = sgn_pc;
				sw = 1;
			end
				
				
			%daca niciuna din mutarile anterioare nu s au executat
			% incep sa caut mai intai daca pot sa castig
			%daca pot mut pe pozitia castigatoare si marchez
			%faptul ca am mutat
			if sw == 0		
				 sw = verifica_linii_calculator(sgn_pc) ;
			endif
		
			if sw == 0
				sw = verifica_coloane_calculator(sgn_pc);
			endif
			
			if sw == 0
				 sw = verifica_diagonale_calculator(sgn_pc);	
			endif
					
			
			%Daca nu am nicio formatie castigatoare 
			%caut sa il blochez pe utilizator , ca sa castige
			%in cazul in care acesta este la o mutare
			if sw == 0		
				 sw = verifica_linii_adversar(sgn_pc) ;
			endif
		
			if sw == 0
				sw = verifica_coloane_adversar(sgn_pc);
			endif
			
			if sw == 0
				 sw = verifica_diagonale_adversar(sgn_pc);
			endif
			%daca la a treia runda a unui joc 
			%coltul din dreapta sus este liber
			%pun acolo
			if sw == 0 && nr == 3 && tabela(1,3) > 0
				sw = 1;
				tabela(1,3) = sgn_pc;
			endif
			
			%daca nu am reusit nici sa il blochez pe el
			%nici sa castig o sa mut pe unul dintr colturle 
			%libere
			if sw == 0
			
			 	if tabela(1,3) > 0
			 		tabela(1,3) = sgn_pc;
			 		sw=1;
			 	endif
			 	if tabela(3,1) > 0 && sw == 0
			 		tabela(3,1) = sgn_pc;
			 		sw = 1;
			 	endif
			 	if tabela(3,3) > 0 && sw == 0
			 		tabela(3,3) = sgn_pc;
			 		sw = 1;
			 	endif
			 	%altfel daca nu sunt potiziti libere nici pe colturi
			 	%o sa mut pe prima pozitie libera in sensul de parurgere
			 	%al unei matrice
			 	if sw == 0
			 	 for i = 1:3
			 	 	for j =1:3
			 	 		if tabela(i,j)  > 0 && sw ==0
			 	 			tabela(i,j)  = sgn_pc;
			 	 			sw=1;
			 	 		endif
			 	 	endfor
			 	  endfor
			 	 endif
			endif
			
						
		endif	
							

	%verific daca cineva a castigat sau a pierdut
	afisare_tabela(tabela);
	t=tabela;
	for i = 1: 3
		if t(i,1) == t(i,2) && t(i,2) == t(i,3) 
			if t(i,1) == sgn_pc
				printf("Calculatorul a castigat\n");
				scor_pc = scor_pc+1;
				else
				printf("BRAVOO AI CASTIGAT\n");
				scor_gm = scor_gm+1;
				endif
			nr=0;
			endif		
	endfor
	
	for i = 1: 3
		if t(1,i) == t(2,i) && t(2,i) == t(3,i) 
			if t(1,i) == sgn_pc
				printf("Calculatorul a castigat\n");
				scor_pc = scor_pc +1;
				else
				printf("BRAVOO AI CASTIGAT\n");
				scor_gm = scor_gm+1;
				endif
			nr=0;
			endif
	endfor
	
	if t(1,1) == t(2,2) && t(2,2) == t(3,3)
		if t(1,1) == sgn_pc
				printf("Calculatorul a castigat\n");
				scor_pc = scor_pc+1;
				else
				printf("BRAVOO AI CASTIGAT\n");
				scor_gm = scor_gm+1;
				endif
			nr=0;	
		endif
	
		if t(1,3) == t(2,2) && t(2,2) == t(3,1)
			if t(2,2) == sgn_pc
				printf("Calculatorul a castigat \n");
				scor_pc = scor_pc+1;
			else
				printf("BRAVOO AI CASTIGAT \n");
				scor_gm = scor_gm+1;
			endif
			nr = 0;	
		endif
	  endwhile
		%tabela revine la normal pentru un eventual joc
	  tabela= [1 4 7; 2 5 8; 3 6 9];
	 else
	 	printf("--------------------------\n");
	 	printf("Pentru ca jocul sa inceapa trebuie sa tastati 'da' \n");
	 	printf("Orice alta combinatie de taste nu va porni jocul\n");
	 	printf("Va rugam sa tastati cu atentie ! \n");
	 	printf("--------------------------\n");
	endif
		%un filtru in cazul in care se apasa q sa iasa din joc
		if raspuns  == 'q' 
			break;
		endif
	%afisez scorul dupa fiecare meci
	printf("Situatia partidelor este urmatoarea \n\n");
	printf("Calculator : %d ----- Player : %d\n\n",scor_pc,scor_gm);

	raspuns = input("Doriti sa incepeti un joc nou ? (da / nu) ",'s');

	while length(raspuns) == 0
		printf("Va rugam sa nu apasati enter inainte sa tastati optiunea dorita\n");
		raspuns = input('Doriti sa incepeti un joc nou? (da / nu) ','s');
	endwhile
	%in cazul in care utilizatorul nu vrea sa mai joace 
	%si a uitat cum sa iasa ii reamintesc
	while raspuns == ['n' 'u'] && raspuns ~= 'q'
	 	printf("Pe tot parcursul jocului daca doriti" );
	 	printf("sa parasiti jocul apasati tasta q \n \n  ");
	 	raspuns =  input("Pentru a reveni la meniul anterior apasati tasta m ",'s'); %verific daca aceste doreste sa mai joace un meci
	 	if raspuns == 'm'
	 		raspuns = input("Doriti sa incepeti un joc nou ? (da / nu) ",'s');
	 	endif
	endwhile
  endwhile
endfunction
