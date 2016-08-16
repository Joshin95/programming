#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <pbn.h>   
#include <avr/interrupt.h>
#include "frame.h"


uint8_t print_table[32];
uint8_t send_table[32];

static void pinta(void);

void pinta(void){
  
  frame_block_get(print_table);
  print(print_table);
}

int main(){

  uint8_t lletra, i = 0;
  
  frame_init();
  serial_open();
  sei();
  on_frame_received(pinta);
  
  while(true){
    i = 0;
    lletra = serial_get();
    while (lletra != '\r'){
      serial_put(lletra);
      send_table[i] = lletra;
      i++;
      lletra = serial_get();
    }
    //serial_put('R');
    send_table[i]='\0';
    serial_put('\n');
    while(!frame_can_put());
    //print("BAB");
    frame_block_put(send_table);
  }
}
