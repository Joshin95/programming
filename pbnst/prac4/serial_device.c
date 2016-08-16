#include <stdio.h>	
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>	
#include <avr/sfr_defs.h>
#include <avr/io.h>
#include "serial_device.h"
#define N_ALT 0
#define N_BAIX 103

void serial_init(void){

  UBRR0H=N_ALT;
  UBRR0L=N_BAIX;
  UCSR0A=32; //valor 00100000 en decimal, per activar UDRE (transmitter ready).
  UCSR0B=24; //valor 00011000 en decimal, per Receiver/Transmitter Enable.
  UCSR0C=6; //valor 00000110 en decimal - asincron, sense paritat, 1 stop, byte.
  
}

uint8_t serial_get(void){

  loop_until_bit_is_set(UCSR0A,7); //data is ready to read
  return UDR0;

  }

void serial_put(uint8_t c){

  loop_until_bit_is_set(UCSR0A,5); //transmitter is ready to send
  UDR0=c;

}

bool serial_can_read(void){

  return bit_is_set(UCSR0A,7);

}






