#include <stdbool.h>
#include <avr/interrupt.h>
#include "control_TMR0.h"
#include "adc.h"
#include "serial_device.h"
#include <stdio.h> 
#include "utils.h"
#include <math.h>

#define llindar 350000

static int16_t mostra[8];
static int16_t mostra_1[8] = {0,0,0,0,0,0,0,0};
static int16_t mostra_2[8] = {0,0,0,0,0,0,0,0};
static int16_t N = 0;
//static uint8_t p = 0;
static int32_t Goertzel = 0;
static int32_t prod1, prod2;
uint8_t entrada;
static char x;
const int16_t coef[8] = {439,421,401,380,295,254,210,149};
const int16_t freq_L[4] = {697,770,852,941};
const int16_t freq_H[4] = {1209,1336,1477,1633};
static int32_t val_g_L[4];
static int32_t val_g_H[4];
static int uart_putchar(char c, FILE *stream);
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL,_FDEV_SETUP_WRITE);
static int uart_putchar(char c, FILE *stream){
  if (c == '\n')
    uart_putchar('\r', stream);
  loop_until_bit_is_set(UCSR0A, UDRE0);
  UDR0 = c;
  return 0;
}

typedef enum {espera_to , espera_espai} estat_t;

static volatile estat_t estat = espera_to;


char descodifica(int freq1, int freq2){
  if (freq1==697 && freq2==1209)
    return '1';
  else if (freq1==697 && freq2==1336)
    return '2';
  else if (freq1==697 && freq2==1477)
    return '3';
  else if (freq1==697 && freq2==1633)
    return 'A';
  else if (freq1==770 && freq2==1209)
    return '4';
  else if (freq1==770 && freq2==1336)
    return '5';
  else if (freq1==770 && freq2==1477)
    return '6';
  else if (freq1==770 && freq2==1633)
    return 'B';
  else if (freq1==852 && freq2==1209)
    return '7';
  else if (freq1==852 && freq2==1336)
    return '8';
  else if (freq1==852 && freq2==1477)
    return '9';
  else if (freq1==852 && freq2==1633)
    return 'C';
  else if (freq1==941 && freq2==1209)
    return '*';
  else if (freq1==941 && freq2==1336)
    return '0';
  else if (freq1==941 && freq2==1477)
    return '#';
  else if (freq1==941 && freq2==1633)
    return 'D';
  else
    return 'N';
}

void setup(){
  setup_TMR0();
  setup_ADC(5,5,16);//(adc_input,v_ref,adc_pre),adc_input (0-5 (default=5),8 Tª, 14 1.1V, 15 GND ,v_ref 0 (AREF), 1(1.1V), default=5 (5V), adc_pre 2,4,8,16(default),32,64,128
  start_ADC();
  DDRD |=(1<<DDD4);    //pin 4 Arduino com sortida
                       //Mostra el periode de mostreig
  DDRB |=(1<<DDB5);    //pin 13 (LED) Arduino com sortida
                       //indica yn>A
  DDRB |=(1<<DDB4);    //pin 12       Arduino com sortida
                       //indica yn<-A
  serial_init();
  sei();
}

int main(void){
  setup();
  stdout=&mystdout;
  while(true){
  }
  return 0;
}

ISR(TIMER0_COMPA_vect){

  PORTD |= (1<<PD4);
  
  entrada = read8_ADC();
  start_ADC();

  
  for(uint8_t i = 0;i < 8;i++) {
    mostra[i] = entrada + (((int32_t)mostra_1[i]*coef[i])>>8) - mostra_2[i];
    mostra_2[i] = mostra_1[i];
    mostra_1[i] = mostra[i];
  }

  N++;
  
  if (N==197) {

    for(uint8_t i = 0;i < 8;i++) {
      prod1 = ((int32_t)mostra_1[i] * mostra_1[i]) + ((int32_t)mostra_2[i] * mostra_2[i]); 
      prod2 = (((int32_t)mostra_1[i] * coef[i])>>8)*mostra_2[i];
      Goertzel = prod1 - prod2; //valor goertzel
      N = 0; //reinicialitzem
      mostra_1[i] = 0;
      mostra_2[i] = 0;
      if (i<4)
	val_g_L[i] = Goertzel;
      else
	val_g_H[i-4] = Goertzel;
      //printf("%ld\n",val_g_L[0]);
    }
     
    int32_t temp1 = 0;
    int32_t temp2 = 0;
    uint8_t to1 = 0;
    uint8_t to2 = 0;
    
    for(uint8_t i = 0;i < 4;i++) {
      if(val_g_L[i] > temp1){
	temp1 = val_g_L[i];
	to1 = i;
      }
      if(val_g_H[i] > temp2) {
	temp2 = val_g_H[i];
	to2 = i;
      }
    }

    //printf("%ld;",temp1);
    //printf("%ld",temp2);
    //printf("\n");
    

    //AQUI TENIM ELS 2 VALORS MAXIMS
    if (estat == espera_to) {
      if (temp1 > llindar && temp2 > llindar){
	//printf("%i\n",freq_L[to1]);
	//printf("%i\n",freq_H[to2]);
	x=descodifica(freq_L[to1],freq_H[to2]);
	//printf("VAL\n");
	printf("%c",x);
	estat = espera_espai;
      }
      else {
	estat = espera_to;
	//nothing to do,hem detectat unaltre espai
      }
    }
    else if (estat == espera_espai) {
      if (temp1 > llindar && temp2 > llindar){
	estat = espera_espai;
      }
      else {
	//	printf("%ld\n",temp1);
	//	printf("%ld\n",temp2);
	printf("%c",' ');
	estat = espera_to;
      }	
    }

    setup_TMR0(); //reiniciem timer
    start_ADC(); //inicialitzem conversio
    //per evitar laleatorietat de la primera mostra; que fa variar la potencia del filtre, mes baixa, i disminuir la variabilitat del valor, que es mes gran si no posem aixo
    TIFR0 |= (1<<1); //estem posant a 0 el flag d'interrupcio del timer pk entrem just acabat el calcul

  }  
  PORTD &= ~(1<<PD4);
}
