mostra_1 = 0;
mostra_2 = 0;
N = 105;
Goertzel = 0;
coef_697 = 440/256;	

A=127;
Fs=8000;
t=0:1/Fs:(N-1)/Fs;
y1=A+A*sin(2*pi*770*t);
a=0*t;
for n=1:N

mostra = y1(n) + (mostra_1 * coef_697) - mostra_2;
mostra_2 = mostra_1;
mostra_1 = mostra;
a(n)=mostra;
end
  
prod1 = (mostra_1 * mostra_1) + (mostra_2 * mostra_2) 
prod2 = (mostra_1 * coef_697)*mostra_2
Goertzel = prod1 - prod2;
max(mostra)

Goertzel
