#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/sfr_defs.h>
#include "lamp.h"
#include "semaph.h"

int main(){

  semaph_t s; //creem lobjecte....despres farem lapuntador, per entrar-lo a les funcions!! No es pot crear apuntador sense crear abans objecte, es atzaros!!

  semaph_init(&s, &PORTD, 5, &PORTD, 6, &PORTD, 7);
  semaphore_set(&s, SemClear);
  _delay_ms(1000);
  semaphore_set(&s,SemApproach);
  _delay_ms(1000);
  semaphore_set(&s,SemStop);
  _delay_ms(1000);
  semaphore_set(&s,SemOff);
  _delay_ms(1000);
  semaphore_set(&s,SemClear);

  return 0;
 
}
