#include <stdio.h>
#include <stdint.h>
#include <avr/io.h>
#include "control_PWM_TMR1.h"

void setup_PWM_TMR1(){
  DDRB |= (1 << DDB1);//Output  Pin 9 d'Arduino
  TCCR1A=0b10000010;  //OC1A: Clear on compare match, Fast PWM, TOP=ICR1
  TCCR1B=0b00011001;  //No pre-escaling, Fast PWM, TOP=ICR1
  TCCR1C=0b00000000; 
  ICR1=199;
}

void set_PWM_TMR1(uint8_t value){
  OCR1A=value;
}
