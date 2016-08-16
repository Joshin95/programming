#include "frame.h"
#include "error_morse.h"
#include <pbn.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <util/delay.h>
#include <avr/io.h>

#include <avr/interrupt.h>

//transmissor
typedef enum {transmetent0,transmetent1,espera_0,espera_ACK0,espera_1,espera_ACK1} estat_t;
typedef enum {eMR,eFBP,eTimeOut} event_t;

static uint8_t block_morse_table_tran[32];
static uint8_t trama[32];
static uint8_t app[32]; //aixo es podra eliminar quan borrem el main
static uint8_t chk_table[32];
static uint8_t block_morse_table_r[32];

static volatile timer_handler_t timer, retimer;

static volatile estat_t t_state;
static volatile event_t event;

static volatile bool retimer_b = false, timer_b = false;

//receptor
static uint8_t trama_control[4];
static uint8_t app_table[32];

static volatile frame_callback_t callback_apk = 0;

typedef enum {estat0,estat1} estat_r;

static volatile estat_r r_state;

//funcions trans
static void automat_trans(event_t event);
static void crea_trama(const block_morse b, uint8_t valor);
static void control(void);
static void start_timer(void);
static void prep_chksm(block_morse b);
static void time_out(void);
static void start_reenvia(void);
static void reenvia(void);

//funcions rec
static void extreure_msg(void);
static void state_rec(void);
static void envia_control(char);

static volatile pin_t pin;

void frame_init(void){


  timer_init();
  ether_init();

  t_state = espera_0;
  r_state = estat0;
  
  on_message_received(control);

}

void control(void){

  ether_block_get(block_morse_table_r);
  prep_chksm(block_morse_table_r);
  //print(block_morse_table_r);
  
  if (block_morse_table_r[0] == 'A' || block_morse_table_r[0] == 'B')
    
    automat_trans(eMR);

  else if (block_morse_table_r[0] == '1' || block_morse_table_r[0] == '0')
    
    state_rec();

  else
    print("ERR_REC");

}

bool frame_can_put(void){

  return (t_state == espera_0 || t_state == espera_1);

}

void frame_block_put(const block_morse b){

  strncpy(trama, b, 32);
  automat_trans(eFBP);

}

void frame_block_get(block_morse b){

  strncpy(b, app_table, 32);

}

void extreure_msg(void){

  uint8_t i = 1, count = 0;
  
  while (block_morse_table_r[i+2] != '\0'){
    app_table[count] = block_morse_table_r[i];
    i++;
    count++;
  }
  app_table[count] = '\0';
  
}

void crea_trama(const block_morse b, uint8_t valor){

  uint8_t i = 0, count = 1;

  calc_chksm(b);
  block_morse_table_tran[0] = valor;
  while (b[i] != '\0'){
    if (i < 24){
      block_morse_table_tran[count] = b[i];
      i++;
      count++;
    }
  }
  block_morse_table_tran[count] = '\0';
}

void start_timer(void){

  uint16_t ticks2;
  ticks2 = ((rand()>>2)+3000);

  if (t_state == transmetent0){
    t_state = espera_ACK0;
    //print("TIM_ENC");
    timer_b = true;
    timer = timer_after(TIMER_MS(ticks2), time_out);}

  else if (t_state == transmetent1){
    t_state = espera_ACK1;
    //print("TIM_ENC");
    timer_b = true;
    timer = timer_after(TIMER_MS(ticks2), time_out);}
  //pin = pin_create(&PORTB, 5, Output);
  
}

void start_reenvia(void){

  uint16_t ticks;
  ticks = ((rand()>>2)+3000);

  retimer_b = true;
  retimer = timer_after(TIMER_MS(ticks),reenvia);
}

void reenvia(void){

  //print("RE");
  retimer_b = false;
  if (t_state == espera_0 || t_state == espera_1)
    automat_trans(eFBP);
  else 
    automat_trans(eTimeOut);
}
		       
void time_out(void){
  
  timer_b = false;
  automat_trans(eTimeOut);

}

void prep_chksm(block_morse b){

  uint8_t i = 1, count = 0;
  
  while (b[i] != '\0'){
    chk_table[count] = b[i];
    i++;
    count++;
  }
  chk_table[count] = '\0';
}

void envia_control(char valor){

  if (ether_can_put()){
    trama_control[0] = valor;
    trama_control[1] = '\0';
    calc_chksm(trama_control);
    //print(trama_control);
    ether_block_put(trama_control);
  }
  else
    print("NO_ENV_ACK");
}

void on_frame_received(frame_callback_t l){

  callback_apk = l;
  
}

