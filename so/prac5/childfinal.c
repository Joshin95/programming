#define _POSIX_C_SOURCE 200809L

#include "matrix.h"

#include <string.h>
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h> //memoria compartida
#include <sys/stat.h> //constants de zona de memoria
#include <fcntl.h> //constant O_xxxx

int main(int argc, char *argv[]){

  int i,fd;
  struct stat sb;
  void *addr;

  if (argc == 3){

    fd = shm_open(argv[1],O_RDWR,S_IRUSR|S_IWUSR); //argv[1] te el nom de la SHARED_MEM
    if (fd == 1) exit(EXIT_FAILURE);
    if (fstat(fd,&sb) == -1){
      if (close(fd) == -1) printf("Error al tancar arxiu");
      exit(EXIT_FAILURE);
    }
    addr = mmap(NULL,sb.st_size, PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
    if (addr == MAP_FAILED){
      if (close(fd) == -1) printf("Error al tancar arxiu");
      exit(EXIT_FAILURE);
    }
    
    matrix A = addr;
    matrix B = addr+SIZE;
    matrix R = addr+(2*SIZE);

    if (strcmp("0",argv[2]) == 0){
      prod_matrix(A,B,R,0,4,0,4);
    }
    else if (strcmp("1",argv[2]) == 0){
      prod_matrix(A,B,R,0,4,4,8);
      
    }
    else if (strcmp("2",argv[2]) == 0){
      prod_matrix(A,B,R,4,8,0,4);
      
    }
    else if (strcmp("3",argv[2]) == 0){
      prod_matrix(A,B,R,4,8,4,8);

    }

    if (close(fd) == -1){
      printf("Error al tancar arxiu");
      exit(EXIT_FAILURE);
      } else 
      exit(EXIT_SUCCESS);
  }
  exit(EXIT_SUCCESS);
}
