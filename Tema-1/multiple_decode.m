function x =  multiple_decode(sir)
%cu iter salvez ce elemente din sir trebuiesc decodata
% mai bine zis de unde
iter  = 1;
x=''; %initial sirul e vid
if length(sir) > 0
	%daca nu e vid parcurg mereu sirul
	for i = 1 : length(sir)
		%pana intalnesc spatiul
		if (sir(i) == ' ')
			%si codific cu morse_encode de la ultimul spati
			%pana la acesta toate caracterele
			x = [x morse_decode(sir(iter:i-1))];
			%cu iter salvez ultimul spatiu
			iter = i+1;
		endif
	endfor
	%la acest decofici ultima litera codificata
	x = [x morse_decode(sir(iter:i))];
else
	%daca sirul este vid salvez steluta
	x = '*';
endif

endfunction
