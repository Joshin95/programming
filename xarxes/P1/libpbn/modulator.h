#ifndef MODULATOR_H
#define MODULATOR_H

#include <stdbool.h>
/*
 * The module implements a trivial modulator that
 * outputs the signat through fixed pin PD6.
 */

/*
 * Initializes the module. 
 */

void modulator_init(void);

/* 
 * true means high level 
 */
void modulator_set(bool l);

#endif
