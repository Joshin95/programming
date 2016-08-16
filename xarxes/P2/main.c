#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <pbn.h>   
#include <avr/interrupt.h>
#include "lan.h"


uint8_t print_table[32];
uint8_t send_table[32];
uint8_t origen = 'A';

static void pinta(void);

void pinta(void){

  uint8_t msg_adress;
  
  msg_adress = lan_block_get(print_table);
  serial_put(msg_adress);
  serial_put('-');
  serial_put('>');
  serial_put(origen);
  serial_put(':');
  serial_put(' ');
  print(print_table);
}

int main(){

  uint8_t lletra, i = 0, desti = 0;
  
  lan_init(origen);
  serial_open(); 
  sei(); 

  while(true){
    on_lan_received(pinta);
    i = 0;
    desti = serial_get();
    serial_put(desti);
    lletra = serial_get();
    while (lletra != '\n'){
      serial_put(lletra);
      if (lletra != ':'){
	send_table[i] = lletra;
	i++;
      }
      lletra = serial_get();
    }
    send_table[i]='\0';
    serial_put('\n');
    lan_block_put(send_table,desti);
  }
}
