#include <stdbool.h>
#include <avr/interrupt.h>
#include "control_PWM_TMR1.h"
#include <math.h>
#include "control_TMR0.h"
#include "utils.h"
#include "serial_device.h" //pel serial
#include <stdio.h> //pel serial 


#define  a1 -500//-503
#define  a2  256//256
#define  a1_2 -475//-503
#define  a2_2  256//256
#define  A    60//60
#define  DC  A+1
#define  b0   13//11
#define  b0_2   22//11

#define  A_k  A*256
#define  b0_k b0*256


/********************************************
                 Oscil·lador digital
---------------------------------------------

Aquest programa genera mostres d'un sinus
que actualitzen a una freqüència Fm
la sortida PWM del terminal 9
i generen un sinus de freqüència Fo.

INTERVENEN DUES BASES DE TEMPS
1) Es configura T mostreig (T_m) amb TMR0.
   T_m=(OCR0A+1)/2 us
2) Es configura un senyal PWM amb TMR1.
   (Abans amb TMR2 la màxima f_PWM és 62.5kHz fixe, T_PWM=16 us).
   T_PWM=(1+TOP)/16 us

SINCRONITZACIÓ A REALITZAR
3) Per evitar jitter en la conversió DAC
   cal T_m múltiple de T_PWM.
   T_m=k*T_PWM
   (OCR0A+1)/2=k*(1+TOP)/16

EFECTES DE 3
4) (Abans amb TMR2,TOP=255, i si OCR2A del PWM = 255 tinc rendiment de cicle del 100%)
   Cal que OCR2A<=TOP, en cas contrari el senyal PWM té rendiment del 100%
  
RESUM EQUACIONS A COMPLIR
1)    T_m=(OCR0A+1)/2 us
2)    T_PWM=(1+TOP)/16 us
3)    T_m=k*T_PWM, (OCR0A+1)/2=k*(1+TOP)/16

VALORS TENTATIUS
1)   OCR0A=99==>T_m=50 us / f_m=20 kHz
2)   TOP=199  ==>T_PWM=12.5 us / f_PWM=80 kHz
3)   T_m=4*T_PWM

A més, PORTD4
s'activa en entrar a la interrupció del TMR0 
i es desactiva en sortir.

Joan Martínez (c) 2012
Sota Llicència LGPL v3.0  
(http://www.gnu.org/2licenses/lgpl-3.0.en.html)

Modificat 20121128 per jb

*********************************************/
int16_t yn16_1=b0_k,yn16_2=0;
int16_t yn162_1=b0_k,yn162_2=0;

void setup(){
  setup_TMR0();
  setup_PWM_TMR1();    //pin 9 Arduino com PWM
  DDRD |=(1<<DDD4);    //pin 4 Arduino com sortida
                       //Mostra el periode de mostreig
  DDRB |=(1<<DDB5);    //pin 13 (LED) Arduino com sortida
                       //indica yn>A
  DDRB |=(1<<DDB4);    //pin 12       Arduino com sortida
                       //indica yn<-A
  sei();
}

int main(void){
  setup();
  while(true){
  }
  return 0;
}

ISR(TIMER0_COMPA_vect){
  int8_t yn8,yn82;
  int16_t yn16,yn162;
  PORTD |= (1<<PD4);
  
  // inici filtrat
  yn16=((int32_t)-a1*yn16_1+(int32_t)-a2*yn16_2)>>8;
  yn162=((int32_t)-a1_2*yn162_1+(int32_t)-a2_2*yn162_2)>>8;
  // acaba filtrat
  
  // actualitzo memòria
  yn16_2=yn16_1;
  yn16_1=yn16;

  yn162_2=yn162_1;
  yn162_1=yn162;

 
  // actualitzo PWM
  yn8=yn16>>8;
  yn82=yn162>>8;
  set_PWM_TMR1(((yn8+yn82)>>1)+DC); //millor que la suma i divisio per separat

  PORTD &= ~(1<<PD4);// tarda 11.8us
}
