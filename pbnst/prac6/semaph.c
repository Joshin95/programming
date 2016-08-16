#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "lamp.h"
#include "semaph.h"
#include <util/delay.h>

void semaph_init(semaph_t *const sem, 
		   volatile uint8_t *port_green, uint8_t pin_green, 
		   volatile uint8_t *port_yell, uint8_t pin_yell, 
		   volatile uint8_t *port_red, uint8_t pin_red){
  
  lamp_init(&((*sem).l),
	    port_green,pin_green,
	    port_yell,pin_yell,
	    port_red,pin_red);
  
  (*sem).s=SemOff;
}

void semaphore_set(semaph_t *const sem, semaph_state_t s){
  
  if (s==SemOff){
    (*sem).s=SemOff;
    lamp_off((*sem).l,Green);
    lamp_off((*sem).l,Yellow);
    lamp_off((*sem).l,Red);  
  }
  else if (s==SemClear){
    (*sem).s=SemClear;
    lamp_on((*sem).l,Green);
    lamp_off((*sem).l,Yellow);
    lamp_off((*sem).l,Red); 
  }
  else if (s==SemApproach){
    (*sem).s=SemApproach;
    lamp_off((*sem).l,Green);
    lamp_on((*sem).l,Yellow);
    lamp_off((*sem).l,Red);
  }
  else if (s==SemStop){
    (*sem).s=SemStop;
    lamp_off((*sem).l,Green);
    lamp_off((*sem).l,Yellow);
    lamp_on((*sem).l,Red); 
  }
  // falta fer l'error
}

semaph_state_t semaph_get(const semaph_t sem){
  
  return sem.s;

}

/*
int main(){
  
  semaph_t *const semaph;

  semaph_init(semaph,&PORTD,5,&PORTD,6,&PORTD,7);
  semaphore_set(semaph,SemClear);
  _delay_ms(1000);
  semaphore_set(semaph,SemApproach);
  _delay_ms(1000);
  semaphore_set(semaph,SemStop);
  _delay_ms(1000);
  semaphore_set(semaph,SemOff);

}
*/
