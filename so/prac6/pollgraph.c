
//dona warnings de xrange i yrange quan nomes tenim ficat 1 partit i tampoc mostra els seus vots i falta comprovar el must_end


#include "shrtbl.h"

#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <stdbool.h>

static volatile bool must_end = false;

void handler(int sign){

  must_end = true;

}

static FILE *pipe_gp;

static void printentry(const char *const id, int votes, void *const data);

void printentry(const char *const id, int votes, void *const data){

  printf("%16s %4d\n",id,votes);

}

void printpipe(const char *const id, int votes, void *const data){

  fprintf(pipe_gp,"%s %d\n",id,votes);
  fflush(pipe_gp);
}

int main(void){

  printf("AQUI");
  
  
  init_table();

  signal(SIGINT, handler);
  signal(SIGHUP, handler);

  //bind_shared_table();

  printf("1\n");

  pipe_gp = popen("gnuplot -persist", "w");
  fprintf(pipe_gp,"set title 'Votacio electoral' \n");
  fprintf(pipe_gp,"set boxwidth 0.95 relative \n");
  fprintf(pipe_gp,"set grid \n");
  fprintf(pipe_gp,"set style histogram clustered \n");
  fprintf(pipe_gp,"set ylabel 'Vots (Percentatge)' \n");
  fprintf(pipe_gp,"set xlabel 'Agrupacions' \n");
  //fprintf(pipe_gp,"set ytics 1 \n");
  fprintf(pipe_gp,"set yrange[0:*] \n");
  fprintf(pipe_gp,"set xrange[*:*] \n");
  fprintf(pipe_gp,"set style fill transparent solid 0.5 noborder \n");
  while(get_nparties()<=0)
    sleep(4);
  
  fprintf(pipe_gp,"plot '-' using 2:xtic(1) with boxes linecolor rgb 'green' notitle \n");
  fflush(pipe_gp);
  traverse(printpipe, NULL);
  fprintf(pipe_gp,"e\n");
  fflush(pipe_gp);
  printf("3\n");
  //fprintf(pipe_gp,"pause -1 \n");
  while(!must_end){
    sleep(4);
    traverse(printentry, NULL);
    fprintf(pipe_gp,"replot \n");
    fflush(pipe_gp);
    traverse(printpipe, NULL);
    fprintf(pipe_gp,"e\n");
    fflush(pipe_gp);
  }
  pclose(pipe_gp);

  if (remove_shared_table() == -1){
    return -1;
  }
  return 0;
}


//[:][0:] 
