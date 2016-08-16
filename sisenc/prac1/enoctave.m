A=1/2;
Fs=48e3;
t=0:1/Fs:0.05;

y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1209*t);

ysortida1=y1+y2;

%plot(t,ysortida);
%play_so(ysortida,Fs);

%%%

y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1336*t);

ysortida2=y1+y2;

%play_so(ysortida,Fs);

%%%

y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1477*t);

ysortida3=y1+y2;

%play_so(ysortida,Fs);

%%%

y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1209*t);

ysortida4=y1+y2;

%play_so(ysortida,Fs);

%%%

y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1336*t);

ysortida5=y1+y2;

%%%

y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1477*t);

ysortida6=y1+y2;

%%%

y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1209*t);

ysortida7=y1+y2;

%%%

y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1336*t);

ysortida8=y1+y2;

%%%

y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1477*t);

ysortida9=y1+y2;



ysortida=[ysortida1,0*ysortida1,ysortida2,0*ysortida2,ysortida3,0*ysortida3,ysortida4,0*ysortida4,ysortida5,0*ysortida5,ysortida6,0*ysortida6,ysortida7,0*ysortida7,ysortida8,0*ysortida8,ysortida9,0*ysortida9];

numero=input("Entra el numero: ","s");
disp(numero);

for a=numero
  disp(a);
endfor

%play_so(ysortida,Fs);

