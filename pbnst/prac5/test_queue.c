#include "queue.h"
#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>




int main(){
  
  queue_t q;
  uint8_t val;
  bool b;

  queue_empty(&q);
  b=queue_is_empty(&q);
  printf("Is empty? %d\n",b);
  queue_enqueue(&q,1);
  b=queue_is_empty(&q);
  printf("Is empty? %d\n",b);
  queue_enqueue(&q,2);
  val=queue_front(&q);
  printf("Valor front: %d\n",val);
  queue_dequeue(&q);
  val=queue_front(&q);
  printf("Valor front: %d\n",val);
  queue_dequeue(&q);
  b=queue_is_empty(&q);
  printf("Is empty? %d\n",b);
  queue_enqueue(&q,1);
  queue_enqueue(&q,2);
  queue_enqueue(&q,3);
  queue_enqueue(&q,4);
  queue_enqueue(&q,5);
  queue_enqueue(&q,6);
  queue_enqueue(&q,7);
  queue_enqueue(&q,8);
  queue_enqueue(&q,9);
  queue_enqueue(&q,10);
  queue_enqueue(&q,11);
  queue_enqueue(&q,12);
  queue_enqueue(&q,13);
  queue_enqueue(&q,14);
  queue_enqueue(&q,15);
  queue_enqueue(&q,16);
  queue_enqueue(&q,17);
  queue_enqueue(&q,18);
  b=queue_is_full(&q);
  printf("Is full? %d\n",b);
  queue_enqueue(&q,19);
  b=queue_is_full(&q);
  printf("Is full? %d\n",b);
  
}
