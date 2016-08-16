#include <stdio.h>
#include "semaphore.h"
#include <util/delay.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "gpio_device.h"


int main(){

  semaphore_init();
  semaphore_set(SemaphoreClear); //posem el semafor en estat clear o verd
  _delay_ms(500); //esperem 500ms
  semaphore_next(); //pasem al seguent estat
  _delay_ms(500);
  semaphore_next();
  _delay_ms(250);
  semaphore_next();
  _delay_ms(250);
  semaphore_next();
  _delay_ms(250);
  semaphore_next();
  return 0;
}
