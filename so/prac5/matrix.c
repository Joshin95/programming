#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "matrix.h"



void print_matrix(const matrix a){
  
  int i,j;
  
  for(i=0;i<DIM;i++){
    for(j=0;j<DIM;j++){
      printf("%lf  ", a[i][j]);
    }
    printf("\n");
  }
}

void const_matrix(matrix m, float v){

  int i,j;
  
  for(i=0;i<DIM;i++){
    for(j=0;j<DIM;j++){
      m[i][j]=v;
    }
  }
}

void prod_matrix(const matrix a, const matrix b, matrix r,int minf, int maxf, int minc, int maxc){

  int h,i,j;

  for(i=minf;i<maxf;i++){
    for(h=minc;h<maxc;h++){
      r[i][h]=0;
      for(j=0;j<DIM;j++)
	r[i][h]+=a[i][j]*b[j][h];
    }
  }
}

void save_matrix(const char filename[], const matrix m){

  FILE *f;
  int i,j;
  
  f = fopen(filename, "w");
  
  if (f) {
    for(i=0;i<DIM;i++){
      for(j=0;j<DIM;j++){
	fprintf(f,"%5f,",m[i][j]);
      }
      fprintf(f,"\n");
    }
    fclose(f);
  }

  else {
    printf("No sha pogut obrir el fitxer");
  }
}

void load_matrix(const char filename[], matrix m){

  FILE *f;
  int i,j;
  double c;

  f = fopen(filename,"r");
  
  if(f){
    for (i = 0; i < DIM; i++){
      for (j = 0; j < DIM; j++){
	fscanf(f, "%lf,", &c);
	m[i][j] = c;
      }
    }
    fclose(f);
  }

  else {
    printf("No sha pogut obrir el fitxer");
  }
}

/*
int main(void){

  float a[DIM][DIM];
  float b[DIM][DIM];
  float r[DIM][DIM];
  
  const_matrix(a,5);
  const_matrix(b,5);
  const_matrix(r,0);
  prod_matrix(a,b,r,0,4,4,8);
  print_matrix(r);
  
  return 0;

}
*/
