
1. Lagrange 
Valorile pentru E sunt urmatoarele
E =  0.48225 pentru Nk = 4
E =  0.44454 pentru Nk = 8
E =  0.42278 pentru Nk = 16
E =  0.076443 pentru Nk = 32
E =  1.1788 pentru Nk = 64
E =  3.3454 pentru Nk = 128
Observam faptul ca dupa Nk = 64 (2 ^ 6) Ep-ul incepe sa creasca.
Pentru primiele 4 interpolari graficul este similar cu cel original
exceptie facand oscilatiile foarte mari de la capete , de la a patra
interpolare , graficul incepe sa semene din ce in ce mai putin cu cel original.

2. Newton 
Valorile pentru E sunt urmatoarele
E =  0.48225 pentru Nk = 4
E =  0.44454 pentru Nk = 8
E =  0.42278 pentru Nk = 16
E =  0.076443 pentru Nk = 32
E =  11.069 pentru Nk = 64
E =    7.7352e+41 pentru Nk = 128

Observam faptul ca si de aceasta data la fel ca si in cazul  precedent
faptul ca dupa Nk =  64 E-ul incepe sa creasca. Valorile erorilor
sunt identice cu cele de la polinomul Lagrange , exceptie facand a cincea valoarea. De asemenea graficul este asemanator cu cel original
pentru primele 4 interpolari , dupa care incepe sa se asemene din ce
in ce mai putin .

3. Linear Spline 
Valorile pentru E sunt urmatoarele
E =  0.10419 pentru Nk = 4
E =  0.071265 pentru Nk = 8
E =  0.022626 pentru Nk = 16
E =  0.0057698 pentru Nk = 32
E =  0.0014549 pentru Nk  = 64
E =    3.8488e-04 pentru Nk = 128
E =    1.5740e-04 pentru Nk = 256
E =    1.3061e-04 pentru Nk = 512

Spre deosebire de primele doua polinoame de interpolare , la Polinomul
spline linear , eroarea este de la primul pas Nk = 4 , foarte mic
si incepe sa scada din ce in ce mai mult . Graficul pentru primele 3 , 
interpolari are aceeasi forma ca si graficul original , dar exisa inseamnata
o diferente sesizabila intre cele doua . Pe masura ce marim Nk ul
graficele sunt din ce in ce mai bune si eraorea din ce in ce mai mica.

4. Natural Spline

Valorile pentru E sunt urmatoarele 
E =  0.19859 pentru Nk = 4
E =  0.0067685 pentru Nk = 8
E =  0.0012068 pentru Nk =16
E =    1.3676e-04 pentru Nk = 32
E =    1.2865e-04 pentru Nk = 64
E =    1.2862e-04 pentru Nk = 128
E =    1.2862e-04 pentru Nk = 256
E =    1.2862e-04 pentru Nk = 512
 
Si in cazul acestui polinom de interpolare eroarea scade pe masura
ce Nk ul creste la fel ca si in cazul Spline ului linear. Daca la inceput
pentru Nk  =4 eroarea este mai mare pentru Spline ul natural , pe masura
ce Nk ul creste eroarea tinde pentru acest polinom spre zero mult mai repede
decat in cazul Spline ului liniar . Asta inseamna ca acest polinom este de 
asemenea eficient , dar este foarte eficient atunci cand avem un numar 
destul de mare de puncte. Pentru puncte in numar redus , se prefera
interpolarea cu ajutorul spline ului Linear. 

5. Cubic Spline 

Valorile pentru E sunt urmatoarele 
E =  0.18132 pentru Nk = 4
E =  0.0058676 pentru Nk = 8
E =  0.0012070 pentru Nk = 16
E =    1.3683e-04 pentru Nk = 32
E =    1.2865e-04 pentru Nk = 64
E =    1.2862e-04 pentru Nk = 128
E =    1.2862e-04 pentru Nk = 256
E =    1.2862e-04 pentru Nk = 512

