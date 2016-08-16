#ifndef LAN_H
#define LAN_H
#include <inttypes.h>
#include <stdbool.h>
#include <pbn.h>

typedef void (*lan_callback_t)(void);

void lan_init (uint8_t no); 
bool lan_can_put (void);
void lan_block_put (const block_morse b,uint8_t nd) ;
// bool lan_can_get (void);
uint8_t lan_block_get (block_morse b);
void on_lan_received ( lan_callback_t l);

#endif
