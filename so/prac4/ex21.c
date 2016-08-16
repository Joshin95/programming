#include <stdio.h>
#include <dirent.h>


int main(int argc, char *argv[]){ //agafem parametres

    DIR *directori;
    struct dirent *arxiu;
    char * nom_arxiu;

    if (argc == 1)
      directori = opendir("."); //obrim directori de treball
    else  
      directori = opendir(argv[1]); //obrim ruta donada per argument

    while ((arxiu=readdir(directori)) != NULL) { //quan arriba al final del directori, retorna NULL!!
      if ( !strcmp(arxiu->d_name, ".") || !strcmp(arxiu->d_name, "..") ); //aixi eliminem 
      else{
	nom_arxiu = arxiu->d_name; 
	printf("%s\n",nom_arxiu);
      }
    }
    closedir(directori); //tanquem el directori
    
    return 0;
}
