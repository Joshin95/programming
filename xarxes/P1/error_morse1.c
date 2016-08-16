#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

uint8_t taula[20];

typedef struct{
  char char_h;
  char char_l;
} tupla;

static tupla byte2hex(uint8_t value);
static char convert2hex(uint8_t value);
static uint8_t hex2byte(tupla chars);
static uint8_t convert2byte(char c);
static void calc_chksm(uint8_t *chars);

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
    if (i % 2 == 0){
      printf("%c\n",llista[i]);
      acum.char_h = llista[i];
    }
    else{
      printf("%c\n",llista[i]);
      acum.char_l = llista[i];
      suma += hex2byte(acum);
    }
    /*else {
      suma += hex2byte(acum);
      }*/
    i++;
  }

  printf("%d\n",suma);
  copy = suma;
  copy = copy >> 8;
  printf("%d\n",copy);
  suma = mask & suma;
  suma += copy;
  printf("%d\n",suma);
  printf("--------------\n");
  result = byte2hex(~suma);
  
  llista[18]=result.char_l;
  llista[19]=result.char_h;  
}

void chk_chksm(uint8_t *llista){

  tupla acum;
  bool result;

  uint8_t i = 0;
  uint16_t suma = 0;
  uint16_t copy = 0;
  uint16_t mask = 255;

  printf("--------------\n");
  while (llista[i] != '\r'){
    if (i % 2 == 0){
      acum.char_h = llista[i];
    }
    else{
      acum.char_l = llista[i];
      suma += hex2byte(acum);
    }

    i++;
  }

  printf("%d\n",suma);
  acum.char_l=llista[18];
  acum.char_h=llista[19];
  suma += hex2byte(acum);
  
  

  copy = suma;
  printf("%d-\n",copy);
  copy = copy >> 8;
  printf("%d\n",copy);
  suma += copy;
  suma = mask & suma;
  printf("%d\n",suma);
  
  if (suma == mask){
    //result = true;
    printf("%s\n","true");
  }
  else {
    //result = false;
    printf("%s\n","false");
  }
  //return result;
}






int main(){

  
  taula[0] = 'A';
  taula[1] = 'B';
  taula[2] = '5';
  taula[3] = '6';
  taula[4] = '\r';

  calc_chksm(taula);

  printf("%c\n%c\n",taula[18],taula[19]);

  chk_chksm(taula);
  


  /*
  taula c;
  uint8_t v;

  c=byte2hex(9);
  
  printf("%c",c.char_h);
  printf("%c\n",c.char_l);

  v=hex2byte(c);

  printf("%u\n",v);
  
  c=byte2hex(15);
  
  printf("%c",c.char_h);
  printf("%c\n",c.char_l);

  v=hex2byte(c);
  
  printf("%u\n",v);

  return 0;
  */
}
