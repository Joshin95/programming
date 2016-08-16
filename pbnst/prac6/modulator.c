#include <stdio.h>
#include <stdbool.h>
#include "modulator.h"
#include <avr/io.h>
#include "gpio_device.h"


static pin_t a,b;

void modulator_init(void){

  TCCR2A &= ~_BV(COM2A1); //Toggle configurat
  TCCR2A |= _BV(COM2A0);
  TCCR2A &= ~_BV(WGM20); //mode CTC
  TCCR2A |= _BV(WGM21);
  TCCR2B &= ~_BV(WGM22);
  TCCR2B &= ~_BV(CS22); //Prescaler a 256
  TCCR2B &= ~_BV(CS21);
  TCCR2B &= ~_BV(CS20);
  OCR2A =4;
  a=pin_create(&PORTB,5,Output);
  b=pin_create(&PORTB,3,Output);
  pin_w(a,false);


}
void modulator_set(bool l){

  if (l){
    TCCR2B |= _BV(CS22); //Timer activat
    TCCR2B |= _BV(CS21);
    TCCR2B &= ~_BV(CS20);
    pin_w(a,true);
  }
  else {
    TCCR2B &= ~_BV(CS22); //Timer desactivat
    TCCR2B &= ~_BV(CS21);
    TCCR2B &= ~_BV(CS20);
    pin_w(a,false);
  }

}
