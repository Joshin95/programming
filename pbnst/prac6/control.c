#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "lamp.h"
#include "semaph.h"
#include "control.h"
#include "gpio_device.h"
#include "timer.h"

typedef enum{ Aclear, AtoB, Bclear, BtoA, ABOff} control_state;

static semaph_t one,two;

static int ticker;

static control_state control;

static timer_handler_t ticks;

static void tick_counter(void);
static void change(void);

static void change(void){
  switch (control){
  case Aclear:
    semaphore_set(&one,SemClear);
    semaphore_set(&two,SemStop);
    control=AtoB;
    ticker=80;
    break;
  case AtoB:
    semaphore_set(&one,SemApproach);
    control=Bclear;
    ticker=20;
    break;
  case Bclear:
    semaphore_set(&one,SemStop);
    semaphore_set(&two,SemClear);
    control=BtoA;
    ticker=100;
      break;
  case BtoA:
    semaphore_set(&two,SemApproach);
    control=Aclear;
    ticker=20;
    break;
  case ABOff:
    semaphore_set(&one,SemOff);
    semaphore_set(&two,SemOff);
    break;
  }
}


void control_init(void){

  timer_init();
  semaph_init(&one,&PORTD,5,&PORTD,6,&PORTD,7); //semafor1
  semaph_init(&two,&PORTD,4,&PORTC,3,&PORTC,2); //semafor2 
  control=ABOff;

}

void control_force(street_t t){ 

  semaph_state_t semA,semB;


  semA=control_get_state(StreetA);
  semB=control_get_state(StreetB);

  if (t==StreetA){ 
    if (semA==SemClear) {
      control=Aclear;
      ticker=0;
      change();
    }
    else if (semA==SemApproach) {
      control=Aclear;
      ticker=0;
      change();
    }
     
    else if (semB==SemClear){
      control=BtoA;
      ticker=0;
      change();
            
    }
    else if (semB==SemApproach) {
      //No fem res...funcionament normal!
    } 
  }
  else if (t==StreetB){
    if (semB==SemClear) {
      control=Bclear;
      ticker=0;
      change();
    }
    else if (semB==SemApproach) {
      control=Bclear;
      ticker=0;
      change();
    }
    else if (semA==SemClear){
      control=AtoB;
      ticker=0;
      change();
    }
    else if (semA==SemApproach) {
      //No fem res...funcionament normal!
    } 
  }
}


void control_off(void){ //atura els semafors de la cruilla, a Off.

  timer_cancel(ticks);
  semaphore_set(&one,SemOff);
  semaphore_set(&two,SemOff);
  control=ABOff;
}

static void tick_counter(void){	
  if (!(ticker--))
    change();
}

  
void control_on(void){
     
  semaphore_set(&one,SemClear); //inici
  semaphore_set(&two,SemStop);
  control=Aclear;
  ticks=timer_every(TIMER_MS(100),tick_counter);
 }


semaph_state_t control_get_state(street_t s){

  semaph_state_t estat;

  if (s==StreetA)
    estat=semaph_get(one);
  else if (s==StreetB)
    estat=semaph_get(two);

  return estat;

}
