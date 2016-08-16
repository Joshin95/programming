#include <stdio.h>

int main(){
  
  int i,v,c;
  

  
scanf(c,"%2x",&c);
  printf("%x\n",c);
  i=0;
  while(c!=0x00){
    while(c!=0x00){
    r=c%2;
    c=c/2;
    l=l+r;
    }
  scanf("%2x",&c);
  }
  return 0;
}