Acest polinom de interpolare se aseamana foarte mult cu cel prezentat
anterior , cel natural. Ambele converg foarte repede, eroare tinzand la 0 , cam in acelasi ritm . Din valrile pe care le-am obtinuit , putem
observa insa faptul ca Splineul Cubic este putin mai rapid decat cel natural
avand inca de la inceput o eroare mai mica decat cea de la Spline ul natural.


6. Fourrier 

Valorile pentru E sunt urmatoarele
E =  0.33151 pentru Nk = 4
E =  0.047808 pentru Nk = 8
E =    1.2389e-04 pentru Nk = 16
E =    5.6261e-12 pentur Nk = 32
E =    4.1257e-16 pentru Nk = 64
E =    8.5593e-16 pentru Nk = 128
E =    1.5671e-15 pentru Nk = 256
E =    2.8590e-15 pentru Nk = 512

Si in cazul acesta , putem ovserva faptul ca eroarea scade foarte repede
Chiar daca pentru Nk = 4 valoarea erorii este mai mare decat in cazul
Splineuri lor , lucru care nu este favorabil , la urmatorul pas aceasta 
scade semnificativ , si converge cel mai repede la 0.


Polinoamele a caror eroare converge catre zero sunt cele trei spline-uri si Fourrier, in cazul Lagrange si Newton , oscilatiile de la capete
fac ca de la un anumit numar de puncte Eroare E sa nu mai scada si din pacate
incepe sa creasca ( de la Nk  =  64 mai exact , incepe sa creasca , pana 
atunci eroarea fiind in scadere, pentru ambele polinoame de interpolare).

CONCLUZIE : Dintre toate polinoamele , cel mai exact este Fourrier , deoarece eroarea in acest caz converge cel mai repede catre 0. 


DISCRET 

1. Lagrange

Valorile pentru E sunt urmatoarele
E =  126.98 Nk = 4
E =  156.44 Nk = 8
E =  5659.1 Nk = 16
E =    5.9410e+07 Nk = 32

Erori foarte mari . Eroarea in cazul discret spre deosebire de cel 
continuu nu mai scade deloc , inca de la inceput incepe
sa creasca , datorita erorilor foarte mari de la capate

2. Newton 

Valorile pentru E sunt urmatoarele 
E =  135.44 Nk = 4
E =  166.44 Nk = 8
E =  5651.8 Nk = 16
E =    5.9410e+07 Nk = 32
E =    5.1670e+19 Nk = 256

Ca si in cazul interpolantului Lagrange eroarea este mare de 
la inceput si datorila vcariatiilor de la capete
continua sa creasca pe masura ce se mareste si Nk ul 

3. Linear Spline

Valorile pentru E sunt urmatoarele 
E =  118.88 Nk = 4
E =  117.30 Nk = 8
E =  120.25 Nk = 16
E =  124.16 Nk = 32
E =  61.711 Nk = 64
E =  35.839 Nk = 128
E =  24.264 Nk = 256
E =  21.607 Nk = 299

Erorile si in acest caz la fiecare pas sunt mari , dar pe masur
ce Nk ul creste Valoarea erorii incepe sa se micsoreze , datorita
numarului mic de puncte ( doar 300 ) , eroarea nu este
aproape de 0 , daca ar exista un numar mai mare de puncte , dupa
un numar de iterii aceasta sa se apropie de 0. 

4.Natural Spline 

Valorile pentru E sunt urmatoarele 
E =  119.03 Nk = 4
E =  124.82 Nk = 8
E =  125.21 Nk = 16
E =  126.28 Nk = 32
E =  51.166 Nk = 64
E =  22.565 Nk = 128
E =  10.444 Nk = 256
E =  1.5919 Nk = 299

5. Cubic Spline 

Valorile pentru E sunt urmatoarele 
Ep =  117.29 Nk = 4
Ep =  124.08 Nk = 8
Ep =  125.76 Nk = 16
Ep =  125.94 Nk = 32
Ep =  51.194 Nk = 64
Ep =  22.371 Nk = 128
Ep =  10.174 Nk = 256
Ep =  1.5919 Nk = 299

