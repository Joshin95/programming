#include "lan.h"
#include "error_morse.h"
#include <pbn.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <util/delay.h>
#include <avr/io.h>


#include <avr/interrupt.h>

typedef enum {Esperant, Pendent_enviar} state_t;
typedef enum {eAT, eTm} event_t;

static uint8_t block_morse_tablet[32];
static uint8_t app_table[32]; //el mateix que block_morse
static uint8_t block_morse_table_r[32];

static uint8_t a_origen, a_origen_r;
static timer_handler_t timer;
static uint8_t nr_callbacks = 0;
static pin_t l;
static state_t estat;
static event_t event;
static bool can_put;
static lan_callback_t callback_apk;
static ether_callback_t callback_lan;

static void automat_trans(event_t event);
static void reintent(void);
static void comprova(void);
static void turn_off(void);
static void errort(void);
static void crea_trama(const block_morse b,uint8_t nd);


void turn_off(){
   pin_w(l,false);
}

void lan_init (uint8_t no){

  timer_init();
  ether_init();
  
  estat = Esperant;
  l = pin_create(&PORTB,5,Output);
  a_origen = no;
  on_message_received(comprova);
}

bool lan_can_put (void){

  return estat == Esperant;
  
}

void automat_trans (event_t event){

  if ((ether_can_put()) && (estat==Esperant)){
      if (event==eAT){
	estat=Esperant;
	ether_block_put(block_morse_tablet);
      }
      else if (event==eTm){
	estat=Esperant;
	errort();
      }     
    }
  else if ((ether_can_put()) && (estat==Pendent_enviar)){
      if (event==eAT){
	estat=Pendent_enviar;
	errort();
      }
      else if (event==eTm){
	estat=Esperant;
	ether_block_put(block_morse_tablet);
	timer_cancel(timer);
	nr_callbacks=0; // Variable que indica el nombre maxim de repeticions.
      }
    }
  else if ((!ether_can_put()) && (estat==Esperant)){
    if (event==eAT){
      estat=Pendent_enviar;
      reintent();
      }
      else if (event==eTm){
	estat=Esperant;
	errort();
      }
    }
  else if ((!ether_can_put()) && (estat==Pendent_enviar)){
      if (event==eAT){
	estat=Pendent_enviar;
	errort();
      }
      else if (event==eTm) //En aquest cas no fem res.
	estat=Pendent_enviar;
    }     
}


void errort(void){

  pin_w(l,true);
  timer_after(TIMER_MS(5000), &turn_off);
  
}

void reintent(void){

  uint16_t ticks = 0;
  
  if (nr_callbacks < 3){
    ticks = ((rand()>>2)+3000);
    timer = timer_after(TIMER_MS(ticks), &reintent);
    nr_callbacks++;
    automat_trans(eTm);
  }
  else{
    estat = Esperant;
    nr_callbacks = 0;
    errort();
  }
}

void crea_trama(const block_morse b,uint8_t nd){

  uint8_t i = 0, count = 2;

  calc_chksm(b);
  block_morse_tablet[0] = a_origen;
  block_morse_tablet[1] = nd;
  while (b[i] != '\0'){
    if (i < 24){
      block_morse_tablet[count] = b[i];
      i++;
      count++;
    }
    else{
      estat = Esperant;
      timer_cancel(timer);
    }
  }
  block_morse_tablet[count] = '\0';    

}
void lan_block_put (const block_morse b,uint8_t nd){

  crea_trama(b,nd);
  automat_trans(eAT);
  
}

void comprova(void){

  uint8_t i = 2, count = 0;

  ether_block_get(block_morse_table_r);

  if (a_origen == block_morse_table_r[1]){
    if (chk_chksm(block_morse_table_r)){
      while (block_morse_table_r[i+2] != '\0'){
	app_table[count] = block_morse_table_r[i];
	i++;
	count++;
      }
      a_origen_r = block_morse_table_r[0];
      app_table[count] = '\0';
      callback_apk();
    }	
  }
}

uint8_t lan_block_get (block_morse b){

  strncpy(b, app_table, 32);
  return a_origen_r;
}

void on_lan_received ( lan_callback_t l){

  callback_apk = l;

}
