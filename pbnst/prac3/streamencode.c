#include <stdio.h>
#include "codif.h"
#include "itu.h"

morse_char_t morse;

void streamencoder_init(void){ //inicialitza el modul itu

  itu_init();

}

void do_codifica(FILE *in, FILE *out){

  char val;

  fseek(in,0,SEEK_SET); //posem el pointer a l'inici del fitxer in
  val=getc(in);
  while(val!=EOF){
    if (val == '\n'){
      fputs("\n",out);
      val=getc(in);
    }
    else{

      to_morse(itu_table,val,morse);
      fputs(morse,out);
      fputs(" ",out);
      val=getc(in);
    }
  }
}

void do_descodifica(FILE *in, FILE *out){

  char val,ch;
  int i,s;

  for(s=0;s<6;s++){ //reiniciem el valor de morse, per tal de tenir tota la llista desocupada i no guardar valors!!! sino guarda la anterior lletra!!
    morse[s]=0;
  }
  
  i=0;
  fseek(in,0,SEEK_SET); //posem el pointer a l'inici del fitxer in
  val=getc(in);
  while(val!=EOF){
    if(val==' '){
      ch=to_ascii(itu_table,morse);
      fputc(ch,out);
      i=0;
      for(s=0;s<6;s++){ //reiniciem el valor de morse, per tal de tenir tota la llista desocupada i no guardar valors!!! sino guarda la anterior lletra!!
	morse[s]=0;
      }
      val=getc(in);
      if(val==' '){  //llegeix el segon espai i posa un espai al fitxer, per a separar paraules!!
      fputc(' ',out);
      }
    }
    else {
       if (val == '\n'){
	 if (morse[0]==0){
	   fputs("\n",out);
	   val=getc(in);
	 }
	 else{
	   ch=to_ascii(itu_table,morse);
	   fputc(ch,out);
	   fputs("\n",out);
	   i=0;
	   for(s=0;s<6;s++){ //reiniciem el valor de morse, per tal de tenir tota la llista desocupada i no guardar valors!!! sino guarda la anterior lletra!!
	     morse[s]=0;
	   }
	   val=getc(in);
	   if(val==' '){
	     fputc(' ',out);
	   }
	 } 
       }
       else{
	 morse[i]=val;
	 i++;
	 val=getc(in);
       }
    }
  }
  if (morse[0]!=0){
    ch=to_ascii(itu_table,morse);  //per agafar l'ultim valor final, que no te separacio i te EOF com a final i no espai.
    fputc(ch,out);
  }
}
