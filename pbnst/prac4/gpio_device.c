#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "gpio_device.h"
#include <util/delay.h>

pin_t pin_create(volatile uint8_t *port, uint8_t pin, pin_direction_t d){
  
  pin_t a;

  if (d==Input){
    *(port-1) &= ~_BV(pin);
  }
  else {
    *(port-1) |= _BV(pin);
  }

  a.port=port;
  a.pin=pin;

  return a;
  
}

void pin_w(pin_t p, bool v){
  
  uint8_t valor; 

  if (p.port!=NULL){ //mirem si esta associat
    valor=*(p.port-1);
    if (_SFR_BYTE(valor)& _BV(p.pin)){ //mirem si es sortida
	if (v)
      	*p.port |= _BV(p.pin);
	else
	*p.port &= ~_BV(p.pin);
	
    }
  }
}

bool pin_r(pin_t p){

 uint8_t valor;

  if (p.port!=NULL){ //mirem si esta associat
    valor=*(p.port-1);
    if (!_SFR_BYTE(valor)& _BV(p.pin)){ //mirem si es entrada
      if (_SFR_BYTE(*p.port)& _BV(p.pin)) // si a lentrada tenim un 1.
	return true;
      else
	return false;
    }
  }
}
	

void pin_toggle(pin_t p){
  uint8_t valor; 

  if (p.port!=NULL){ //mirem si esta associat
    valor=*(p.port-1);
    if (_SFR_BYTE(valor)& _BV(p.pin)){ //mirem si es sortida
      if (_SFR_BYTE(*p.port)& _BV(p.pin)){ // si a lentrada tenim un 1.
	*(p.port) &= ~_BV(p.pin);
      }
      else{
	*(p.port) |= _BV(p.pin); 
      }
    }
  }
}
  
void pin_destroy(pin_t *const p){
  (*p).port=NULL;
}

 


