#include <stdio.h>
#include <math.h>
int main(){
  
  float a,b,c,r1,r2;

  scanf("%f %f %f", &a,&b,&c);
  
  r1=(-b+sqrt((pow(b,2))-(4*a*c)))/(2*a);
  r2=(-b-sqrt((pow(b,2))-(4*a*c)))/(2*a);
  printf("La solucio per -b-... es: %f\n", r1);
  printf("La solucio per -b+... es: %f\n", r2);
}
