#include <stdio.h>
#include "semaphore.h"
#include "gpio_device.h"
#include <avr/io.h>
#include <stdbool.h>
#include <avr/sfr_defs.h>
#include <util/delay.h>

semaphore_state_t state;
static pin_t a,b,c;
  
void semaphore_init(void){


  state=SemaphoreOff;
  a=pin_create(&PORTD,5,Output);
  b=pin_create(&PORTD,6,Output);
  c=pin_create(&PORTD,7,Output);
  pin_w(a,false);
  pin_w(b,false);
  pin_w(c,false);
  
  
}

void semaphore_next(void){
  
  switch(state){
  case SemaphoreClear:
    state=SemaphoreApproach;
    pin_w(a,false);
    pin_w(b,true);
    pin_w(c,false);
    break;
  case SemaphoreApproach:
    pin_w(a,false);
    pin_w(b,false);
    pin_w(c,true);
    state=SemaphoreStop;
    break;
  case SemaphoreStop:
    pin_w(a,true);
    pin_w(b,false);
    pin_w(c,false);
    state=SemaphoreClear;
    break;
  }
}

void semaphore_set(semaphore_state_t s){
  
  switch(s){
  case SemaphoreClear:
    pin_w(a,true);
    pin_w(b,false);
    pin_w(c,false);
    state=SemaphoreClear;
    break;
  case SemaphoreApproach:
    pin_w(a,false);
    pin_w(b,true);
    pin_w(c,false);
    state=SemaphoreApproach;
    break;
  case SemaphoreStop:
    pin_w(a,false);
    pin_w(b,false);
    pin_w(c,true);
    state=SemaphoreStop;
    break;
  case SemaphoreOff:
    pin_w(a,false);
    pin_w(b,false);
    pin_w(c,false);
    state=SemaphoreOff;
    break;
  }
}

