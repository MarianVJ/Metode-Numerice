function [] = test()

	eps = 0.1;
	Matrice = zeros(2,6);
	for k = 1 : 6 
		bufer = eval_interpolator_c(k,eps);
		Matrice(1,k) = bufer;
	endfor
	
	for k = 1 : 6 
		bufer = eval_interpolator_d(k,eps);
	
		Matrice(2,k) = bufer;
	endfor
	
	%Rezultatul este cel obtinuit  respectand cerinta , si anume ca
	%Enk - ENk+1 sa fie mai mica decat eps , insa acest lucru nu reflecta
	%in totalitate eficienta interpolantilor mei , deoarece erorile
	%pentru Fourrier si cele 2 spline uri ajung la o eroare foarte 
	%mica mult mai repede , dar Au ca N de convergenta 16 deoarece 
	%nu exista o diferenta asa mare intre erori  ( in cazul continuu)
	disp('In cazul continuu , polinoamele LAgrange si Newton nu converg');
	disp('Acesta este rezultatul atunci cand alegem eps=0,1(explicatii in comentariile functiei test)');
	disp('');
	disp('UN rezultat mult mai bun se obtine pentru eps = 0,01, dar necesita un timp mult mai mare de executie')
	disp('')
	disp('Matricea valorilor lui N pentru toti cei 6 interpolanti');
	disp(Matrice);
	

endfunction 
