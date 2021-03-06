#define _POSIX_C_SOURCE 200809L

//#include "matrix.h"

#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <sys/mman.h> //memoria compartida
#include <sys/stat.h> //constants de zona de memoria
#include <fcntl.h> //constant O_xxxx

#define SHARED_MEM "mem"
#define NOM_PROCES 8
#define NUM_PROCES 3
//#define MIDA_MAT 64 //matriu 8x8
//#define MIDA_MEM 3*MIDA_MAT

//COMPILAR com gcc arxiu.c -o arxiu -lrt (llibreria al final)

int main(int argc, char *argv[]){

  int i = 0, j = 0, k, s;
  int status, fd;
  void *addr;
  pid_t childpid, pid;
  pid_t fills[4];
  char nom[NOM_PROCES];
  char no[NUM_PROCES];


  if (argc == 4){
  
    //creem zona de memoria compartida
    fd = shm_open(SHARED_MEM,O_RDWR|O_CREAT,S_IRUSR|S_IWUSR); //creem zona de mc
    if (fd == 1){
      if (shm_unlink(SHARED_MEM) == -1) printf("Error d'esborrat de memoria compartida");
      exit(EXIT_FAILURE); //verifiquem la creacio
    }
    if (ftruncate(fd,SIZE) == -1){ 
      if (close(fd) == -1) printf("Error al tancar arxiu");
      if (shm_unlink(SHARED_MEM) == -1) printf("Error d'esborrat de memoria compartida");
      exit(EXIT_FAILURE); 
    }
    addr = mmap(NULL,3*SIZE,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0); //mapeig
    if (addr == MAP_FAILED){
      if (close(fd) == -1) printf("Error al tancar arxiu");
      if (shm_unlink(SHARED_MEM) == -1) printf("Error d'esborrat de memoria compartida");
      exit(EXIT_FAILURE);
    } //verificacio mapeig

    matrix A = addr;
    matrix B = addr+SIZE;
    matrix R = addr+(2*SIZE);

    load_matrix(argv[1],A);
    load_matrix(argv[2],B);

    //creem processos-fills
  
    while(i < 4){
    
      childpid = fork();
    
      switch(childpid){
      case -1:
	perror("Error en la creació del procés\n");
	for(k = 0;k < i;k++){
	  kill(fills[i],SIGTERM);
	}
	if (shm_unlink(SHARED_MEM) == -1) printf("Error d'esborrat de memoria compartida");
	exit(EXIT_FAILURE);
	i = 4;
	break;
      case 0:
	sprintf(nom,"child%i",i);
	sprintf(no,"%i",i);
	execlp("./child",nom,SHARED_MEM,no,NULL); //posem el nom del fitxer compilat
	break;
      default: //es proces pare
	fills[i] = childpid;
	printf("Sóc el pare i he creat un fill\n");
	break;
      }
      i++;
    }

    while(j < 4){
      pid=wait(&status);
      if (WIFEXITED(status)){ //macro de wait, retorna 1 si acaba normal
	if(WEXITSTATUS(status)){ //1 si acaba normal-malament
	  printf("Error\n");
	  if (shm_unlink(SHARED_MEM) == -1) exit(EXIT_FAILURE);
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
  
    print_matrix(R);
    save_matrix(argv[3],R);
  
    if (close(fd) == -1){
      if (shm_unlink(SHARED_MEM) == -1) printf("Error d'esborrat de memoria compartida");
      exit(EXIT_FAILURE); //tanquem fitxer
    }
  }
  else {
    printf("ARGUMUMENTS INCORRECTES\n");
  }
  return 0;
}
