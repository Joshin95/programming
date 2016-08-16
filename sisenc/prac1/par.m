clear

% paràmetres
Fa=1209;
Fs=20e3;
r=1
% amplitud de pic
A=60;
% coma fixa 8bits ==> multiplicar per 256
k=256;

% càlcul paràmetres
f=Fa/Fs;
w0=2*pi*f;
a1=-2*r*cos(w0)
a2=r^2*ones(size(a1))
b0=A*sin(w0)

% valors escalats coma fixa
A1=a1*k
A2=a2*k

% arrodoniments
A1_t=round(A1)
A2_t=round(A2)
b0_t=round(b0)

% efecte dels arrodoniments
r_t=sqrt(A2_t/k)
Fa_t=acos(-A1_t/k/2/r_t)/2/pi*Fs

% tensió esperada
ICR1=199;
TOP=ICR1;
Vpp=2*A*5/(TOP+1)




