#include <stdio.h>

int main(){
  
  int p;
  
  scanf("%x",&p);
  
  p&=~(1<<0);
  p&=~(1<<1);
  p&=~(1<<2);
  p&=~(1<<3);
  p&=~(1<<12);
  p&=~(1<<13);
  p&=~(1<<14);
  p&=~(1<<15);
  
  p=p>>4;

  printf("%x\n",p);
  return 0;
}
  
