#ifndef MTBL_
#define MTBL_
#include "mchar.h"

typedef char morse_table_t[64];
typedef char morse_char_t[6];

void empty_morse_table(morse_table_t t);
void set_translation(morse_table_t t, char c, morse_char_t m);
void mtbl_init(void);
char mtbl_m2a(mchar_t c);
mchar_t mtbl_a2m(char c);

#endif
