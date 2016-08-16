#include <stdio.h>
#include <stdbool.h>
#include "modulator.h"
#include "gpio_device.h"
#include <avr/io.h>
#include <util/delay.h>


int main() {

  modulator_init();
  modulator_set(true);
  _delay_ms(1000);
  modulator_set(false);

  return 0;
}
