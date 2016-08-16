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


#define DDR(port)  (*(port-1))
#define PORT(port) (*(port))
#define PIN(port)  (*(port-2))

pin_t pin_create(volatile uint8_t *port, uint8_t pin, pin_direction_t d){
  
  pin_t a;

  if (d==Input) {
    *(port-1) &= ~_BV(pin);
  } else {
    *(port-1) |= _BV(pin);
  }
  a.port=port;
  a.pin=pin;

  return a;
  
}

void pin_w(pin_t p, bool v) {
  if (v)
    PORT(p.port) |=  _BV(p.pin);
  else
    *p.port &= ~_BV(p.pin);
}


bool pin_r(pin_t p) {
  return bit_is_set(PIN(p.port), p.pin);
}
	

void pin_toggle(pin_t p){
    PIN(p.port) |=  _BV(p.pin);
}
  
void pin_destroy(pin_t *const p){
  (*p).port = NULL;
}


