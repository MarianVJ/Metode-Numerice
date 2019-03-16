function x = morse_decode(sir)

arb = morse();
sw = 0;
%daca sirul este vid returnez steluta
if length(sir) == 0 
	x = '*';
endif

if length(sir) ~= 0
	%cu variabila cursor voi retine variabila in care se afla
	%litera dorita , asta in cazul in care exista
    cursor = arb;
    %[arcurg cun un for sirul ce trebuie decodat pana la final
	for i = 1:length(sir)		
		%daca este punct merg la stanga ( in cazul in care am unde) 
		if sir(i) == '.'
			if length(cursor{2}) ~= 0
				cursor = cursor{2};
			else %altfel inseamna ca este invalid codul cerut
				i =length(sir)+1;
				cursor{1} = '*';
				break; %opresc forul 
			endif
		endif
		%daca este linie merg la dreapta ( daca am unde)
		if sir(i) == '-' %daca am unde merg
			if length(cursor{3}) ~= 0
				cursor = cursor{3};
			else % daca nu am unde sa merg inseamna ca nu este valid codul
				i =length(sir)+1;
				cursor{1} = '*';
				break;		
			endif
		endif	
		%daca sirul contine caractere care nu corespund codului
		if sir(i) ~= '.' && sir(i) ~= '-'
			cursor{1} = '*';  %inseamna ca nu este valid codul
		endif
	endfor
		%la final returnez in variabila x fie litera corespunzatoare
		%fi * in cazul in care am intalnit pe parcurs o nedeterminare
		x = cursor{1};	
endif
endfunction
