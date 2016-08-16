#ifndef FRAME_H
#define FAME_H
#include <inttypes.h>
#include <stdbool.h>
#include <pbn.h>

typedef void (*frame_callback_t)(void);

void frame_init (void); 
bool frame_can_put (void);
void frame_block_put (const block_morse b);
// bool lan_can_get (void);
void frame_block_get (block_morse b);
void on_frame_received ( frame_callback_t l);

#endif
