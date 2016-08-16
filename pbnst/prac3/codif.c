#include <stdio.h>
#include "codif.h"

void empty_morse_table(morse_table_t t){
    
  int element;
  
  for(element=0;element<64;element++)
    t[element]='@';
  }

void set_translation(morse_table_t t, char c, morse_char_t m){
  
  int sentinel,sum;
  sum=1;

  for(sentinel=0;sentinel<6;sentinel++){

    if(m[sentinel]!='\0'){
      if(m[sentinel]=='.')
	sum=sum*2;
      else if(m[sentinel]=='-')
	sum=sum*2+1;
      else {
	printf("Element Morse Incorrecte");
	break;
	  } // fi else intern
    } // fi if
    else {
      break;
	} // fi else extern
  } // fi for
  t[sum]=c; //afegim el caracter a la posicio determinada per sum
} // fi funcio

void to_morse(const morse_table_t t, char c, morse_char_t m){

  int element,valor,mod,k,w,i,n,s;
  morse_char_t x;
  k=0;

  for(w=0;w<6;w++){
    m[w]=0;//posem tots valors de m a 0.
    x[w]=0;
  }
  for(element=0;element<64;element++){
    if (t[element]==c){
      valor=element;
      break;
	}
    else if(t[element]!=c && element==63)
      valor=0;
  }
  if(valor==0)
    x[0]=' '; 
  else{
    while(valor!=1){ //mai arriba a 0, el numero mes petit es 1
      mod=valor%2;
      valor=valor/2;
      if(mod==1)
	x[k]='-';
      else
	x[k]='.';
      k++;
    } //cierre while
    x[k]='\0'; //whitespace
  } //cierre else
  n=0;
  for(i=k-1;i>-1;i--){
    m[n]=x[i];
    n++;
  }
  m[n]='\0'; //no es pot assignar taules amb taules m=x, no correcte!!
}

char to_ascii(const morse_table_t t, morse_char_t m){

  int sentinel,sum;
  sum=1;

  for(sentinel=0;sentinel<6;sentinel++){

    if(m[sentinel]!='\0'){
      if(m[sentinel]=='.')
	sum=sum*2;
      else if(m[sentinel]=='-')
	sum=sum*2+1;
      else {
	break;
	  } // fi else intern
    } // fi if
    else {
      break;
	} // fi else extern
  } // fi for
  return t[sum]; //afegim el caracter a la posicio determinada per sum
} // fi funcio
