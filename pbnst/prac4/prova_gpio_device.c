#include <stdio.h>
#include "gpio_device.h"
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>

int main (){

  pin_t a,b,c;

  a=pin_create(&PORTD,5,Output);
  b=pin_create(&PORTD,6,Output);
  c=pin_create(&PORTD,7,Output);
  pin_w(a,true);
  pin_w(b,true);
  pin_w(c,true);
  _delay_ms(500);
  pin_w(a,false);
  _delay_ms(500);
  pin_w(b,false);
  _delay_ms(500);
  pin_toggle(c);
  
  return 0;

  }
