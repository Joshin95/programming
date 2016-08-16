#include <stdbool.h>
#include <avr/interrupt.h>
#include "control_TMR0.h"
#include "control_PWM_TMR1.h"
#include "adc.h"
#include "serial_device.h"


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

static int16_t mostra;
static int16_t mostra_1 = 0;
static int16_t mostra_2 = 0;
static int16_t N = 0;
static int32_t Goertzel = 0;
int16_t prod1, prod2;
uint8_t entrada;
const int16_t coef_697 = 440;		// Detectar 697 Hz


void setup(){
  setup_TMR0();
  setup_PWM_TMR1();    //pin 9 Arduino com PWM
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


  entrada = read8_ADC();
  start_ADC();

  PORTD |= (1<<PD4);
 
  mostra = entrada + (((int32_t)mostra_1*coef_697)>>8) - mostra_2;
  mostra_2 = mostra_1;
  mostra_1 = mostra;
  N++;
  
  if (N==105)
    {
      prod1 = ((int32_t)mostra_1 * mostra_1) + ((int32_t)mostra_2 * mostra_2); 
      prod2 = (((int32_t)mostra_1 * coef_697)>>8)*mostra_2;
      Goertzel = prod1 - prod2; //valor goertzel
      N = 0; //reinicialitzem
      mostra_1 = mostra_2 = 0;
    }
  
  //to do
  serial_put(Goertzel_L); //Variable Goertzel de 16bits i serial put treballa amb 8bits.
  serial_put(Goertzel_H)
  // s'ha de partir en 4 parts pk es de 32bits i el serial put trebala amb 8, tambe es podria utilitzar la funcio del bonet de print pro io no se fer (GREGOR)
  PORTD &= ~(1<<PD4);
}
// hem calculat amb octave que amb 16 bits la variable mostra es suficient i la variable goertzel ha de ser de 32
