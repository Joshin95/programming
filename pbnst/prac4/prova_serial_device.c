#include <stdio.h>
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "serial_device.h"

int main(){

  uint8_t a;

  serial_init();
  a=serial_get();
  serial_put(a); //Fem eco del caracter escrit amb el teclat
  serial_put('H');
  serial_put('E');
  serial_put('L');
  serial_put('L');
  serial_put('O');
  a=serial_get();//Fem eco del caracter escrit amb el teclat
  serial_put(a);

  return 0;
  }
