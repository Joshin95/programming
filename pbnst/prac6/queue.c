//#define _PC_
#include <stdio.h>	
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#ifndef _PC_
#include <util/atomic.h>
#endif
#include "queue.h"

void queue_empty(queue_t *const q){
#ifndef _PC_
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE){
#endif
    (*q).first=0;
    (*q).top=0;
#ifndef _PC_
  }
#endif
    
  }

bool queue_is_empty(const queue_t *const q){

  return ((*q).top==(*q).first);

}

bool queue_is_full(const queue_t *const q){
  
  if ((*q).top==19 && (*q).first==0)
    return true;
  else
    return ((*q).top)+1==(*q).first;
}

void queue_enqueue(queue_t *const q, uint8_t v){
#ifndef _PC_
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE){
#endif
    if (!queue_is_full(q)){
      (*q).queue[(*q).top]=v;
      (*q).top++;
      if ((*q).top==20)
	(*q).top=0;
    }
#ifndef _PC_
  }
#endif
}

void queue_dequeue(queue_t *const q){
#ifndef _PC_
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE){
#endif
    if (!queue_is_empty(q)){
      (*q).first++;
      if((*q).first==20)
	(*q).first=0;
    }
#ifndef _PC_
}
#endif 
}

uint8_t queue_front(const queue_t *const q){
#ifndef _PC_
  ATOMIC_BLOCK(ATOMIC_RESTORESTATE){
#endif
    if (!queue_is_empty(q))
      return (*q).queue[(*q).first];
    else 
      return -1;
#ifndef _PC_
  }
#endif
  }


