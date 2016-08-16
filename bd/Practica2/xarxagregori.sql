CREATE TABLE USUARIS(
       EMAIL VARCHAR(50) PRIMARY KEY NOT NULL,
       NOM TEXT NOT NULL,
       COGNOM TEXT NOT NULL,
       POBLACIO TEXT NOT NULL,
       DATANAIXEMENT CHAR(10),
       PWD VARCHAR(20) NOT NULL);

CREATE TABLE AMISTATS(
       EMAIL1 VARCHAR(50) NOT NULL,
       EMAIL2 VARCHAR(50) NOT NULL,
       ESTAT VARCHAR(10) DEFAULT 'Pendent',
       FOREIGN KEY (EMAIL1) REFERENCES USUARIS,
       FOREIGN KEY (EMAIL2) REFERENCES USUARIS);


INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('gregori@hotmail.com','Gregor','Babui','Berga','19-07-1995','1234hola');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('jordiA@themail.cat','Jordi','Alba','Manresa','25-12-1978','jordiQ2578');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('pepito@themail.cat','Pepito','Palotes','Barcelona','4-10-1984','pepito22');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('lauraalbets@themail.cat','Laura','Albets','Manresa','9-11-1990','abracadabra');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('jordi@mail.com','Jordi','Albets','Valencia','24-3-1970','24031970');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('lluisT@mail.com','Lluis','Jimenez','Madrid','8-7-1972','08071972');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('pereG@mail.com','Pere','Garcia','Manresa','8-7-1995','1111xxxx');
INSERT INTO USUARIS (EMAIL,NOM,COGNOM,POBLACIO,DATANAIXEMENT,PWD) VALUES ('anaV@themail.cat','Ana','Vilella','Manresa','9-11-1990','anavilella');


INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('gregori@hotmail.com','lauraalbets@themail.cat','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('jordiA@themail.cat','pepito@themail.cat','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('pepito@themail.cat','jordi@mail.com','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2) VALUES ('lauraalbets@themail.cat','pepito@themail.cat');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('jordi@mail.com','jordiQ@themail.cat','Rebutjada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('pereG@mail.com','lauraalbets@themail.cat','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('gregori@hotmail.com','pereG@mail.com','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('gregori@hotmail.com','anaV@themail.cat','Aprovada');
INSERT INTO AMISTATS (EMAIL1,EMAIL2,ESTAT) VALUES ('jordiQ@themail.cat','lauraalbets@themail.cat','Aprovada');



/*
1.
sqlite3> select email,nom,cognom,poblacio,datanaixement from usuaris where poblacio='Manresa';
EMAIL               NOM         COGNOM      POBLACIO    DATANAIXEMENT
------------------  ----------  ----------  ----------  -------------
jordiA@themail.cat  Jordi       Alba        Manresa     25-12-1978   
lauraalbets@themai  Laura       Albets      Manresa     9-11-1990    
pereG@mail.com      Pere        Garcia      Manresa     8-7-1995     
anaV@themail.cat    Ana         Vilella     Manresa     9-11-1990    

2.
sqlite> select email from usuaris where cognom='Albets';
EMAIL                  
-----------------------
lauraalbets@themail.cat
jordi@mail.com         

3.
sqlite>  select nom,cognom from usuaris where email in (select email1 from amistats where estat='Aprovada' and email2 in (select email from usuaris where nom="Pere" and cognom="Garcia")) union select nom,cognom from usuaris where email in(select email2 from amistats where estat='Aprovada' and email1 in (select email from usuaris where nom="Pere" and cognom="Garcia"));
nom         cognom    
----------  ----------
Gregor      Babui     
Laura       Albets  

4.
sqlite> select nom,cognom from usuaris where email in (select email1 from amistats where estat='Aprovada' and email2 in (select email from usuaris where nom="Pere" and cognom="Garcia")) union select nom,cognom from usuaris where email in(select email2 from amistats where estat='Aprovada' and email1 in (select email from usuaris where nom="Pere" and cognom="Garcia")) except select nom,cognom from usuaris where email in (select email1 from amistats where estat='Aprovada' and email2 in (select email from usuaris where nom="Jordi" and cognom="Alba")) except select nom,cognom from usuaris where email in (select email2 from amistats where estat='Aprovada' and email1 in (select email from usuaris where nom="Jordi" and cognom="Alba"));
nom         cognom    
----------  ----------
Gregor      Babui     
Laura       Albets   

5.
sqlite3> select count(*) as Peticions_rebutjades  from amistats where estat='Rebutjada';
Peticions_rebutjades
--------------------
1           

6.

sqlite> select nom,cognom from usuaris where email in (select email from usuaris where email in (select email1 from (select email1,email2 from amistats where email1 in (select email from usuaris where poblacio='Manresa') and email2 in (select email from usuaris where poblacio='Manresa') and estat='Aprovada') union select email2 from (select email1,email2 from amistats where email1 in (select email from usuaris where poblacio='Manresa') and email2 in (select email from usuaris where poblacio='Manresa') and estat='Aprovada')));
NOM         COGNOM    
----------  ----------
Laura       Albets    
Pere        Garcia

7.
sqlite>  select email1,count(*) from amistats where estat='Rebutjada' group by email1 having count(*) union select email2,count(*) from amistats where estat='Rebutjada' group by email2 having count(*);
email1          count(*)  
--------------  ----------
jordi@mail.com  1         
jordiQ@themail  1   

8.
sqlite>  select nom,cognom from usuaris where nom!='Ana' and cognom!='Vilella' except select nom,cognom from usuaris where email in (select email1 from amistats where estat='Aprovada' and email2 in (select email from usuaris where nom="Ana" and cognom="Vilella")) union select nom,cognom from usuaris where email in(select email2 from amistats where estat='Aprovada' and email1 in (select email from usuaris where nom="Ana" and cognom="Vilella"));
nom         cognom    
----------  ----------
Jordi       Alba      
Jordi       Albets    
Laura       Albets    
Lluis       Jimenez   
Pepito      Palotes   
Pere        Garcia 


*/
