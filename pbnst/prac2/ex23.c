#include <stdio.h>

int main(){
  int a;
  scanf("%x",&a);
  putchar(a);
  fputc(a,fopen("text.txt", "w+")); // per accedir al mode hexl al emacs -- alt+x i despres escriure hexl-mode
}
