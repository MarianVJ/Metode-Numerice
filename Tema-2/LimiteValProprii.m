function [limita_inf, limita_sup] = LimiteValProprii(d,s)
	%adaug element pe ultima si prima linia
	%a vectorului s pentru a calcula t urile mai usor
	s = [0 ; s ; 0];
	n = length(d);
	%minimul porneste de la infinit ( pentru a fi siguri
	%ca o sa gasim o valoare buna
	min  = inf;
	for i = 1 : n
		%aflam t(i) ul pentru fiecare pas ca fiind suma
		%de pe linie mai putin elementul de pe diagonala
		%principala adica mai putin d(i)
		t = abs(s(i)) + abs(s(i+1));
		%daca conditia este inteplinita se schimba minumul
		if d(i)-t < min 
			min = d(i) - t;
		endif
	endfor
	%la final se salveaza in variabial limita_inf 
	%valoarea minima
	limita_inf = min;
	%maximul se ia de la minus infinit pentru a
	%en asigura ca o sa gasim o o solutie buna
	max = -inf; 
	for i = 1 : n
		%calculam si de aceasta data t(i)
		t = abs(s(i)) + abs(s(i+1));
		%iar daca conditia este indeplinita
		%se salveaza noua valoarea a maximului
		if d(i)+t > max 
			max = d(i) + t;
		endif
	endfor
	%la final se salveaza in variabila limita_sup
	%valoarea maxima
	limita_sup = max;
endfunction
