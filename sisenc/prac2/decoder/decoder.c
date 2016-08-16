#include <inttypes.h>
#include <stdbool.h>
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include <pbn.h>



static pin_t a,b,c,d,e;
static uint8_t estat = 0;

void setup(void){
  a=pin_create(&PORTB,0,Input);
  b=pin_create(&PORTB,1,Input);
  c=pin_create(&PORTB,2,Input);
  d=pin_create(&PORTB,3,Input);
  e=pin_create(&PORTB,4,Input);
  
  serial_open();
  sei();
}

int main(void){
  setup();
  pin_w(e,false);
  while (1) {
    if (pin_r(e)==1 && estat == 0){
      if (pin_r(a)==0 && pin_r(b)==0 && pin_r(c)==0 && pin_r(d)==1){
	serial_put('1');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==0 && pin_r(c)==1 && pin_r(d)==0){
	serial_put('2');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==0 && pin_r(c)==1 && pin_r(d)==1){
	serial_put('3');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==0 && pin_r(c)==1 && pin_r(d)==0){
	serial_put('A');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==1 && pin_r(c)==0 && pin_r(d)==0){
	serial_put('4');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==1 && pin_r(c)==0 && pin_r(d)==1){
	serial_put('5');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==1 && pin_r(c)==1 && pin_r(d)==0){
	serial_put('6');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==0 && pin_r(c)==1 && pin_r(d)==1){
	serial_put('B');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==1 && pin_r(c)==1 && pin_r(d)==1){
	serial_put('7');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==0 && pin_r(c)==0 && pin_r(d)==0){
	serial_put('8');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==0 && pin_r(c)==0 && pin_r(d)==1){
	serial_put('9');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==1 && pin_r(c)==0 && pin_r(d)==0){
	serial_put('C');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==1 && pin_r(c)==1 && pin_r(d)==0){
	serial_put('*');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==1 && pin_r(c)==1 && pin_r(d)==1){
	serial_put('#');
	estat = 1;
      }
      else if (pin_r(a)==0 && pin_r(b)==0 && pin_r(c)==0 && pin_r(d)==0){
	serial_put('0');
	estat = 1;
      }
      else if (pin_r(a)==1 && pin_r(b)==1 && pin_r(c)==0 && pin_r(d)==1){
	serial_put('D');
	estat = 1;
      }
      else {
	serial_put('-');
	estat = 1;
      }
    }
    else if (pin_r(e)==0 && estat == 1) {
      estat = 0;
    }
    else {

      //serial_put('Z');
      //res a fer
    }
  }
}
