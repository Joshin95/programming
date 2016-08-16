#define _POSIX_C_SOURCE 200809L
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char *argv[]){

  int i;

  if (argc==3){
    for(i=0;i<3;i++){
      printf("%s\n",argv[i]);
    }
    exit(EXIT_SUCCESS);
  }
  else
    printf("malament\n");
    exit(EXIT_FAILURE);
  
  return 0;
}
