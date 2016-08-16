CREATE TABLE PARKING(
    MATRICULA VARCHAR(10) PRIMARY KEY NOT NULL,
    POSICIO INT NOT NULL,
    MARCA VARCHAR(15) NOT NULL,
    COLOR VARCHAR(10) DEFAULT NULL,
    ENTRADA DATE DEFAULT CURRENT_DATE,
    UNIQUE (POSICIO));

INSERT INTO PARKING VALUES ("7894UKJ",7,"LEXUS","GROC","2016-02-01");
INSERT INTO PARKING VALUES ("P3699CD",1,"DODGE","TARONJA","2016-01-19");
INSERT INTO PARKING VALUES ("Q1478D",9,"TATA","VERD","2016-02-09");
INSERT INTO PARKING (MATRICULA,POSICIO,MARCA,COLOR) VALUES ("8894TYV",10,"TOYOTA","VERMELL");
INSERT INTO PARKING (MATRICULA,POSICIO,MARCA,COLOR) VALUES ("8476ESA",8,"NISSAN","BLAU");
INSERT INTO PARKING (MATRICULA,POSICIO,MARCA,COLOR) VALUES ("3345SAW",15,"HONDA","BLANC");
INSERT INTO PARKING (MATRICULA,POSICIO,MARCA,COLOR) VALUES ("5874OPL",30,"INFINITY","LILA");

/*

sqlite> select * from parking;

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
7894UKJ     7           LEXUS       GROC        2016-02-01
P3699CD     1           DODGE       TARONJA     2016-01-19
Q1478D      9           TATA        VERD        2016-02-09
8894TYV     10          TOYOTA      VERMELL     2016-03-16
8476ESA     8           NISSAN      BLAU        2016-03-16
3345SAW     15          HONDA       BLANC       2016-03-16
5874OPL     30          INFINITY    LILA        2016-03-16


sqlite> select * from parking where entrada>="2016-03-16";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
8894TYV     10          TOYOTA      VERMELL     2016-03-16
8476ESA     8           NISSAN      BLAU        2016-03-16
3345SAW     15          HONDA       BLANC       2016-03-16
5874OPL     30          INFINITY    LILA        2016-03-16


sqlite> select * from parking where entrada<"2016-03-16";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
7894UKJ     7           LEXUS       GROC        2016-02-01
P3699CD     1           DODGE       TARONJA     2016-01-19
Q1478D      9           TATA        VERD        2016-02-09


sqlite> select * from parking where marca="NISSAN";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
8476ESA     8           NISSAN      BLAU        2016-03-16


sqlite> select matricula,marca,color from parking order by marca;

MATRICULA   MARCA       COLOR     
----------  ----------  ----------
P3699CD     DODGE       TARONJA   
3345SAW     HONDA       BLANC     
5874OPL     INFINITY    LILA      
7894UKJ     LEXUS       GROC      
8476ESA     NISSAN      BLAU      
Q1478D      TATA        VERD      
8894TYV     TOYOTA      VERMELL   
 

sqlite> select marca,matricula,posicio from parking where color="LILA" order by posicio;

MARCA       MATRICULA   POSICIO   
----------  ----------  ----------
INFINITY    5874OPL     30        
 

sqlite> select marca, matricula from parking where marca like '%I%';

MARCA       MATRICULA 
----------  ----------
NISSAN      8476ESA   
INFINITY    5874OPL   


sqlite> select marca, matricula from parking where marca like 'T___';

MARCA       MATRICULA 
----------  ----------
TATA        Q1478D    


sqlite> select marca, matricula from parking where posicio=8;

MARCA       MATRICULA 
----------  ----------
NISSAN      8476ESA 


sqlite> select * from parking limit 3;

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
7894UKJ     7           LEXUS       GROC        2016-02-01
P3699CD     1           DODGE       TARONJA     2016-01-19
Q1478D      9           TATA        VERD        2016-02-09


sqlite> select * from parking where entrada="2016-03-16" and color="VERMELL";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
8894TYV     10          TOYOTA      VERMELL     2016-03-16


sqlite> select * from parking where entrada="2016-03-16" or color="VERD";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
Q1478D      9           TATA        VERD        2016-02-09
8894TYV     10          TOYOTA      VERMELL     2016-03-16
8476ESA     8           NISSAN      BLAU        2016-03-16
3345SAW     15          HONDA       BLANC       2016-03-16
5874OPL     30          INFINITY    LILA        2016-03-16


sqlite> select * from parking where matricula like "%SAW";

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
3345SAW     15          HONDA       BLANC       2016-03-16


sqlite> update parking set color="MARRO" where matricula="Q1478D";
sqlite> select * from parking;

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
7894UKJ     7           LEXUS       GROC        2016-02-01
P3699CD     1           DODGE       TARONJA     2016-01-19
Q1478D      9           TATA        MARRO       2016-02-09
8894TYV     10          TOYOTA      VERMELL     2016-03-16
8476ESA     8           NISSAN      BLAU        2016-03-16
3345SAW     15          HONDA       BLANC       2016-03-16
5874OPL     30          INFINITY    LILA        2016-03-16


sqlite> delete from parking where matricula="Q1478D";
sqlite> select * from parking;

MATRICULA   POSICIO     MARCA       COLOR       ENTRADA   
----------  ----------  ----------  ----------  ----------
7894UKJ     7           LEXUS       GROC        2016-02-01
P3699CD     1           DODGE       TARONJA     2016-01-19
8894TYV     10          TOYOTA      VERMELL     2016-03-16
8476ESA     8           NISSAN      BLAU        2016-03-16
3345SAW     15          HONDA       BLANC       2016-03-16
5874OPL     30          INFINITY    LILA        2016-03-16

*/
