#include <stdio.h>

int main(){
  
  int p;
  
  scanf("%x",&p);
  
  p&=~(1<<0);
  p&=~(1<<15);
  
  printf("%x\n",p);
  return 0;
}
  
