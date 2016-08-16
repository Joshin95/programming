PRAGMA foreign_keys = ON;
.header on
.mode column

CREATE TABLE EMPLEAT(
       ID_EMPLEAT INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       CARRER TEXT NOT NULL,
       CIUTAT TEXT NOT NULL);

CREATE TABLE FEINA(
       ID_EMPLEAT INTEGER NOT NULL,
       ID_EMPRESA TEXT NOT NULL,
       SALARI INTEGER NOT NULL,
       FOREIGN KEY (ID_EMPLEAT) REFERENCES EMPLEAT);

CREATE TABLE EMPRESA(
       ID_EMPRESA TEXT PRIMARY KEY NOT NULL,
       CIUTAT TEXT NOT NULL);

CREATE TABLE MANAGER(
       ID_EMPLEAT INTEGER NOT NULL,
       ID_EMPLEAT_COORDINADOR INTEGER NOT NULL,
       FOREIGN KEY (ID_EMPLEAT) REFERENCES EMPLEAT);



INSERT INTO EMPLEAT (CARRER,CIUTAT) VALUES ('SALVADOR','MANRESA');	
INSERT INTO EMPLEAT (CARRER,CIUTAT) VALUES ('PIO BAROJA','BERGA');
INSERT INTO EMPLEAT (CARRER,CIUTAT) VALUES ('GRAN VIA','BERGA');
INSERT INTO EMPLEAT (CARRER,CIUTAT) VALUES ('DE LA CASTELLANA','BARCELONA');
INSERT INTO EMPLEAT (CARRER,CIUTAT) VALUES ('BASES DE MANRESA','MANRESA');

INSERT INTO EMPRESA (ID_EMPRESA,CIUTAT) VALUES ('BANC NEWTON','MANRESA');
INSERT INTO EMPRESA (ID_EMPRESA,CIUTAT) VALUES ('BANC SABADELL','BERGA');
INSERT INTO EMPRESA (ID_EMPRESA,CIUTAT) VALUES ('LA CAIXA','BARCELONA');

INSERT INTO FEINA (ID_EMPLEAT,ID_EMPRESA,SALARI) VALUES (1,'BANC SABADEL',1000);
INSERT INTO FEINA (ID_EMPLEAT,ID_EMPRESA,SALARI) VALUES (2,'BANC NEWTON',2000);
INSERT INTO FEINA (ID_EMPLEAT,ID_EMPRESA,SALARI) VALUES (3,'BANC NEWTON',15000);
INSERT INTO FEINA (ID_EMPLEAT,ID_EMPRESA,SALARI) VALUES (4,'LA CAIXA',25000);
INSERT INTO FEINA (ID_EMPLEAT,ID_EMPRESA,SALARI) VALUES (5,'BANC NEWTON',15000);

INSERT INTO MANAGER (ID_EMPLEAT,ID_EMPLEAT_COORDINADOR) VALUES (3,1);
INSERT INTO MANAGER (ID_EMPLEAT,ID_EMPLEAT_COORDINADOR) VALUES (5,1);
INSERT INTO MANAGER (ID_EMPLEAT,ID_EMPLEAT_COORDINADOR) VALUES (4,2);


/*

1- 
sqlite> select id_empleat, ciutat from empleat where id_empleat in (select id_empleat from feina where id_empresa="BANC NEWTON");

ID_EMPLEAT  CIUTAT    
----------  ----------
2           BERGA     
3           BERGA     
5           MANRESA   


2-
sqlite> select * from empleat where id_empleat in (select id_empleat from feina where id_empresa="BANC NEWTON" and salari > 10000);

ID_EMPLEAT  CARRER      CIUTAT    
----------  ----------  ----------
3           GRAN VIA    BERGA     
5           BASES DE M  MANRESA   

3-
sqlite> select id_empleat from empleat where id_empleat in (select id_empleat from feina where id_empresa!="BANC NEWTON");

ID_EMPLEAT
----------
1         
4         

4-
sqlite> select * from feina where salari>(select max(salari) from feina where id_empresa="BANC NEWTON");

ID_EMPLEAT  ID_EMPRESA  SALARI    
----------  ----------  ----------
4           LA CAIXA    25000     

5-
sqlite> select id_empresa, max(valor) from (select count(*) as valor,id_empresa from feina group by id_empresa);

id_empresa   max(valor)
-----------  ----------
BANC NEWTON  3         

6-

sqlite> update empleat set ciutat="BARCELONA" where id_empleat=2;
sqlite> select * from empleat;

ID_EMPLEAT  CARRER      CIUTAT    
----------  ----------  ----------
1           SALVADOR    MANRESA   
2           PIO BAROJA  BARCELONA 
3           GRAN VIA    BERGA     
4           DE LA CAST  BARCELONA 
5           BASES DE M  MANRESA 

7-

sqlite> select * from feina;

ID_EMPLEAT  ID_EMPRESA    SALARI    
----------  ------------  ----------
1           BANC SABADEL  1000      
2           BANC NEWTON   2000      
3           BANC NEWTON   15000     
4           LA CAIXA      25000     
5           BANC NEWTON   15000     

sqlite> update feina set salari=salari+(salari*0.1) where id_empleat in (select distinct(ID_EMPLEAT_COORDINADOR) from manager);
sqlite> select * from feina;

ID_EMPLEAT  ID_EMPRESA    SALARI    
----------  ------------  ----------
1           BANC SABADEL  1100      
2           BANC NEWTON   2200      
3           BANC NEWTON   15000     
4           LA CAIXA      25000     
5           BANC NEWTON   15000     



ELS EXERCICIS 8 I 9 NO ES PODEN FER DE MOMENT


10-

sqlite> select * from feina;

ID_EMPLEAT  ID_EMPRESA    SALARI    
----------  ------------  ----------
1           BANC SABADEL  1000      
2           BANC NEWTON   2000      
3           BANC NEWTON   15000     
4           LA CAIXA      25000     
5           BANC NEWTON   15000     

sqlite> delete from feina where id_empresa="BANC NEWTON";
sqlite> select * from feina;

ID_EMPLEAT  ID_EMPRESA    SALARI    
----------  ------------  ----------
1           BANC SABADEL  1000      
4           LA CAIXA      25000     



  
 
*/
