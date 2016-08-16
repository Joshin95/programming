#include "error_morse.h"
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

uint8_t taula[20];

int main(){

  
  taula[0] = 'I';
  taula[1] = 'E';
  taula[2] = 'P';
  //taula[3] = 'F';
  taula[3] = '\r';

  calc_chksm(taula);
  printf("--------------------\n");
  printf("%c\n%c\n",taula[19],taula[18]);
  printf("--------------------\n");
  chk_chksm(taula);
  
  
  
  

}
