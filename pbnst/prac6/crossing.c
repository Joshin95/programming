#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <avr/interrupt.h>
#include <ctype.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/sfr_defs.h>
#include "serial_device.h"
#include "queue.h"
#include "blck_serial.h"
#include "gpio_device.h"
#include "lamp.h"
#include "semaph.h"
#include "control.h"
#include "ether.h"

int main(){

  semaph_state_t estat;
  uint8_t c;
  char lectura[20];
  int valor;

  ether_init(); //modificacio prac6

  serial_open();
  control_init();
  c=1; //esperem un Run el primer cop, nomes un caracter a la taula!
  print("START\r\n\0");

  while(true){
    valor = readline(lectura, c);
    if (lectura[0]=='F'){
      estat = control_get_state(StreetA);
      if (estat != SemOff){
	  if (lectura[1]=='A'){
	    control_force(StreetA);
	    print("OK\r\n\0");
	    ether_put('F');
	    ether_put('A');
	    ether_put(' ');
	  }
	  else if (lectura[1]=='B'){
	    control_force(StreetB);
	    print("OK\r\n\0");
	    ether_put('F');
	    ether_put('B');
	    ether_put(' ');
	  } 
      }
      else
	print("COMERR\r\n\0");
    }
    else if (lectura[0]=='?'){
      if (lectura[1]=='A'){
	estat = control_get_state(StreetA);
	if (estat == SemOff)
	  print("OFF\r\n\0");
	else if (estat == SemClear)
	  print("CLEAR\r\n\0");
	else if (estat == SemApproach)
	  print("APPROACH\r\n\0");
	else if (estat == SemStop)
	  print("STOP\r\n\0");
      }
      else if (lectura[1]=='B'){
	estat = control_get_state(StreetB);
	if (estat == SemOff)
	  print("OFF\r\n\0");
	else if (estat == SemClear)
	  print("CLEAR\r\n\0");
	else if (estat == SemApproach)
	  print("APPROACH\r\n\0");
	else if (estat == SemStop)
	  print("STOP\r\n\0");
      }
      else{
	print("COMERR\r\n\0");
      }
    }
    else if (lectura[0]=='R'){
      estat=control_get_state(StreetB); //comprovem un dels dos
      if (estat == SemOff){ //nomes replica si ordre valida
	control_on();
	c=2;
	print("OK\r\n\0");
	ether_put('R');
	ether_put(' ');
      }
      else 
	print("COMERR\r\n\0");
    }
    else if (lectura[0]=='H'){
      estat=control_get_state(StreetB);
      if (estat != SemOff){ //nomes replica si ordre valida
	control_off();
	print("OK\r\n\0");
	ether_put('H');
	ether_put(' ');
      }
      else 
	print ("COMERR\r\n\0");
    }
  }
  return 0;
}
