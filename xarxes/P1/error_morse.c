#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <pbn.h>   
#include <avr/interrupt.h>
#include <util/crc16.h>

typedef struct{
  char char_h;
  char char_l;
} tupla;

static tupla byte2hex(uint8_t value);
static char convert2hex(uint8_t value);
static uint8_t hex2byte(tupla chars);
static uint8_t convert2byte(char c);



tupla byte2hex(uint8_t value){

  tupla result;
  
  uint8_t masc_h = 0xf0;
  uint8_t masc_l = 0x0f;

  uint8_t val_h = (masc_h & value) >> 4;
  uint8_t val_l = masc_l & value;

  result.char_h = convert2hex(val_h);
  result.char_l = convert2hex(val_l);

  return result;
}

  
char convert2hex(uint8_t value){

  char result;
  //printf("%u\n",value);
  if (value <= 9)
    result = value + 48;
  else if (value > 9 && value < 16)
    result = (value-10) + 65;
  else
    result = -1;
  return result;   
}


uint8_t hex2byte(tupla chars){

  uint8_t val_h = 0;
  uint8_t val_l = 0;
  
  val_h = convert2byte(chars.char_h);
  val_l = convert2byte(chars.char_l);

  uint8_t res = (val_h << 4) | val_l;

  return res;

}

uint8_t convert2byte(char c){

  uint8_t result;

  if (c>47 && c<58)
    result = c - 48;
  else if (c>64 && c<71)
    result = (c - 65) + 10;
  else
    result = -1;

  return result;
}

void calc_chksm(uint8_t *llista){ //els bits mes significatius a l'esquerre, bigendian, mida maxima de la taula 17 caracters (16 começant per 0), pk necessitem 3 espais per la sentinella i el checksum

  uint8_t count = 0;
  char input;
  tupla acum;
  tupla result;
  uint16_t mask = 255;
  uint8_t i = 0;
  uint16_t suma = 0;
  uint16_t copy = 0;

  while (llista[i] != '\r'){
    suma += llista[i];
    i++;
  }
  

  copy = suma;
  copy = copy >> 8;
  suma = mask & suma;
  suma += copy;
  result = byte2hex(~suma);
  llista[18]=result.char_l;
  llista[19]=result.char_h;  
}

bool chk_chksm(uint8_t *llista){

  tupla acum;
  bool result;

  uint8_t i = 0;
  uint16_t suma = 0;
  uint16_t copy = 0;
  uint16_t mask = 255;

   while (llista[i] != '\r'){
    suma += llista[i];
    i++;
    }


  acum.char_l=llista[18];
  acum.char_h=llista[19];
  suma += hex2byte(acum);
  
  

  copy = suma;
  copy = copy >> 8;
  suma += copy;
  suma = mask & suma;
  
  if (suma == mask){
    result=true;
  }
  else {
    result=false;
  }

  return result;
}



void crc_morse(uint8_t *llista){
    
    tupla result;
    uint8_t i = 0;
    uint8_t crc = 0;
    uint8_t abc = 0;  
    
    while (llista[i] != '\r'){
     crc=_crc_ibutton_update(crc,llista[i]);
     i++;
    }
    result = byte2hex(crc);
    llista[18]=result.char_l;
    llista[19]=result.char_h; 
  }


bool test_crc_morse(uint8_t *llista){

  tupla result;
  uint8_t i = 0;
  uint8_t crc = 0;
  uint8_t abc = 0;
  bool final;
  
  while (llista[i] != '\r'){
    crc=_crc_ibutton_update(crc,llista[i]);
    i++;
  }

  result.char_l=llista[18];
  result.char_h=llista[19];

  crc=_crc_ibutton_update(crc,hex2byte(result));

  if (crc==0){
    final=true;
  }
  else{
    final=false;
  }

  return final;  
}
  
