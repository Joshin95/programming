#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/sfr_defs.h>
#include "semaph.h"
#include "control.h"
#include <avr/interrupt.h>
#include "gpio_device.h"


typedef enum {Aclear,AtoB,Bclear,BtoA,ABoff} state_t;

semaph_t primer,segon;

static int tick;

static state_t control_state;


ISR(TIMER1_COMPA_vect){


  if (tick==0){
    switch (control_state){
    case Aclear:
      semaphore_set(&primer,SemClear);
      semaphore_set(&segon,SemStop);
      control_state=AtoB;
      tick=80;
      break;
    case AtoB:
      semaphore_set(&primer,SemApproach);
      tick=20;
      control_state=Bclear;
      break;
    case Bclear:
      semaphore_set(&primer,SemStop);
      semaphore_set(&segon,SemClear);
      tick=100;
      control_state=BtoA;
      break;
    case BtoA:
      semaphore_set(&segon,SemApproach);
      tick=20;
      control_state=Aclear;
      break;
    case ABoff:
      semaphore_set(&primer,SemOff);
      semaphore_set(&segon,SemOff);
      break;
    }
  }
  else{
    tick--;
  }
}

void control_init(void){ 


  semaph_init(&primer,&PORTD,5,&PORTD,6,&PORTD,7); 
  semaph_init(&segon,&PORTD,4,&PORTC,3,&PORTC,2); 
  TCCR1A=0;
  TCCR1B |= _BV(3); 
  TCCR1B &= ~_BV(1);
  TCCR1B &= ~_BV(0);
  OCR1A=25000;
  TCNT1=0;
  TIMSK1 |= _BV(1);
  control_state=ABoff;
 

}


void control_off(void){ 

  semaphore_set(&primer,SemOff);
  semaphore_set(&segon,SemOff);
  control_state=ABoff;
  TCCR1B |= _BV(3); 
  TCCR1B &= ~_BV(1);
  TCCR1B &= ~_BV(0);
}
void control_on(void){
  semaphore_set(&primer,SemClear);
  semaphore_set(&segon,SemStop);
  control_state=Aclear;
  TCCR1B |= _BV(3); 
  TCCR1B |= _BV(1);
  TCCR1B |= _BV(0);

}

semaph_state_t control_get_state(street_t s){
  semaph_state_t state;
  
  if (s==StreetA)
    state=semaph_get(primer);
  else
    state=semaph_get(segon);
  return state;
}

void control_force(street_t t){ 

  semaph_state_t estatA,estatB;


  estatA=control_get_state(StreetA);
  estatB=control_get_state(StreetB);

  if (t==StreetA){ 
    if (estatA==SemClear) {
      control_state=Aclear;
      tick=0;
    }
    else if (estatA==SemApproach) {
      control_state=Aclear;
      tick=0;
    }
     
    else if (estatB==SemClear){
      control_state=BtoA;
      tick=0;
            
    }
    else if (estatB==SemApproach) {
      //No sa de fer res!
    } 
  }
  else if (t==StreetB){
    if (estatB==SemClear) {
      control_state=Bclear;
      tick=0;
    }
    else if (estatB==SemApproach) {
      control_state=Bclear;
      tick=0;
    }
    else if (estatA==SemClear){
      control_state=AtoB;
      tick=0;
    }
    else if (estatA==SemApproach) {
      //No sha de fer res!
    } 
  }
}


