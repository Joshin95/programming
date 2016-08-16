#include "timer.h"
#include "gpio_device.h"
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sfr_defs.h>
#include <stdio.h>

pin_t a;

void commuta_led(void) {

  pin_toggle(a);

}


int main(void) {
  a=pin_create(&PORTB,5,Output);
  pin_w(a,false);
  sei();
  timer_init();
  timer_handler_t h = timer_every(TIMER_MS(500),commuta_led);
  if (h == TIMER_ERR)
    abort();
  for(;;);
}
