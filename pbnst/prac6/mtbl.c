#include <stdio.h>
#include "mtbl.h"
#include "mchar.h"

morse_table_t itu_table; 

void empty_morse_table(morse_table_t t){
    
  int e;
  
  for(e=0;e<64;e++)
    t[e]='@';
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

void mtbl_init(void){
  
  empty_morse_table(itu_table);

  set_translation(itu_table,'A',".-");
  set_translation(itu_table,'B',"-...");
  set_translation(itu_table,'C',"-.-.");
  set_translation(itu_table,'D',"-..");
  set_translation(itu_table,'E',".");
  set_translation(itu_table,'F',"..-.");
  set_translation(itu_table,'G',"--.");
  set_translation(itu_table,'H',"....");
  set_translation(itu_table,'I',"..");
  set_translation(itu_table,'J',".---");
  set_translation(itu_table,'K',"-.-");
  set_translation(itu_table,'L',".-..");
  set_translation(itu_table,'M',"--");
  set_translation(itu_table,'N',"-.");
  set_translation(itu_table,'O',"---");
  set_translation(itu_table,'P',".--.");
  set_translation(itu_table,'Q',"--.-");
  set_translation(itu_table,'R',".-.");
  set_translation(itu_table,'S',"...");
  set_translation(itu_table,'T',"-");
  set_translation(itu_table,'U',"..-");
  set_translation(itu_table,'V',"...-");
  set_translation(itu_table,'W',".--");
  set_translation(itu_table,'X',"-..-");
  set_translation(itu_table,'Y',"-.--");
  set_translation(itu_table,'Z',"--..");
  set_translation(itu_table,'0',"-----");
  set_translation(itu_table,'1',".----");
  set_translation(itu_table,'2',"..---");
  set_translation(itu_table,'3',"...--");
  set_translation(itu_table,'4',"....-");
  set_translation(itu_table,'5',".....");
  set_translation(itu_table,'6',"-....");
  set_translation(itu_table,'7',"--...");
  set_translation(itu_table,'8',"---..");
  set_translation(itu_table,'9',"----.");
  set_translation(itu_table,' ',".-.-.");

}

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
    } //tancament while
    x[k]='\0'; //whitespace
  } //tancamnet else
  n=0;
  for(i=k-1;i>-1;i--){
    m[n]=x[i];
    n++;
  }
  m[n]='\0'; //no es pot assignar taules amb taules m=x, no correcte!!
}

char to_ascii(const morse_table_t t, morse_char_t m){

  int sentinella,sum;
  sum=1;

  for(sentinella=0;sentinella<6;sentinella++){
    if(m[sentinella]!='\0'){
      if(m[sentinella]=='.')
	sum=sum*2;
      else if(m[sentinella]=='-')
	sum=sum*2+1;
      else {
	//printf("Element Morse Incorrecte");
	break;
	  } // fi else intern
    } // fi if
    else {
      break;
	} // fi else extern
  } // fi for
  return t[sum]; //afegim el caracter a la posicio determinada per sum
} // fi funcio


char mtbl_m2a(mchar_t c){

  mchar_t converted, numbers;
  morse_char_t m;
  char x;
  int w, mask, s, valor;
  
  for(s=0;s<6;s++){
    m[s]=0; //m inicialitzada a 0
  }

  converted=c&248; //5 bits de mes pes
  numbers=c&7; //3 bits de menys pes
  mask=128; //mascara inicial

  for(w=0;w<numbers;w++){ 
    valor=(converted&mask) >> (7-w); //valor de cada bit, 1 o 0.
    if(valor==0)
      m[w]='.';
    else
      m[w]='-';
    mask=mask/2; //dividim mascara, per seguent bit.
  }
  m[w+1]='\0';

  x=to_ascii(itu_table, m);
  return x;

}

mchar_t mtbl_a2m(char c){

  mchar_t a;
  morse_char_t b;
  uint8_t i,counter,mask;

  mask=128;
  counter=0;
  a=0;
  
  to_morse(itu_table,c,b); //modifica la b!

  for(i=0;i<6;i++){ 
    if(b[i]!='\0'){ 
      if(b[i]=='.'){ 
	mask=mask/2;
	counter++;
      }
      else {
	a=a|mask;
	counter++;
	mask=mask/2;
      }
    }
    else 
      break;
  }
  a=a|counter;
  return a;
}
