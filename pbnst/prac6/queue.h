#ifndef _QUEUE_H	
#define _QUEUE_H
#define LONG 20
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>

typedef struct {
  uint8_t queue[LONG], first, top;
} queue_t;

void queue_empty(queue_t *const q);

bool queue_is_empty(const queue_t *const q);

bool queue_is_full(const queue_t *const q);

void queue_enqueue(queue_t *const q, uint8_t v);

void queue_dequeue(queue_t *const q);

uint8_t queue_front(const queue_t *const q);


#endif
