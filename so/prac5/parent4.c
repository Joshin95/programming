#define _POSIX_C_SOURCE 200809L
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

#define STRING "string"
#define NOM_PROCES 8
#define NUM_PROCES 3

int main(){

  int i=0,j=0,k,s;
  int status;
  pid_t childpid,pid;
  pid_t fills[4];
  char nom[NOM_PROCES];
  char no[NUM_PROCES];
  

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
      printf("G\n");
      sprintf(nom,"child%i",i);
      sprintf(no,"%i",i);
      execlp("./child",nom,STRING,no,NULL); //posem el nom del fitxer compilat
      break;
    default: //es proces pare
      fills[i]=childpid;
      printf("Sóc el pare i he creat un fill\n");
      break;
    }
    i++;
  }
  while(j<4){
    pid=wait(&status);
    printf("%i-------",WIFEXITED(status));
    if (WIFEXITED(status)){ //macro de wait, retorna 1 si acaba normal
      if(WEXITSTATUS(status)){ //1 si acaba normal-malament
	printf("Error\n");
	exit(EXIT_FAILURE); //el pare mor
      }
      else //0 si acaba normal-be
	printf("Sóc el pare i el fill %i ha finalitzat\n",pid);
    }
    else if (WIFSIGNALED(status)){
	printf("El proces %i ha petat\n",pid);
	}
    j++;
  }

  return 0;
}
