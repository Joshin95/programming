CREATE TABLE CLIENTS(
       NIF VARCHAR(11) PRIMARY KEY NOT NULL,
       RAO_SOCIAL TEXT NOT NULL,
       ADRECA TEXT NOT NULL,
       TELEFON CHAR(9) NOT NULL,
       DESCOMPTE FLOAT NOT NULL);

CREATE TABLE CENTRES(
       CODI INTEGER PRIMARY KEY NOT NULL,
       CIUTAT TEXT NOT NULL,
       ZONA TEXT NOT NULL);

CREATE TABLE COMANDES(
       NUMERO_COMANDA INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       CODI_PRODUCTE INTEGER NOT NULL,
       CODI_VENEDOR INTEGER NOT NULL,
       NIF VARCHAR(11) NOT NULL,
       DATA_RESULT DATETIME,
       UNITATS INTEGER NOT NULL,
       FOREIGN KEY (CODI_PRODUCTE) REFERENCES PRODUCTES(CODI),	
       FOREIGN KEY (CODI_VENEDOR) REFERENCES VENEDORS(CODI),	
       FOREIGN KEY (NIF) REFERENCES CLIENTS(NIF));
	
CREATE TABLE VENEDORS(
       CODI INTEGER PRIMARY KEY NOT NULL,
       NOM TEXT NOT NULL,
       EDAT INT NOT NULL,
       CODICENTRE VARCHAR(10) NOT NULL,
       FOREIGN KEY (CODICENTRE) REFERENCES CENTRES(CODI));	

CREATE TABLE PRODUCTES(
       CODI INTEGER PRIMARY KEY NOT NULL,
       DESCRIPCIO TEXT NOT NULL,
       PREU INT NOT NULL,
       ESTOC INT NOT NULL);

INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('47107413D','Hermanos Gomez y Ripoldi','Carrer Sant Marti de Tous','666736358','0.2');
INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('77777777E','MACSA','Carrer de Girona','632145876','0.15');
INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('11111111D','Fujitsu','Avinguda Bases de Manresa','677666666','0.05');
INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('22222222D','Between','Carrer Barcelona','652102855','0.1');
INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('33333333E','LaCaixa','Carrer Santa Paula','610254165','0.18');
INSERT INTO CLIENTS (NIF,RAO_SOCIAL,ADRECA,TELEFON,DESCOMPTE) VALUES ('88888888D','TOUS','Carrer Prat de la Riba','611997526','0.25');


INSERT INTO CENTRES (CODI,CIUTAT,ZONA) VALUES (1,'Barcelona','C');
INSERT INTO CENTRES (CODI,CIUTAT,ZONA) VALUES (2,'Manresa','B');
INSERT INTO CENTRES (CODI,CIUTAT,ZONA) VALUES (3,'Igualada','A');
INSERT INTO CENTRES (CODI,CIUTAT,ZONA) VALUES (4,'Berga','A');


INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (1,1,'88888888D','2015-03-05 09:10:18',500);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (2,2,'22222222D','2016-03-01 09:00:00',300);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (3,5,'33333333E','2002-07-21 12:30:18',100);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (4,3,'77777777E','2002-12-05 09:10:18',31);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (5,4,'11111111D','2012-01-15 18:10:42',8);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (2,1,'33333333E','2002-07-27 19:30:42',20);
INSERT INTO COMANDES (CODI_PRODUCTE,CODI_VENEDOR,NIF,DATA_RESULT,UNITATS) VALUES (1,3,'77777777E','2002-12-06 11:50:18',28);


INSERT INTO VENEDORS (CODI,NOM,EDAT,CODICENTRE) VALUES (1,'David',24,'C012');
INSERT INTO VENEDORS (CODI,NOM,EDAT,CODICENTRE) VALUES (2,'Sergi',25,'C402');
INSERT INTO VENEDORS (CODI,NOM,EDAT,CODICENTRE) VALUES (3,'Alejandro',26,'C081');
INSERT INTO VENEDORS (CODI,NOM,EDAT,CODICENTRE) VALUES (4,'Grzegorz',23,'C019');
INSERT INTO VENEDORS (CODI,NOM,EDAT,CODICENTRE) VALUES (5,'Babui',18,'C018');

INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (1,'Clock 500MHz',1,700);
INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (2,'Processador',300,35);
INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (3,'Targeta grafica',200,50);
INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (4,'Monitors',50,250);
INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (5,'Microcontrolador',25,0);
INSERT INTO PRODUCTES (CODI,DESCRIPCIO,PREU,ESTOC) VALUES (6,'Smartphone',280,100);



/*

1) sqlite> select * from productes;
CODI        DESCRIPCIO    PREU        ESTOC     
----------  ------------  ----------  ----------
1           Clock 500MHz  1           700       
2           Processador   300         35        
3           Targeta graf  200         50        
4           Targeta de s  50          200       
5           Microcontrol  25          0         
sqlite> delete from productes where estoc=0;
sqlite> select * from productes;
CODI        DESCRIPCIO    PREU        ESTOC     
----------  ------------  ----------  ----------
1           Clock 500MHz  1           700       
2           Processador   300         35        
3           Targeta graf  200         50        
4           Targeta de s  50          200  

2) sqlite> select * from clients;
NIF         RAO_SOCIAL                ADRECA                     TELEFON     DESCOMPTE 
----------  ------------------------  -------------------------  ----------  ----------
47107413D   Hermanos Gomez y Ripoldi  Carrer Sant Marti de Tous  666736358   20        
77777777E   MACSA                     Carrer de Girona           632145876   15        
11111111D   Fujitsu                   Avinguda Bases de Manresa  677666666   12.5      
22222222D   Between                   Carrer Barcelona           652102855   17.5      
33333333E   LaCaixa                   Carrer Santa Paula         610254165   25.5      
88888888D   TOUS                      Carrer Prat de la Riba     611997526   25        
sqlite> update clients set descompte=descompte+1.5 order by nif limit 3;
sqlite> select * from clients;
NIF         RAO_SOCIAL                ADRECA                     TELEFON     DESCOMPTE 
----------  ------------------------  -------------------------  ----------  ----------
47107413D   Hermanos Gomez y Ripoldi  Carrer Sant Marti de Tous  666736358   20        
77777777E   MACSA                     Carrer de Girona           632145876   15        
11111111D   Fujitsu                   Avinguda Bases de Manresa  677666666   14.0      
22222222D   Between                   Carrer Barcelona           652102855   19.0      
33333333E   LaCaixa                   Carrer Santa Paula         610254165   27.0      
88888888D   TOUS                      Carrer Prat de la Riba     611997526   25    

3) sqlite> select codi as Monitors from productes where descripcio='Monitors' and estoc>0;
Monitors  
----------
4         

4) sqlite> select codicentre from venedors where edat<=26 and edat>=21 order by edat;
CODICENTRE
----------
C019      
C012      
C402      
C081  

5) sqlite> select clients.nif,comandes.codi_producte,(sum(comandes.unitats*productes.preu))*(1-clients.descompte) as Total from clients,comandes,productes where strftime('%Y',comandes.data_result)="2002" and clients.nif=comandes.nif and comandes.codi_producte=productes.codi group by clients.nif;
NIF         CODI_PRODUCTE  Total     
----------  -------------  ----------
33333333E   2              21320.0   
77777777E   1              1341.3

6) sqlite> select * from(select venedors.codi,sum(comandes.unitats) as Unitats from venedors,comandes where venedors.codi=comandes.codi_venedor group by venedors.codi order by codi) limit 3;
codi        Unitats   
----------  ----------
1           520       
2           300       
3           59  


7) sqlite> select codi from productes where codi not in (select codi_producte from comandes);
CODI      
----------
6      


*/
