#define _POSIX_C_SOURCE 200809L
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){

  int i=0,j=0,k,s;
  int status;
  pid_t childpid,x;
  pid_t fills[4];
  

  while(i<4){

    childpid=fork();
    
    switch(childpid){
    case -1:
      perror("Error en la creació del procés\n");
      for(k=0;k<i;k++){
	kill(fills[i],SIGTERM);
      }
      exit(EXIT_FAILURE);
      i=4;
      break;
    case 0:
      printf("Soc el procés %i\n",i);
      exit(EXIT_FAILURE); //el proces acaba
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
    if (WIFEXITED(status)){ //PREGUNTAR PER UNA DE LES MACROS DE wait
      printf("Sóc el pare i el fill %i ha finalitzat\n",x);
    }
    else if (WIFSIGNALED(status)){
	printf("El proces %i ha petat\n",x);
	}
    j++;
    }
    
  //for(s=0;s<4;s++)
  //printf("%i\t",fills[k]);

  return 0;
}
