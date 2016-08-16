#ifndef gpio_device
#define gpio_device
#include <stdbool.h>


typedef enum {Input,Output} pin_direction_t;

typedef struct {
  volatile uint8_t *port;
  uint8_t pin;
} pin_t;


pin_t pin_create(volatile uint8_t *port, uint8_t pin, pin_direction_t d);

void pin_w(pin_t p, bool v);
bool pin_r(pin_t p);
void pin_toggle(pin_t p);
void pin_destroy(pin_t *const p);

#endif
