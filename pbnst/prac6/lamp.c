#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "gpio_device.h"
#include "lamp.h"
#include <util/delay.h>

void lamp_init(lamp_t *const l,
	       volatile uint8_t *prtg, uint8_t pg,
	       volatile uint8_t *prty, uint8_t py,
	       volatile uint8_t *prtr, uint8_t pr){


  (*l).green=pin_create(prtg,pg,Output);
  (*l).yellow=pin_create(prty,py,Output);
  (*l).red=pin_create(prtr,pr,Output);

  pin_w((*l).green,false);
  pin_w((*l).yellow,false);
  pin_w((*l).red,false);
}

void lamp_on(lamp_t l, color_t c){

  if (c==Green)
    pin_w(l.green,true);
  else if (c==Yellow)
    pin_w(l.yellow,true);
  else if (c=Red)
    pin_w(l.red,true);
  // falta definir l'error
}

void lamp_off(lamp_t l, color_t c){
  
    if (c==Green)
      pin_w(l.green,false);
    else if (c==Yellow)
      pin_w(l.yellow,false);
    else if (c=Red)
      pin_w(l.red,false);
  // falta definir l'error
}

void lamp_toggle(lamp_t l, color_t c){
  
  if (c==Green)
    pin_toggle(l.green);
  else if (c==Yellow)
    pin_toggle(l.yellow);
  else if (c=Red)
    pin_toggle(l.red);
}

bool lamp_is_on(lamp_t l, color_t c){
  
  if (c==Green)
    return pin_r(l.green);
  else if (c==Yellow)
    return pin_r(l.yellow);
  else if (c=Red)
    return pin_r(l.red);
}  

