#include <stdio.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>


int main(int argc, char *argv[]){ //agafem parametres

    DIR *directori;
    struct dirent *arxiu;
    char * nom_arxiu, * path, * stat_path;
    struct stat file;

    if (argc == 1){
      directori = opendir("."); //obrim directori de treball
      path=".";
    }
    else  {
      printf("%s",argv[1]);
      directori = opendir(argv[1]); //obrim ruta donada per argument
      path=argv[1];
    }
 
    while ((arxiu=readdir(directori)) != NULL) { //quan arriba al final del directori, retorna NULL!!
      if ( !strcmp(arxiu->d_name, ".") || !strcmp(arxiu->d_name, "..") ); //aixi eliminem els . i .. que retorna per defecte
      else{
	strcpy(stat_path,path); //copiem path, anomenem stat_path
	strcat(stat_path,"/"); 
	strcat(stat_path,arxiu->d_name);
	nom_arxiu=arxiu->d_name;
	stat(stat_path,&file);
	printf("%jd\t",((file.st_blocks*512)-file.st_size));
	printf("%s\n",nom_arxiu);
      }
    }
    closedir(directori); //tanquem el directori
  
    return 0;
}
