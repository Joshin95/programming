#include <stdbool.h>
#include <avr/interrupt.h>
#include "control_TMR0.h"
#include "adc.h"
#include "serial_device.h"
#include <stdio.h> 
#include "utils.h"
#include <math.h>

uint8_t entrada;

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
  while(true){
  }
  return 0;
}

ISR(TIMER0_COMPA_vect){
  //static uint8_t a='A';

  PORTD |= (1<<PD4);
  
  entrada = read8_ADC();
  start_ADC();

  serial_put(entrada);
  //if (a>'Z'){
  //  a='A';
  //}

  PORTD &= ~(1<<PD4);

}
