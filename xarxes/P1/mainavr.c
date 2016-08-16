#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <pbn.h>   
#include <avr/interrupt.h>
#include "error_morse.h"


uint8_t taula[20];


int main(){
  
  serial_init();
  sei();
  
  taula[0] = 'I';
  taula[1] = 'E';
  taula[2] = 'A';
  taula[3] = 'S';
    //taula[3] = '6';
  taula[4] = '\r';
  /*
  calc_chksm(taula);

  serial_put(taula[19]);
  serial_put(taula[18]);

  serial_put(chk_chksm(taula));
  */

  crc_morse(taula);

  serial_put(taula[19]);
  serial_put(taula[18]);
  serial_put(test_crc_morse(taula));

  while (true);
  
}
