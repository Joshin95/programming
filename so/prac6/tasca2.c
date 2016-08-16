#include <unistd.h> //implementa fork()
#include <stdlib.h> //implementa exit()
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdbool.h>


int main()
{
  FILE *pipe_gp = popen("gnuplot -persist", "w");

  fprintf(pipe_gp,"set title 'Votacio electoral' \n");
  fprintf(pipe_gp,"set boxwidth 0.95 relative \n");
  fprintf(pipe_gp,"set grid \n");
  fprintf(pipe_gp,"set style histogram clustered \n");
  fprintf(pipe_gp,"set ylabel 'Vots (Percentatge)' \n");
  fprintf(pipe_gp,"set xlabel 'Agrupacions' \n");
  fprintf(pipe_gp,"set ytics 1 \n");
  fprintf(pipe_gp,"set yrange[0:*] \n");
  fprintf(pipe_gp,"set style fill transparent solid 0.5 noborder \n");
  fprintf(pipe_gp,"plot 'dades.dat' using 2:xtic(1) with boxes linecolor rgb 'green' notitle \n");
  fflush(pipe_gp);
  //fprintf(pipe_gp,"pause -1 \n");
  while(true){
    sleep(4);
    printf("Hola");
    fprintf(pipe_gp,"replot \n");
    fflush(pipe_gp);
  }
  pclose(pipe_gp);
  return 0;
}
