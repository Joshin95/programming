#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <avr/interrupt.h>
#include "mtbl.h"
#include "modulator.h"
#include "timer.h"
#include "queue.h"
#include "ether.h"
#include "serial_device.h"

#define DOT 90
#define GAP DOT
#define DASH 3*DOT
#define LETTERGAP 3*DOT

static queue_t cua;
static mchar_iter_t itera;

static void automat(void);
static void next(void);
static void engega(void);
static void apaga(void);
static void silenci(void);

void ether_init(void){ //inicialitzacio del modul 

  modulator_init(); //inicia el modulator
  timer_init(); //inicia el modul time
  queue_empty(&cua); //inicializa la cua de transmissio buida
  mtbl_init();

}

void ether_put(uint8_t c){ //cua de transmissio

  while(queue_is_full(&cua)); //no deixa passar fins que la cua tingui algun lloc buit, no sigui full!!
  if (queue_is_empty(&cua)){
      queue_enqueue(&cua, c);
      itera = mchar_iter(mtbl_a2m(queue_front(&cua)));
      automat();
  }
  else
    queue_enqueue(&cua,c);
}

static void engega(void){
  modulator_set(true);
}

static void apaga(void){
  modulator_set(false);
}

static void silenci(void){
  timer_after(TIMER_MS(LETTERGAP),next);
}

static void next(void){
  queue_dequeue(&cua);
  if(!queue_is_empty(&cua)){
    itera=mchar_iter(mtbl_a2m(queue_front(&cua)));
    automat();
  }
}

static void automat(void){

  msign_t signe;

  signe=mchar_next(&itera);
  engega();

  if (signe == MDash){
    timer_after(TIMER_MS(DASH),apaga);
     serial_put(itera.mask);
    if(mchar_valid(itera)){
      serial_put('2');
      timer_after(TIMER_MS(DASH+GAP),automat);
    }
    else
      timer_after(TIMER_MS(GAP),silenci);
  }
  else if (signe == MDot){
    timer_after(TIMER_MS(DOT),apaga);
    if(mchar_valid(itera)){
      serial_put('1');
      serial_put(itera.mask);
      timer_after(TIMER_MS(DOT+GAP),automat);
    }
    else{
      timer_after(TIMER_MS(GAP),silenci);
    }
  }
}     

/*int main() {
  
  serial_open();
  ether_init();
  sei();
  ether_put('S');
  ether_put('O');
  ether_put('S');


  for(;;);

}
*/
