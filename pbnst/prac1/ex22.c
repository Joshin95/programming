#include <stdio.h>
 
int main() {

  int n,i,r;
  char c;

  r=scanf("%d %c",&n,&c);
  if (r!=2){
    printf("Error\n");
    return 1;
  }


  i=0;
  while (i!=n){
    putchar(c);
    i++;
  }

  printf("\n");
  return 0;
}
