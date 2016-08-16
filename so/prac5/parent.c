#define _POSIX_C_SOURCE 200809L
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){

  int i=0,j=0;
  int status;
  pid_t childpid,x;
  int fills[4];
  

  while(i<4){

    childpid=fork();
    
    switch(childpid){
    case -1:
      perror("Error en la creació del procés\n");
      exit(EXIT_FAILURE);
      break;
    case 0:
      printf("Soc el procés %i\n",i);
      exit(EXIT_SUCCESS); //el proces acaba
      break;
    default: //es proces pare
      fills[i]=childpid;
      printf("Sóc el pare i he creat un fill\n");
      break;
    }
    i++;

  }

  while(j<4){
    x=wait(&status);
    if (WIFEXITED(status)){
      printf("Sóc el pare i el fill %i ha finalitzat\n",x);
    }
    j++;
  }

  printf("%i\t",fills[0]);
  printf("%i\t",fills[1]);
  printf("%i\t",fills[2]);
  printf("%i\t",fills[3]);
 
  return 0;
}
