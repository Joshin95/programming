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


int main() {

  control_init();
  sei();
  control_on();
  _delay_ms(21000);
  control_force(StreetB);
  while(true);


}
