#include <stdio.h>
#include "mtbl.h"
#include "mchar.h"


int main(){

  mchar_t a;
  char s;

  mtbl_init();
  a=mchar(01010);
  s=mtbl_m2a(a);
  printf("%c\n",s);
  a=mtbl_a2m(s);
  printf("%d\n",a);

  return 0;

}