#ifndef _ERROR_MORSE_
#define _ERROR_MORSE_

#include <stdbool.h>
#include <stdint.h>

void calc_chksm(uint8_t *chars);
bool chk_chksm(uint8_t *llista);
void crc_morse(uint8_t *llista);
bool test_crc_morse(uint8_t *llista);

#endif
