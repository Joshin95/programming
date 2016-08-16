#include "timer.h"
#include "timer.h"
#include "gpio_device.h"
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sfr_defs.h>
#include <stdio.h>
#include <util/delay.h>

static timer_handler_t h;
pin_t a;

static void commuta_led(void) {
  pin_toggle(a);
}

static void propera(void){
  timer_after(TIMER_MS(1000), commuta_led);
  commuta_led();
}

static void apaga_led(void) {
  pin_w(a,false);
}

static void atura_intermitent(void) {
  timer_cancel(h);
  apaga_led();
}

int main(void) {
  a=pin_create(&PORTB,5,Output);
  pin_w(a,false);
  timer_init();
  sei();

  h=timer_every(TIMER_MS(200), commuta_led);
  
  //_delay_ms(1000);
  //timer_cancel(h);
  timer_after(TIMER_MS(2000), atura_intermitent);

  for(;;);
}
