A=1;
Fs=48000;
t=0:1/Fs:0.1;
y=[];

num=input("Entra el numero: ", "s");

for a=num

if a=="1"
y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1209*t);

z1=y1+y2;
y=[y,z1,0*z1];

%plot(t,y)
%play_so(y,Fs);

%pause(0.1);

elseif a=="2"
y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1336*t);

z2=y1+y2;
y=[y,z2,0*z2];
%play_so(y,Fs);

%pause(0.1);

elseif a=="3"

y1=A*sin(2*pi*697*t);
y2=A*sin(2*pi*1477*t);

z3=y1+y2;
y=[y,z3,0*z3];

%plot(t,y)
%play_so(y,Fs);

%pause(0.1);

elseif a=="4"
  
y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1209*t);

z4=y1+y2;
y=[y,z4,0*z4];
%play_so(y,Fs);

%pause(0.1);

elseif a=="5"

y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1336*t);

z5=y1+y2;
y=[y,z5,0*z5];
%play_so(y,Fs);

elseif a=="6"

y1=A*sin(2*pi*770*t);
y2=A*sin(2*pi*1477*t);

z6=y1+y2;
y=[y,z6,0*z6];
%plot(t,y)
%play_so(y,Fs);

%pause(0.1);

elseif a=="7"

y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1209*t);

z7=y1+y2;
y=[y,z7,0*z7];
%play_so(y,Fs);

%pause(0.1);

elseif a=="8"

y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1336*t);

z8=y1+y2;
y=[y,z8,0*z8];
%plot(t,y)
%play_so(y,Fs);

%pause(0.1);

elseif a=="9"
  
y1=A*sin(2*pi*852*t);
y2=A*sin(2*pi*1477*t);

z9=y1+y2;
y=[y,z9,0*z9];
%play_so(y,Fs);

%pause(0.1);

elseif a=="0"
  
y1=A*sin(2*pi*941*t);
y2=A*sin(2*pi*1336*t);

z9=y1+y2;
y=[y,z9,0*z9];
%play_so(y,Fs);

%pause(0.1);

endif
endfor;


play_so(y,Fs);