In cazul celor doua spline uri Natural si Cubic , erorile sunt
foarte asemanatoare , sunt intr-o continua scadere , Dar si 
in acest caz pentru ca eroarea sa convearga pana a ajunge la finalul
de 300 de puncte , ar fi fost nevoie de un numar mai mare de pucnte
pe care sa putem face interpolarile ( mai mare de 300 )

6. Fourrier

Valorile pentru E sunt urmatoarele 
E =  150.67 Nk = 4
E =  149.83 Nk = 8
E =  181.52 Nk = 16 
E =  129.18 Nk = 32
E =  143.45 Nk = 64
E =  161.31 Nk = 128
E =  89.392 Nk = 256
E =  47.088 Nk = 298


In concluzie in afara de polinoamele de interpolare de la Lagrange
si Newton , care diverg indiferent de numarul de puncte
pe care le-as fi avut la dispozitie. Celalte patru polinoame
, chiar daca la inceput au erori destul de mari ( 100-150) , pe masura
ce nuamrul de puncte pe care le avem la dispozitie creste , scade si
eroarea destul de semnificativ . Cel mai bine se comporta pe discret
Spline -ul Cubic.


PREZENTAREA TEMEI : 
Algoritmii pe care i-am folosit in rezolvarea temei sunt fie cei
prezentati in cadrul laboratorului fie cei prezentati la curs. 
La evaloarea discontinua am folosit doi vectori x si y in care am
tinut cele 1001 puncte (x-sii si f(x)-sii functiei ) . Dupa care
am construit in toate cele 4 cazuri polinoamele de interpolare 
pentru un numar de punct Nk+1 cu Nk ce ia valori de la 4 pana la
512. De fiecare data am construi un polinom de grad Nk+1 si am
calculat cu ajutorul acestuia cele 1001 puncte , pe care
le am generat la inceputul functiei . DUpa care am verificat
care este eroarea la fiecare pas cu ajutorul formulei prezentate in 
cerinta temei . Modul in care am gandit gasire N ului pentru care
functia converge este urmatorul : fie diferenta de eori
esete mai mica decat un epsilon , asa ca atunci putem spune
ca interpolantul converge , fie eroarea crete de la un pas la altul
si asta inseamna ca interpolantul diverge , acest lucru l am 
folosit pe continuu . Pe discret am decis ca interpolantul diverge daca
eroarea se dubla de la un pas la altul . 
Desi stiu ca interpolantii de la newton si lagrange nu converg . SI 
programul meu afiseaza acest lucru . Pentru un epsilon de 0,1
datorita conditiei de convergenta prezentata in cerinta , desi 
erorile la un moment dat in cazul polinoamelor de la Lagrange si newton
cresc foarte mult , pentru eraorea de 0,1 Functia returneaza faptul ca
acesti doi interpolanti converg pentru NK egal cu 8 . Dar daca ne uitam
la erorile pe care le avem pentru diverse valori ale lui NK 
putem observa faptul ca acestia doi nu diverg. Pentru a demonstra 
acest lucru as dori sa rog pe domnul profesor / doamna profesoara care
imi corecteaza tema sa ruleze functia test pentru un epsilon
egal cu 0.01 ( desigur trebuie sa modifice in corpul functiei 
valoarea lui epslion , care la momentul actual este 0,1) . Desi
rularea pentru aceasta valoare este semnificativa mai mare, vom
ajunge la rezultatul dorit . 

La Lagrange , pentur fiecare valoare pe care trebuie sa o aflu in cele
1001 puncte construiam de fiecare data multiplicatorul lagrange
in punctul X_Final(K) cu k de la 1 la 1001. Dupa care valoarea
in punctul X_final(k) era egala cu suma produselor dintru fiecare
f(xj) pentru cele N+1 puncte si multiplicatorul Lagrange corespunzator.
Aplicam acest algoritm pentru toate cele 1001 puncte.

