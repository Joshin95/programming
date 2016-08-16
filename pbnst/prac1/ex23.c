#include <stdio.h>

int main(){
  
  char c;
  int f,i,ct;
  
  ct=0;

  for(i=0;(c=getchar())!='.';++i)
    if(c=='a')
      ++ct;
 
  printf("%d\n",ct);
  return 0;
}
