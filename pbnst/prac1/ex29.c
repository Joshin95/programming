#include <stdio.h>

int main(){
  
  int c,s,i;
  s=0;
  c=0;

  for(i=0;i<10;i++){ //els iguals no van mai, sempre condicions mes gran o mes petit. Sino no funciona be
    scanf("%x",&c);
    if (c==0x00){
	s=0xFF;
	printf("%x\n",s);
	printf("%x\n",s);
      }
    else{
      s=0;
	printf("%x\n",s);
    }
  }
  return 0;
}