void state_rec(void){

  /*serial_put(r_state);
    print("rec");*/
  
  switch (r_state){
  case (estat0):
    //serial_put(chk_chksm(chk_table));
    if ((!chk_chksm(chk_table)) || (block_morse_table_r[0] == '1')){
      //serial_put('2');
      r_state = estat0;
      envia_control('B');
    }
    else if ((chk_chksm(chk_table)) && (block_morse_table_r[0] == '0')){
      r_state = estat1;
      extreure_msg();
      //print(app_table);
      if (callback_apk){
	callback_apk();
      }
      envia_control('A');
    }
    break;
 case (estat1):
    if ((!chk_chksm(chk_table)) || (block_morse_table_r[0] == '0')){
      //serial_put('4');
      r_state = estat1;
      envia_control('A');
    }
    else if ((chk_chksm(chk_table)) && (block_morse_table_r[0] == '1')){
      r_state = estat0;
      extreure_msg();
      //print(app_table);
      if (callback_apk){
	callback_apk();
      }
      envia_control('B');
    }
    break;
  }
}

void automat_trans(event_t event){

  /*serial_put(t_state);
    print("trans");*/
  
  switch (t_state) {
    
  case (espera_0):
    switch (event){
      
    case (eMR):
      t_state = espera_0;
      break;
      
    case (eFBP):
      if (ether_can_put()){
	crea_trama(trama,'0');
	t_state = transmetent0;
	ether_block_put(block_morse_table_tran);
	if (retimer_b){
	  //print("RT_OFF");
	  timer_cancel(retimer);
	  retimer_b = false;
	}
	on_finish_transmission(start_timer);
      }
      else {
	//print("RT_ON");
	t_state = espera_0;
	start_reenvia();
      }
      break;
     
    }
    break;
    
  case (espera_ACK0):
    switch (event){
      
    case (eMR):
      if (!chk_chksm(block_morse_table_r) || (block_morse_table_r[0] == 'B')){
	t_state = espera_ACK0;
      }
      else if (chk_chksm(block_morse_table_r) && (block_morse_table_r[0] == 'A')){
	t_state = espera_1;
	//print(block_morse_table_r);
	if (timer_b){
	  //print("TIM_CAN");
	  timer_cancel(timer);
	  timer_b = false;
	}
      }
      break;
      
    case (eTimeOut):
      if (ether_can_put()){
	t_state = transmetent0;
	ether_block_put(block_morse_table_tran);
	on_finish_transmission(start_timer);
      }
      else {
	t_state = espera_ACK0; //aqui sha de mirar si hem danar a espera0
	//print("RETIM_ENC");
	start_reenvia();
	
      }
      break;
    }
    break;
    
  case (espera_1):
    switch (event){
      
    case (eMR):
      t_state = espera_1;
      break;
      
    case (eFBP):
      if (ether_can_put()){
	crea_trama(trama,'1');
	t_state = transmetent1;
	ether_block_put(block_morse_table_tran);
	if (retimer_b){
	  //print("RETIM_CAN");
	  timer_cancel(retimer);
	  retimer_b = false;
	}
	on_finish_transmission(start_timer);
      }
      else {
	t_state = espera_1;
	//print("RETIM_ENC");
	start_reenvia();
      }
      break;
      
    }
    break;
    
  case (espera_ACK1):
    switch (event){
      
    case (eMR):
      if (!chk_chksm(block_morse_table_r) || (block_morse_table_r[0] == 'A')){
	t_state = espera_ACK1;
      }
      else if (chk_chksm(block_morse_table_r) && (block_morse_table_r[0] == 'B')){
	t_state = espera_0;
	//print(block_morse_table_r);
	if (timer_b){
	  //print("TIM_CAN");
	  timer_cancel(timer);
	  timer_b = false;
	}
      }
      break;
      
    case (eTimeOut):
      if (ether_can_put()){
	t_state = transmetent1;
	ether_block_put(block_morse_table_tran);
	on_finish_transmission(start_timer);
      }
      else {
	t_state = espera_ACK1;
	//print("RETIM_ENC");
	start_reenvia();
      }
      break;
      
    }
    break;
    
  }
}
    
/*int main(void){

  uint8_t i = 0, count = 0;

  _delay_ms(5000);

  frame_init();
  serial_open();
  
  sei();

  while(!frame_can_put());

  print("1");
  app[0] = 'S';
  app[1] = 'O';
  app[2] = 'S';
  app[3] = '\0';
  
  frame_block_put(app);
  
  while(!frame_can_put());
  
  print("2");
  
  app[0] = 'O';
  app[1] = 'S';
  app[2] = 'O';
  app[3] = '\0';
  
  frame_block_put(app);

  while(!frame_can_put());
  
  print("3");
  app[0] = 'S';
  app[1] = 'S';
  app[2] = 'O';
  app[3] = '\0';
  
  frame_block_put(app);

  while(true);
  
}
*/
