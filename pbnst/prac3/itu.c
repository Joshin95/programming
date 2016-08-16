#include <stdio.h>
#include "codif.h"

morse_table_t itu_table;

void itu_init(void){

  set_translation(itu_table,'A',".-");
  set_translation(itu_table,'B',"-...");
  set_translation(itu_table,'C',"-.-.");
  set_translation(itu_table,'D',"-..");
  set_translation(itu_table,'E',".");
  set_translation(itu_table,'F',"..-.");
  set_translation(itu_table,'G',"--.");
  set_translation(itu_table,'H',"....");
  set_translation(itu_table,'I',"..");
  set_translation(itu_table,'J',".---");
  set_translation(itu_table,'K',"-.-");
  set_translation(itu_table,'L',".-..");
  set_translation(itu_table,'M',"--");
  set_translation(itu_table,'N',"-.");
  set_translation(itu_table,'O',"---");
  set_translation(itu_table,'P',".--.");
  set_translation(itu_table,'Q',"--.-");
  set_translation(itu_table,'R',".-.");
  set_translation(itu_table,'S',"...");
  set_translation(itu_table,'T',"-");
  set_translation(itu_table,'U',"..-");
  set_translation(itu_table,'V',"...-");
  set_translation(itu_table,'W',".--");
  set_translation(itu_table,'X',"-..-");
  set_translation(itu_table,'Y',"-.--");
  set_translation(itu_table,'Z',"--..");
  set_translation(itu_table,'0',"-----");
  set_translation(itu_table,'1',".----");
  set_translation(itu_table,'2',"..---");
  set_translation(itu_table,'3',"...--");
  set_translation(itu_table,'4',"....-");
  set_translation(itu_table,'5',".....");
  set_translation(itu_table,'6',"-....");
  set_translation(itu_table,'7',"--...");
  set_translation(itu_table,'8',"---..");
  set_translation(itu_table,'9',"----.");

}
