#include <stdio.h>
#include <avr/io.h>
#include <stdint.h>
#include <stdbool.h>
#include <pbn.h>   
#include <avr/interrupt.h>
#include <util/delay.h>

//FET CUTRE, TEMPS DE BOUNDING CONTROLAT AMB DELAYS, MALAMENT!! sOLUCIONAR

static pin_t Display0,Display1,Display2,Display3,Boto0,Boto1,Boto2,Boto3,Boto4,Boto5,BotoObrir,BotoTancar,Led1,Led2,Led3,Led4,Led5,Led6; 

static uint8_t valor;
static void init(void);



void init(void){

  Display0=pin_create(&PORTD,4,Output);
  Display1=pin_create(&PORTD,5,Output);
  Display2=pin_create(&PORTD,6,Output);
  Display3=pin_create(&PORTD,7,Output);

  Led6=pin_create(&PORTB,0,Output);
  Led5=pin_create(&PORTB,1,Output);
  Led4=pin_create(&PORTB,2,Output);
  Led3=pin_create(&PORTB,3,Output);
  Led2=pin_create(&PORTB,4,Output);
  Led1=pin_create(&PORTB,5,Output);


  Boto0=pin_create(&PORTC,0,Input);
  Boto1=pin_create(&PORTC,1,Input);
  Boto2=pin_create(&PORTC,2,Input);
  Boto3=pin_create(&PORTC,3,Input);
  Boto4=pin_create(&PORTC,4,Input);
  Boto5=pin_create(&PORTC,5,Input);
  BotoObrir=pin_create(&PORTD,3,Input);
  BotoTancar=pin_create(&PORTD,2,Input);

  serial_open();
  sei();
}

int main(void){
  init();
  print("Start");
  while(true){
    while(serial_can_read()){
      valor = serial_get();
      if (valor=='E'){
	valor=serial_get();
	if (valor=='1'){
	  pin_w(Led1,true);
	}
	else if (valor=='2'){
	  pin_w(Led2,true);
	} 
	else if (valor=='3'){
	  pin_w(Led3,true);
	}
	else if (valor=='4'){
	  pin_w(Led4,true);
	} 
	else if (valor=='5'){
	  pin_w(Led5,true);
	}
	else if (valor=='6'){
	  pin_w(Led6,true);
	} 
      }
      
      else if (valor=='A'){
	valor=serial_get();
	if (valor=='1'){
	  pin_w(Led1,false);
	}
	else if (valor=='2'){
	  pin_w(Led2,false);
	} 
	else if (valor=='3'){
	  pin_w(Led3,false);
	}
	else if (valor=='4'){
	  pin_w(Led4,false);
	} 
	else if (valor=='5'){
	  pin_w(Led5,false);
	}
	else if (valor=='6'){
	  pin_w(Led6,false);
	} 
      }

      else if (valor=='D'){
	valor=serial_get();
	if (valor=='1'){
	  pin_w(Display0,true);
	  pin_w(Display1,false);
	  pin_w(Display2,false);
	  pin_w(Display3,false);
	}
	else if (valor=='2'){
	  pin_w(Display0,false);
	  pin_w(Display1,false);
	  pin_w(Display2,false);
	  pin_w(Display3,true);
	} 
	else if (valor=='3'){
	  pin_w(Display0,true);
	  pin_w(Display1,false);
	  pin_w(Display2,false);
	  pin_w(Display3,true);
	}
	else if (valor=='4'){
	  pin_w(Display0,false);
	  pin_w(Display1,false);
	  pin_w(Display2,true);
	  pin_w(Display3,false);
	} 
	else if (valor=='5'){
	  pin_w(Display0,true);
	  pin_w(Display1,false);
	  pin_w(Display2,true);
	  pin_w(Display3,false);
	}
	else if (valor=='6'){
    	  pin_w(Display0,false);
	  pin_w(Display1,false);
	  pin_w(Display2,true);
	  pin_w(Display3,true);
	} 
      }
    }


    if (!pin_r(Boto0)){
      serial_put('B');
      serial_put('1');
      _delay_ms(500);
    }
    else if (!pin_r(Boto1)){
      serial_put('B');
      serial_put('2');
      _delay_ms(500);
    }
    else if (!pin_r(Boto2)){
      serial_put('B');
      serial_put('3');
      _delay_ms(500);
    }
    else if (!pin_r(Boto3)){
      serial_put('B');
      serial_put('4');
      _delay_ms(500);
    }
    else if (!pin_r(Boto4)){
      serial_put('B');
      serial_put('5');
      _delay_ms(500);
    }
    else if (!pin_r(Boto5)){
      serial_put('B');
      serial_put('6');
      _delay_ms(500);
    }
    else if (!pin_r(BotoObrir)){
      serial_put('O');
      serial_put('P');
      _delay_ms(500);
    }
    else if (!pin_r(BotoTancar)){
      serial_put('T');
      serial_put('P');
      _delay_ms(500);
    }  
  }
}

