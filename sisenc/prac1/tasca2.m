clear,clc

%calcul de referencia, quan r=1.

Fs=20e3;
n=(Fs/697)*5;
w0=(2*pi*697)/(Fs);
r=1;
A=5;
b0=A*sin(w0);
a1=-2*r*cos(w0);
a2=r^2;
den=[1 a1 a2];
num=[b0];
entrada=[1 zeros(1,n-1)];
referencia=filter(num,den,entrada);

%calcul de sortida.
sortida(2)=0;
sortida(3)=b0;

for i=4:n
    sortida(i)=-a1*sortida(i-1)-a2*sortida(i-2);
    if sortida(i)>A
        sortida(i)=A;
    elseif sortida(i)<-A
        sortida(i)=-A;
    endif
    endfor;


Fs=20e3;
n=(Fs/1209)*5;
w0=(2*pi*1209)/(Fs);
r=1;
A=5;
b0=A*sin(w0);
a1=-2*r*cos(w0);
a2=r^2;
den=[1 a1 a2];
num=[b0];
entrada=[1 zeros(1,n-1)];
referencia=filter(num,den,entrada);

%calcul de sortida.
exit(2)=0;
exit(3)=b0;

for i=4:n
    exit(i)=-a1*exit(i-1)-a2*exit(i-2);
    if exit(i)>A
        exit(i)=A;
    elseif exit(i)<-A
        exit(i)=-A;
    endif
    endfor;
y=sortida+exit;
plot(1:n,y,1:n,referencia)
