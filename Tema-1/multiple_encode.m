function x = multiple_encode(str)
%iverific daca sirul e gol
if length(str) == 0
	x='*';
else
	x='';
	for i = 1: length(str)
		% caut cu functia morse encode codul
		%il adaug la x 
		x = [x morse_encode(str(i) ) ];
		%dupa care adaug un spatiu 
		if i < length(str)
			x = [x ' '];
		endif
	endfor
endif

endfunction
