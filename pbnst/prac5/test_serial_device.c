#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include <avr/interrupt.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "serial_device.h"
#include "queue.h"


int main() {
  serial_open();
  while(true){
    serial_put(serial_get());
  }

  return 0;

}
