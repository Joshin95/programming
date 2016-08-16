#include <stdio.h>
#include "serial_device.h"
#include "blck_serial.h"
#include <ctype.h>



int main() {
  
  char s[20];
  
  serial_open();
  while(true){
    readline(s,20);
    print(s);
  }
  serial_close();


}
