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
#define HIGH 0
#define LOW 103



static queue_t input, output;

ISR(USART_RX_vect) {
  queue_enqueue(&input,UDR0);
}

ISR(USART_UDRE_vect){
  UDR0=queue_front(&output);
  queue_dequeue(&output);
  if (queue_is_empty(&output)) 
    UCSR0B &= ~_BV(5);        
}

void serial_open(void){ 

  queue_empty(&input);
  queue_empty(&output);

  UBRR0H = HIGH;
  UBRR0L = LOW; 
  UCSR0B = _BV(7) | _BV(4) | _BV(3); 
  UCSR0C = _BV(2) | _BV(1); //   
  sei(); 
}

void serial_close(void){
  while (!queue_is_empty(&output));
  UCSR0B &=~_BV(7);
  UCSR0B &=~_BV(5);
}

uint8_t serial_get(void){
  
  uint8_t k;

  while (queue_is_empty(&input));
  
  k=queue_front(&input);
  queue_dequeue(&input);
  return k;
}

void serial_put(uint8_t c) {

  while (queue_is_full(&output));

  queue_enqueue(&output,c);
  UCSR0B |= _BV(5);  

}

bool serial_can_read(void){

  return (!queue_is_empty(&input));

}


