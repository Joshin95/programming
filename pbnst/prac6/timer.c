#include <stdio.h>
#include <stdint.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sfr_defs.h>
#include <util/atomic.h>
#include "timer.h"
#include "serial_device.h"
#include "gpio_device.h"


#define N 20

typedef struct {
  uint8_t remaining, every, ntimes;
  timer_callback_t callback;
} entry;

typedef struct {
  entry t[N];
  uint8_t n; 
} tt;

static tt taula;

void timer_init(void){

  timer_handler_t i;
  
  TCCR1A=0;
  TCCR1B |= _BV(3); //mode CTC
  TCCR1B |= _BV(1); //inicialitzem prescaler 64
  TCCR1B |= _BV(0);
  OCR1A=2500; //10ms
  TCNT1=0; //valor inici timer
  TIMSK1 &= ~_BV(OCIE1A); //enable interrupcio timer
  for(i=0;i<N;i++){
    taula.t[i].every=0;
  }
  taula.n=0;
}


timer_handler_t timer_after(uint8_t ticks, timer_callback_t f){
  return timer_ntimes(1,ticks,f);
}


timer_handler_t timer_every(uint8_t ticks, timer_callback_t f){
  return timer_ntimes(0,ticks,f);
}



timer_handler_t timer_ntimes(uint8_t n, uint8_t ticks, timer_callback_t f){
  timer_handler_t i;
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE){
    for(i=0;i<N;i++){
      if (! taula.t[i].every) {
	taula.t[i].remaining=ticks;
	taula.t[i].every=ticks;
	taula.t[i].ntimes=n;
	taula.t[i].callback=f;
	taula.n++;
	TIMSK1 |= _BV(OCIE1A);
       	return i;
      }
    }
    return TIMER_ERR;
  }
}


void timer_cancel(timer_handler_t h){
  taula.t[h].every=0;
  if (!--taula.n)	
    TIMSK1 &= ~_BV(OCIE1A);
}



void timer_cancel_all(void){
  uint8_t i;
  TIMSK1 &= ~_BV(OCIE1A);
  for(i=0;i<N;i++){
    taula.t[i].every=0;
  }
  taula.n=0;
}



ISR(TIMER1_COMPA_vect){ //DEBUGAR!!
  timer_handler_t i;
  if (taula.n){
    for(i=0; i<N; i++){
      if (taula.t[i].every && !taula.t[i].remaining){
	if (taula.t[i].ntimes){
	  taula.t[i].remaining=taula.t[i].every;
	  taula.t[i].callback();    //cridar funcio ?
	  taula.t[i].ntimes--;
	  if (!taula.t[i].ntimes)
	    timer_cancel(i);
	}
	else{
	 taula.t[i].remaining=taula.t[i].every;
	 taula.t[i].callback(); 
	}
      }
      
      else if (taula.t[i].every && taula.t[i].remaining)
	taula.t[i].remaining--;
    }
  }
  else
    TIMSK1 &= ~_BV(1);
  
}