La Newton mai intai am calculat cu ajutorul unui for de la 1 la 
n - 1 unde n este lungimea vectorului x de puncte cu care
voi construi polinomul . Si calculze fiecare diferenta divizata
F0(x0) , F1(x0,x1) ... Fn(x0....xP) , cu ajutorul formulelor de la curs
care se deduc prin inductie . Dupa ce am calculat aceste diferente
divizate putem calcula valoarea in fiecare dintre cele 1001 puncte
deoarece avem toate informatiile necesare formulei f in punctul x
va fi egala cu f(x) + (x-x0 )* F1(x-x0) .... . Vom calcula 
mai intai toate aceste produse , si vo tine valoarea fiecaruia 
intr o variabila c dupa care vom face suma acestora dupa ce
le vom calcula pe toate .

La Fourrier Linear calculam mai intai coeficientii necesari 
determinarii valorii functiei f in cele 1001 puncte . Care sunt
urmatorii a = 1/m suma(yj *cos k(xj) )si b = 1/m suma din ( yj cos (
k * sin (k xj))  cu j luand valori intre 0 si 2m -1 si 
k ia valori de la 1 la m . In cazul nostru n , care repzinta lungimea
vectorulor cu ajutorul carora construi interpolantul . Dupa care 
calculam valoarea functiei in fiecare punct x cu formula  din laboraturl
10 f(x) = (a0 + am cos (mx))/2  + suma (ak cos k x  + bk sin k x) , unde
x este punctul in care doresc sa calculez valoarea functiei cu 
ajutorul interpolantului curent , iar a0...am b1 ...bm snut
indicii calculati anterior .

La spline liniar Calculez mai intai coeficientii a si b pe care
ii retin in 2 vectori , cu ajutorul formulelor din cursul numarul
9 . bi = f(ki+1)- f(xi) / (xi+1 f(xi) - xi f(xi+1) / (xi+1 - xi)
iar ai = f(xi+1) - f(xI)) / (xi+1) - xi). Dupa care odata aflati
coeficientii putem calcula cu ajutrul interpolantului valoarea
functiei in cele 1001 puncte . Astfel daca punctul 
in care dorim sa calculam functia a fost deja folosit la construirea interpolantului
nu mai este nevoie de ii calculam valoarea deoarece deja o stim
altfel valoarea acestuia este egala cu a(i) * x_final(k) + b(i); 
unde x_final(k) estse chiar punctul a carui valoare doresc sa o aflu
, k mergand de la 1 la 1001 pentru toate punctele

La Spline Natural.  Am folosit tot metoda prezentata la curs folosind
2n+2 conditi de interpolare de tip Hermite . Pentru a folosit
aceasta metoda trebuie sa calculam 4 coeficienti a b c d 
unde a era chiar vectorul y , iar b c d au formulele przentate in curs.
O modalitate mai usoara de determinare a acestora trei coeficienti
pe care nu ii cunosc este urmatoarea : mai intai determinam
c ul , care este vectorul solutiei al unei ecuatii de tipll
A x =  b , unde A este o matrice tridiagonala , a carei diagonele
le putem determina destul de usor cu ajutorul fomulelor din curs
iar de asemenea b ul , este o functie de h si a , vectori ale
varor valori le cunoastem . Odata determinate valorile matricei
A si ale lui d , putem calcula valoarea coeficientului c
cu ajutprul metodei THOMAS prezentata in unul din laboratore. 
Odata aflat c ul putem explicita foarte usor si cei doi coeficienti
b si d in functie de acesta . Dupa ce avem valorile tuturor coeficientilor
Putem determina valoarea functiei in fiecare punct x_final(k) cu k 
de la 1 la 1001  cu formula
 ySpg(k) = a(i) + b(i) * (x_final(k) - x(i)) + c(i) * (x_final(k) - x
 (i))^ 2 + d(i)* (x_final(k) - x(i))^3;  cu conditia ca punctul
 in care dorim sa aflam valoarea functiei sa fie intre x(i)  si X(i+1)
 Asa ca , mai intai cautam punctele intre care trebuie sa se afla , punctul
 dupa care ii calculam valoarea .
 
 
 Spline-ul Cubic este foarte asemanator cu cel natural , dar nu 
 mai am timp sa il scriu ( PS MAI SUNT 4 minute pana se inchide
 submitul pe MOODLE)
 
 






