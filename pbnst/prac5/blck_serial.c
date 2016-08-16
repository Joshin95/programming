#include <stdio.h>
#include "serial_device.h"
#include "blck_serial.h"
#include <ctype.h>

void print(char s[]){
  uint8_t count;
  
  count = 0;
  while (s[count] != '\0'){
    serial_put(s[count]);
    count++;
  }
}


int readline(char s[], uint8_t m){
  char a;
  int i;

  a = serial_get();
  i = 0;
  while (isgraph(a) && i < m) {
    s[i]=a;
    a = serial_get();
    i++;
  }
  s[i]='\0';

  return i;
}

