#ifndef LAMP_H
#define LAMP_H

#include <inttypes.h>
#include <stdbool.h>

/*
 * A `lamp_t` is an abstraction of a set of three lights colored
 * `Green`, `Yellow` and `Red` that can be switched on/off
 * independently. The lights are assumed to connected to a sequential
 * set of port pins in such a way that the lower oan corresponds to
 * `Green` light.
 */

typedef enum {Green, Yellow, Red} color_t;

typedef struct {
  volatile uint8_t *port;
  uint8_t base_pin; // Corresponds to green light
} lamp_t;


/* Initializes the lamp */
void lamp_init(lamp_t *const l, volatile uint8_t *port, uint8_t base);

/* Lights on the color `c` in lamp `l` */
void lamp_on(lamp_t l, color_t c);

/* Lights off the color `c` in lamp `l` */
void lamp_off(lamp_t l, color_t c);

/* Toggles the color `c` in lamp `l` */
void lamp_toggle(lamp_t l, color_t c);

/* Queries the status of color `c` in lamp `l` */
bool lamp_is_on(lamp_t l, color_t c);

#endif
