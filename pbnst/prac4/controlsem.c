#include <stdio.h>	
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "serial_device.h"
#include "semaphore.h"
#include <util/delay.h>
#define TICK 100

extern semaphore_state_t state;
static uint8_t ticker;


void controlsem_init(){

  serial_init();
  semaphore_init();

}

void tick_monitor(void){

  uint8_t function;
  
  if(serial_can_read()){
    function=serial_get();
    if (function=='E' && state!=SemaphoreOff) {
      semaphore_set(SemaphoreClear);
      ticker=40;
      serial_put('E');
      serial_put('M');
      serial_put('E');
      serial_put('R');
      serial_put('G');
      serial_put('E');
      serial_put('N');
      serial_put('C');
      serial_put('Y');
      serial_put('\n');
    }
    else if (function=='S' && state!=SemaphoreOff) {
      semaphore_set(SemaphoreOff);
      serial_put('S');
      serial_put('H');
      serial_put('U');
      serial_put('T');
      serial_put('D');
      serial_put('O');
      serial_put('W');
      serial_put('N');
      serial_put('\n');
    }
    else if (function=='R') {
      semaphore_set(SemaphoreClear);
      ticker=40;
      serial_put('R');
      serial_put('E');
      serial_put('S');
      serial_put('T');
      serial_put('A');
      serial_put('R');
      serial_put('T');
      serial_put('\n');
    }
    else {
      serial_put('F');
      serial_put('U');
      serial_put('N');
      serial_put('C');
      serial_put('T');
      serial_put('I');
      serial_put('O');
      serial_put('N');
      serial_put(' ');
      serial_put('N');
      serial_put('O');
      serial_put('T');
      serial_put(' ');
      serial_put('D');
      serial_put('E');
      serial_put('F');
      serial_put('I');
      serial_put('N');
      serial_put('E');
      serial_put('D');
      serial_put('\n');
    }
  }
}
  void tick_semaphore(void){
    if (state!=SemaphoreOff){
      if (state==SemaphoreClear){
	if (ticker==0) {
	  semaphore_next();
	  ticker=10;
	}
	else {
	  _delay_ms(TICK);
	  --ticker;
	}
      }
      else if (state==SemaphoreApproach){
	if (ticker==0) {
	  semaphore_next();
	  ticker=60;
	}
	else {
	  _delay_ms(TICK);
	  --ticker;
	}
      }
      else if (state==SemaphoreStop){
	if (ticker==0) {
	  semaphore_next();
	  ticker=40;
	}
	else {
	  _delay_ms(TICK);
	  --ticker;
	}
      }
    }
  }



