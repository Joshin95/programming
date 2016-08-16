#include <stdio.h>

int main(){
  
  int c2,c1,c05,c02,c01,c005,c002,c001,v2,v;
  float v1;
  
  c2=0;
  c1=0;
  c05=0;
  c02=0;
  c01=0;
  c005=0;
  c002=0;
  c001=0;
  v2=0;
  v1=0.0;
  v=0;

  scanf("%f",&v1);
  v=v1*100;
  while (v!=0){
    printf("%d\n",v);
    if (v>=200){
      c2=v;
      c2=c2/200;
      v=v-(c2*200);
    }
    else if (v<200 && v>=100){
      c1=v;
      c1=c1/100;
      v=v-(c1*100);
    }
    else if (v<100 && v>=50){
      c05=v;
      c05=c05/50;
      v=v-(c05*50);
    }
    else if (v<50 && v>=20){
      c02=v;
      c02=c02/20;
      v=v-(c02*20);
    }
    else if (v<20 && v>=10){
      c01=v;
      c01=c01/10;
      v=v-(c01*10);
    }
    else if (v<10 && v>=5){
      c005=v;
      c005=c005/5;
      v=v-(c005*5);
    }
    else if (v<5 && v>=2){
      c002=v;
      c002=c002/2;
      v=v-(c002*2);
    }
    else if (v=1){
      c001=v;
      c001=c001/1;
      v=v-(c001*1);
    }
  }
  printf("Monedes de 2: %d\n", c2);
  printf("Monedes de 1: %d\n", c1);
  printf("Monedes de 0.5: %d\n", c05);
  printf("Monedes de 0.2: %d\n", c02);
  printf("Monedes de 0.1: %d\n", c01);
  printf("Monedes de 0.05: %d\n", c005);
  printf("Monedes de 0.02: %d\n", c002);
  printf("Monedes de 0.01: %d\n", c001);
}
