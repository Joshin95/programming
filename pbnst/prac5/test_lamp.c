#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "lamp.h"
#include "gpio_device.h"
#include <util/delay.h>

int main(){
 
  lamp_t l;

  lamp_init(&l,&PORTD,5,&PORTD,6,&PORTD,7);
  lamp_on(l,Green);
  _delay_ms(1000);
  lamp_on(l,Yellow);
  _delay_ms(1000);
  lamp_on(l,Red);
  _delay_ms(1000);
  lamp_off(l,Green);
  lamp_off(l,Yellow);
  lamp_off(l,Red);
}
