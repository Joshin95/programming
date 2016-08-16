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

void final_apagat(void) {
  commuta_led();
  timer_after(TIMER_MS(300), final_engegat);
}

void final_engegat(void) {
  commuta_led();
  timer_after(TIMER_MS(600), final_apagat);
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
  apaga_led();
  final_apagat();
  for(;;);
}


  




