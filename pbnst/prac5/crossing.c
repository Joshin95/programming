#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <ctype.h>
#include <util/delay.h>
#include <avr/io.h>
#include "control.h"
#include "blck_serial.h"
#include "serial_device.h"

int main(void){

  char c[20];
  int value;
  uint8_t m; 
  semaph_state_t state;
  control_init();
  serial_open();
  print("START\r\n\0");
  m=1;
  while(true){
    value = readline(c,m);
    if (c[0]=='F'){
      state = control_get_state(StreetA);
      if (state != SemOff){
	  if (c[1]=='A'){
	    control_force(StreetA);
	    print("OK\r\n\0");
	  }
	  else if (c[1]=='B'){
	    control_force(StreetB);
	    print("OK\r\n");
	  } 
      }
      else
	print("COMERR\r\n\0");
    }
    else if (c[0]=='?'){
      if (c[1]=='A'){
	state = control_get_state(StreetA);
	if (state == SemOff)
	  print("OFF\r\n\0");
	else if (state == SemClear)
	  print("CLEAR\r\n\0");
	else if (state == SemApproach)
	  print("APPROACH\r\n\0");
	else if (state == SemStop)
	  print("STOP\r\n\0");
      }
      else if (c[1]=='B'){
	state = control_get_state(StreetB);
	if (state == SemOff)
	  print("OFF\r\n\0");
	else if (state == SemClear)
	  print("CLEAR\r\n\0");
	else if (state == SemApproach)
	  print("APPROACH\r\n\0");
	else if (state == SemStop)
	  print("STOP\r\n\0");
      }
      else{
	print("COMERR\r\n\0");
      }
    }
    else if (c[0]=='R'){
      control_on();
      m=2;
      print("OK\r\n\0");
    }
    else if (c[0]=='H'){
      control_off();
      print("OK\r\n\0");
    }
  }
  return 0;
}
