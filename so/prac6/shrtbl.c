#define _POSIX_C_SOURCE 200809L

#include "shrtbl.h"
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/mman.h> //memoria compartida
#include <sys/stat.h> //constants de zona de memoria
#include <fcntl.h> //constant O_xxxx
#include <string.h>

#include <semaphore.h>

#define ERR -1
#define OK 0
#define SHARED_MEM "mem"
#define NOM_SEM "sem"
#define MIDA_MAX sizeof(taula_part) + sizeof(sem_t)


/*
typedef struct {
  taula_part t;
  sem_t mutex;
} memcomp;
*/

//COMPILAR com gcc arxiu.c -o arxiu -lrt (llibreria al final)

//ARA SHA DE COMPILAR gcc shrtbl.c -o exe -lrt -lpthread

static int fd;
static void *addr;
//taula_part taula;
//taula_part *tp=&taula;
static taula_part *tp;
static sem_t *mutex;
static sem_t *mutex2;

int create_shared_table(void){
  
  //creem zona de memoria compartida
  fd = shm_open(SHARED_MEM,O_RDWR|O_CREAT,S_IRUSR|S_IWUSR); //creem zona de mc
  if (fd == -1){
    if (shm_unlink(SHARED_MEM) == -1) 
      printf("Error d'esborrat de memoria compartida");
    return ERR; //verifiquem la creacio
  }
  if (ftruncate(fd,MIDA_MAX) == -1){ 
    if (close(fd) == -1) 
      printf("Error al tancar arxiu");
    if (shm_unlink(SHARED_MEM) == -1) 
      printf("Error d'esborrat de memoria compartida");
    return ERR; 
  }
  if (close(fd) == -1){ 
    printf("Error al tancar arxiu");
    return ERR;
  }
  return OK;  
}

int remove_shared_table(void){

  if (close(fd) == -1){ 
    printf("Error al tancar arxiu");
    return ERR;
  }
  if (shm_unlink(SHARED_MEM) == -1){
    printf("Error d'esborrat de memoria compartida");
    return ERR;
  }
  return OK;
}

int bind_shared_table(void){

  fd = shm_open(SHARED_MEM,O_RDWR,S_IRUSR|S_IWUSR); //creem zona de mc
  if (fd == -1){
    if (shm_unlink(SHARED_MEM) == -1) 
      printf("Error d'esborrat de memoria compartida");
    return ERR; //verifiquem la creacio
  }
  addr = mmap(NULL,MIDA_MAX,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0); //mapeig
  if (addr == MAP_FAILED){
    if (close(fd) == -1) 
      printf("Error al tancar arxiu");
    if (shm_unlink(SHARED_MEM) == -1)
      printf("Error d'esborrat de memoria compartida");
    return ERR;
  }

  tp = addr;
  mutex = addr + sizeof(taula_part);
  
  mutex2 = sem_open(NOM_SEM,O_RDWR|O_CREAT,S_IRUSR|S_IWUSR,1);

  if (mutex2 == SEM_FAILED){

    printf("FALLA LA MERDA");
    
  }
  else{

    *mutex = *mutex;
    
  }
  
  return OK;
}


void init_table(void){  
  
  create_shared_table();
  bind_shared_table();
  (*tp).nr = 0;
  sem_init(mutex, 1, 1); // el segon 0 ha de ser 0??

}

int add_party(const char id[]){

  char *nom;
  int error = OK;

  printf("A\n");
  
  sem_wait(mutex);
  printf("B\n");
  for(int i = 0 ; i < (*tp).nr ; i++){
    nom = ((*tp).taula[i]).nom_part;
    if (!strcmp(id, nom)) {
      printf("PARTIT JA EXISTEIX\n");
      error = ERR;}
  }

  partit algu;

  strcpy(algu.nom_part, id);
  algu.vots = 0;

  (*tp).taula[(*tp).nr] = algu;
  (*tp).nr++;
  sem_post(mutex);

  return error;

  
}

void del_party(const char id[]){

  char *nom;

  sem_wait(mutex);
  for(int i = 0 ; i < (*tp).nr ; i++){
    nom = ((*tp).taula[i]).nom_part;
    if (!strcmp(id, nom)) {
      for(i; i < ((*tp).nr - 1) ; i++){
	((*tp).taula[i]) = ((*tp).taula[i+1]);
      }
      (*tp).nr--;
      break;}
  }

  sem_post(mutex);
}
void inc_votes(const char id[], int votes){

  char *nom;
  int i = 0;

  sem_wait(mutex);
  for(i ; i < (*tp).nr ; i++){
    nom = ((*tp).taula[i]).nom_part;
    if (!strcmp(id, nom)) {

      ((*tp).taula[i]).vots += votes;
      
      }
  }
  if (i == ((*tp).nr-1))
    printf("PARTIT NO EXISTEIX");
  sem_post(mutex);
}

int get_votes(const char id[]){

  char *nom;
  int vot = ERR;
  
  sem_wait(mutex);
  for(int i = 0 ; i < (*tp).nr ; i++){
    nom = ((*tp).taula[i]).nom_part;
    if (!strcmp(id, nom)) {
      
      vot = ((*tp).taula[i]).vots;
      break;
      
    }
  }

  sem_post(mutex);
  
  return vot;

}
int get_nparties(void) {

  int i;

  sem_wait(mutex);
  i = ((*tp).nr);
  sem_post(mutex);

  return i;
}

void traverse(travapp *const f, void *const data){

  sem_wait(mutex);
  
  for(int i = 0 ; i < (*tp).nr ; i++){
    f(((*tp).taula[i]).nom_part, ((*tp).taula[i]).vots, data); 
  }

  sem_post(mutex);
}


/*

int main(void){

  init_table();

  
  
  tp->nr = 0;
  printf("%i\n", tp->nr);
  printf("BABUINO\n");
  
  partit algu2,algu3;

  strcpy(algu2.nom_part, "PEP");
  algu2.vots = 3;
  
  (*tp).taula[(*tp).nr] = algu2;
  (*tp).nr++;


  strcpy(algu3.nom_part, "JOAN");
  algu3.vots = 2;
  
  (*tp).taula[(*tp).nr] = algu3;
  (*tp).nr++;

  printf("%i\n",get_nparties());


  printf("PRINT");
  
  add_party("GREGOR");

  printf("%i\n",get_nparties());
  
  add_party("PERE");

  printf("%i\n",get_nparties());

  inc_votes("GREGOR",5);
  inc_votes("GREGOR",5);
  
  printf("%s\n",&(((*tp).taula[0]).nom_part[0]));
  printf("%i\n",get_votes("PEP"));
  printf("%i\n",get_votes("PAP"));
  
  printf("%s\n",&(((*tp).taula[1]).nom_part[0]));
  printf("%i\n",get_votes("JOAN"));

  
  printf("%s\n",&(((*tp).taula[2]).nom_part[0]));
  printf("%i\n",get_votes("GREGOR"));
  
  printf("%s\n",&(((*tp).taula[3]).nom_part[0]));
  printf("%i\n",get_votes("PERE"));

  traverse(printentry, NULL);


  remove_shared_table();
				  
}
  
*/
