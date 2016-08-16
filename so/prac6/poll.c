#include "shrtbl.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>


int main(int argc, char *argv[]) {

  
  bind_shared_table(); // esta be sha de fer sempre quan es vol accedir a la memoria
  
  if (argc==3 && !strcmp(argv[1],"new")){
    printf("%s\n",argv[2]);
    printf("1\n");
    //printf("%i\n",atoi(argv[3]));
    add_party(argv[2]);
    printf("2\n");
    //inc_votes(argv[2],atoi(argv[3]));
  }

  else if (argc==4 && !strcmp(argv[1],"add")){
    inc_votes(argv[2],atoi(argv[3]));}

  /*printf("%i\n",get_nparties());
  printf("PRINT");
  add_party("GREGOR");
  printf("%i\n",get_nparties());
  add_party("PERE");
  printf("%i\n",get_nparties());
  inc_votes("GREGOR",5);
  inc_votes("GREGOR",5);
  */
  //while(true);
  
  return 0;

}
