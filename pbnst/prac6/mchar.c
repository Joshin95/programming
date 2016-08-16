#include <stdio.h>
#include <stdbool.h>
#include "mchar.h"
#include <ctype.h>
#include <stdint.h>
#include <string.h>



mchar_iter_t mchar_iter(mchar_t m){

  mchar_iter_t iter;

  iter.m=m;
  iter.mask=128;
  iter.sentinel=4;

  return iter;
}

msign_t mchar_next(mchar_iter_t *const i){

  msign_t signe;

  if ((*i).mask & (*i).m)
    signe=MDash;

  else
    signe=MDot;
  
  (*i).mask=((*i).mask)/2;

  return signe;

}
bool mchar_valid(mchar_iter_t i){

  return (!(i.mask==i.sentinel));
  
}

mchar_t mchar_add(mchar_t m, msign_t s){

  uint8_t len;
  mchar_t k;

  len=mchar_len(m);
  
  if (s==MDash)
    k=(m | (1<<(7-len)));
  else
    k=(m & ~(1<<(7-len)));

  return k+1;

}

void print_morse(mchar_t m) {
  mchar_iter_t i = mchar_iter(m);
  while (mchar_valid(i)) {
    if (mchar_next(&i) == MDot)
      printf(".");
    else
      printf("-");
  }
}

/*int  main(){

  mchar_t v;
  v=mchar(10101);
  print_morse(v);
  return 0;
}*/
