#include <stdio.h>
#include "codif.h"
#include "itu.h"
#include "streamencode.h"

morse_char_t m;
morse_table_t itu_table;
FILE *in;
FILE *out;
FILE *fp;
FILE *fp1;
char *q;
char d;

int main(int argc, char *argv[]){
  
  int s;
  streamencoder_init();  
  if(argc==2){
    if(strcmp(argv[1],"-d")==0){
      do_descodifica(stdin,stdout);
  }
  }
  else {
    do_codifica(stdin,stdout);
  }
  return 0;
}

