#include <stdio.h>

int main(int argc,char *argv[]){
  
  typedef int taula[8];
  
  taula t;
  int i,v;

  scanf("%x",&v);
  
  if (strcmp(argv[1],"-d")==0){
    printf("%d",v);
  }
  if (strcmp(argv[1],"-o")==0){
    printf("%o",v);
  }
  
  if (strcmp(argv[1],"-b")==0){
    i=0;
    while (i<8){ // inicialitzem la taula tota a zeros
      t[i]=0;
      i++;
    }
    i=0;
    while (v>0){ //omplim la taula amb els residus
      t[i]=v%2;
      v=v/2;
      i++;
    }
    for(i=7;i>=0;i--){ //printem el contingut de la taula de forma inversa
      printf("%d",t[i]);
    }
  }
  printf("\n");
  return 0;
}  
