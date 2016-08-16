CREATE TABLE IF NOT EXISTS dept (
 dept_no  TINYINT (2),
 dnom     VARCHAR(14) NOT NULL UNIQUE,
 loc      VARCHAR(14),
 PRIMARY KEY (dept_no) ) ;


INSERT INTO dept VALUES (10, 'COMPTABILITAT', 'SEVILLA');
INSERT INTO dept VALUES (20, 'INVESTIGACIO', 'MADRID');
INSERT INTO dept VALUES (30, 'VENDES', 'BARCELONA');
INSERT INTO dept VALUES (40, 'PRODUCCIO', 'BILBAO');

CREATE TABLE IF NOT EXISTS emp (
 emp_no    SMALLINT (4),
 cognom    VARCHAR (10) NOT NULL,
 ofici     VARCHAR (10),
 cap       SMALLINT (4),
 data_alta DATE,
 salari    INT,
 comissio  INT,
 dept_no   TINYINT (2) NOT NULL,
 PRIMARY KEY (EMP_NO),
 FOREIGN KEY (dept_no) REFERENCES dept(dept_no),
 FOREIGN KEY (cap) REFERENCES emp(emp_no));

INSERT INTO emp VALUES (7369,'SANCHEZ','EMPLEAT',7902, '1980-12-17', 104000,NULL,20);
INSERT INTO emp VALUES (7499,'ARROYO','VENEDOR',7698, '1980-02-20', 208000,39000,30);
INSERT INTO emp VALUES (7521,'SALA','VENEDOR',7698, '1981-02-22', 162500,65000,30);
INSERT INTO emp VALUES (7566,'JIMENEZ','DIRECTOR',7839, '1981-04-02', 386750,NULL,20);
INSERT INTO emp VALUES (7654,'MARTIN','VENEDOR',7698, '1981-09-29', 162500,182000,30);
INSERT INTO emp VALUES (7698,'NEGRO','DIRECTOR',7839, '1981-05-01', 370500,NULL,30);
INSERT INTO emp VALUES (7782,'CEREZO','DIRECTOR',7839, '1981-06-09', 318500,NULL,10);
INSERT INTO emp VALUES (7788,'GIL','ANALISTA',7566, '1981-11-09', 390000,NULL,20);
INSERT INTO emp VALUES (7839,'REY','PRESIDENT',NULL, '1981-11-17', 650000,NULL,10);
INSERT INTO emp VALUES (7844,'TOVAR','VENEDOR',7698, '1981-09-08', 195000,0,30);
INSERT INTO emp VALUES (7876,'ALONSO','EMPLEAT',7788, '1981-09-23', 143000,NULL,20);
INSERT INTO emp VALUES (7900,'JIMENO','EMPLEAT',7698, '1981-12-03', 123500,NULL,30);
INSERT INTO emp VALUES (7902,'FERNANDEZ','ANALISTA',7566, '1981-12-03', 390000,NULL,20);
INSERT INTO emp VALUES (7934,'MUNOZ','EMPLEAT',7782, '1982-01-23', 169000,NULL,10);


CREATE TABLE IF NOT EXISTS client (
 CLIENT_COD          INT(6) PRIMARY KEY,
 NOM                 VARCHAR (45) NOT NULL,
 ADRECA              VARCHAR (40) NOT NULL,
 CIUTAT              VARCHAR (30) NOT NULL,
 ESTAT               VARCHAR (2),
 CODI_POSTAL         VARCHAR (9) NOT NULL,
 AREA                SMALLINT(3),
 TELEFON             VARCHAR (9),
 REPR_COD            SMALLINT(4),
 LIMIT_CREDIT        DECIMAL(9,2),
 OBSERVACIONS        TEXT,
 FOREIGN KEY (REPR_COD) REFERENCES emp(EMP_NO));


INSERT INTO client VALUES (100, 'JOCKSPORTS', '345 VIEWRIDGE', 'BELMONT', 'CA', '96711', 415,
        '598-6609', 7844, 5000, 
        'Very friendly people to work with -- sales rep likes to be called Mike.');
INSERT INTO client VALUES (101, 'TKB SPORT SHOP', '490 BOLI RD.', 'REDWOOD CIUTAT', 'CA', '94061', 415,
        '368-1223', 7521, 10000, 
        'Rep called 5/8 about change in order - contact shipping.');
INSERT INTO client VALUES (102, 'VOLLYRITE', '9722 HAMILTON', 'BURLINGAME', 'CA', '95133', 415,
        '644-3341', 7654, 7000, 
        'Company doing heavy promotion beginning 10/89. Prepare for large orders during winter.');
INSERT INTO client VALUES (103, 'JUST TENNIS', 'HILLVIEW MALL', 'BURLINGAME', 'CA', '97544', 415,
        '677-9312', 7521, 3000, 
        'Contact rep about new line of tennis rackets.');
INSERT INTO client VALUES (104, 'EVERY MOUNTAIN', '574 SURRY RD.', 'CUPERTINO', 'CA', '93301', 408,
        '996-2323', 7499, 10000, 
        'CLIENT with high market share (23%) due to aggressive advertising.');
INSERT INTO client VALUES (105, 'K + T SPORTS', '3476 EL PASEO', 'SANTA CLARA', 'CA', '91003', 408,
        '376-9966', 7844, 5000, 
        'Tends to order large amounts of merchandise at once. Accounting is considering raising their credit limit. Usually pays on time.');
INSERT INTO client VALUES (106, 'SHAPE UP', '908 SEQUOIA', 'PALO ALTO', 'CA', '94301', 415,
        '364-9777', 7521, 6000, 
        'Support intensive. Orders small amounts (< 800) of merchandise at a time.');
INSERT INTO client VALUES (107, 'WOMEN SPORTS', 'VALCO VILLAGE', 'SUNNYVALE', 'CA', '93301', 408,
        '967-4398', 7499, 10000, 
        'First sporting goods store geared exclusively towards women. Unusual promotion al style and very willing to take chances towards new PRODUCTEs!');
INSERT INTO client VALUES (108, 'NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER', '98 LONE PINE WAY', 'HIBBING', 'MN', '55649', 612,
        '566-9123', 7844, 8000, '');
INSERT INTO client VALUES (109, 'SPRINGFIELD NUCLEAR POWER PLANT', '13 PERCEBE STR.', 'SPRINGFIELD', 'NT', '0000', 636,
        '999-6666', NULL, 10000, '');


CREATE TABLE IF NOT EXISTS producte (
 PROD_NUM     INT (6) PRIMARY KEY,
 DESCRIPCIO   VARCHAR (30) NOT NULL  UNIQUE);


INSERT INTO producte VALUES (100860, 'ACE TENNIS RACKET I');
INSERT INTO producte VALUES (100861, 'ACE TENNIS RACKET II');
INSERT INTO producte VALUES (100870, 'ACE TENNIS BALLS-3 PACK');
INSERT INTO producte VALUES (100871, 'ACE TENNIS BALLS-6 PACK');
INSERT INTO producte VALUES (100890, 'ACE TENNIS NET');
INSERT INTO producte VALUES (101860, 'SP TENNIS RACKET');
INSERT INTO producte VALUES (101863, 'SP JUNIOR RACKET');
INSERT INTO producte VALUES (102130, 'RH: "GUIDE TO TENNIS"');
INSERT INTO producte VALUES (200376, 'SB ENERGY BAR-6 PACK');
INSERT INTO producte VALUES (200380, 'SB VITA SNACK-6 PACK');


CREATE TABLE IF NOT EXISTS comanda  (
 COM_NUM             SMALLINT(4) PRIMARY KEY,
 COM_DATA            DATE,
 COM_TIPUS           CHAR (1) CHECK (COM_TIPUS IN ('A','B','C')),
 CLIENT_COD          INT (6) NOT NULL,
 DATA_TRAMESA        DATE,
 TOTAL               DECIMAL(8,2),
 FOREIGN KEY (CLIENT_COD) REFERENCES client(CLIENT_COD) );


INSERT INTO comanda VALUES (610, '2014-01-07', 'A', 101, '2014-01-08', 101.4);
INSERT INTO comanda VALUES (611, '2014-01-11', 'B', 102,'2014-01-11', 45);
INSERT INTO comanda VALUES (612, '2014-01-15', 'C', 104, '2014-01-20', 5860);
INSERT INTO comanda VALUES (601, '2013-05-01', 'A', 106, '2013-05-30', 2.4);
INSERT INTO comanda VALUES (602, '2013-06-05', 'B', 102, '2013-06-20', 56);
INSERT INTO comanda VALUES (604, '2013-06-15', 'A', 106, '2013-06-30', 698);
INSERT INTO comanda VALUES (605, '2013-07-14', 'A', 106,  '2013-07-30', 8324);
INSERT INTO comanda VALUES (606, '2013-07-14', 'A', 100,  '2013-07-30', 3.4);
INSERT INTO comanda VALUES (609, '2013-08-01', 'B', 100,  '2013-08-15', 97.5);
INSERT INTO comanda VALUES (607, '2013-07-18', 'C', 104,  '2013-07-18', 5.6);
INSERT INTO comanda VALUES (608, '2013-07-25', 'C', 104,  '2013-07-25', 35.2);
INSERT INTO comanda VALUES (603, '2013-06-05', NULL, 102, '2013-06-05', 224);
INSERT INTO comanda VALUES (620, '2014-03-12', NULL, 100, '2014-03-12', 4450);
INSERT INTO comanda VALUES (613, '2014-02-01', NULL, 108, '2014-02-01', 6400);
INSERT INTO comanda VALUES (614, '2014-02-01', NULL, 102, '2014-02-05', 23940);
INSERT INTO comanda VALUES (616, '2014-02-03', NULL, 103, '2014-02-10', 764);
INSERT INTO comanda VALUES (619, '2014-02-22', NULL, 104, '2014-02-04', 1260);
INSERT INTO comanda VALUES (617, '2014-02-05', NULL, 104, '2014-03-03', 46370);
INSERT INTO comanda VALUES (615, '2014-02-01', NULL, 107, '2014-02-06', 710);
INSERT INTO comanda VALUES (618, '2014-02-15', 'A', 102, '2014-03-06', 3510.5);
INSERT INTO comanda VALUES (621, '2014-03-15', 'A', 100, '2014-01-01', 730);



CREATE TABLE IF NOT EXISTS detall  (
 COM_NUM             SMALLINT(4),
 DETALL_NUM          SMALLINT(4),
 PROD_NUM            INT(6) NOT NULL,
 PREU_VENDA          DECIMAL(8,2),
 QUANTITAT           INT (8),
 IMPORT              DECIMAL(8,2),
 CONSTRAINT DETALL_PK PRIMARY KEY (COM_NUM,DETALL_NUM),
 FOREIGN KEY (COM_NUM) REFERENCES comanda(COM_NUM),
 FOREIGN KEY (PROD_NUM) REFERENCES producte(PROD_NUM));


INSERT INTO detall VALUES (610, 3, 100890, 58, 1, 58);
INSERT INTO detall VALUES (611, 1, 100861, 45, 1, 45);
INSERT INTO detall VALUES (612, 1, 100860, 30, 100, 3000);
INSERT INTO detall VALUES (601, 1, 200376, 2.4, 1, 2.4);
INSERT INTO detall VALUES (602, 1, 100870, 2.8, 20, 56);
INSERT INTO detall VALUES (604, 1, 100890, 58, 3, 174);
INSERT INTO detall VALUES (604, 2, 100861, 42, 2, 84);
INSERT INTO detall VALUES (604, 3, 100860, 44, 10, 440);
INSERT INTO detall VALUES (603, 2, 100860, 56, 4, 224);
INSERT INTO detall VALUES (610, 1, 100860, 35, 1, 35);
INSERT INTO detall VALUES (610, 2, 100870, 2.8, 3, 8.4);
INSERT INTO detall VALUES (613, 4, 200376, 2.2, 200, 440);
INSERT INTO detall VALUES (614, 1, 100860, 35, 444, 15540);
INSERT INTO detall VALUES (614, 2, 100870, 2.8, 1000, 2800);
INSERT INTO detall VALUES (612, 2, 100861, 40.5, 20, 810);
INSERT INTO detall VALUES (612, 3, 101863, 10, 150, 1500);
INSERT INTO detall VALUES (620, 1, 100860, 35, 10, 350);
INSERT INTO detall VALUES (620, 2, 200376, 2.4, 1000, 2400);
INSERT INTO detall VALUES (620, 3, 102130, 3.4, 500, 1700);
INSERT INTO detall VALUES (613, 1, 100871, 5.6, 100, 560);
INSERT INTO detall VALUES (613, 2, 101860, 24, 200, 4800);
INSERT INTO detall VALUES (613, 3, 200380, 4, 150, 600);
INSERT INTO detall VALUES (619, 3, 102130, 3.4, 100, 340);
INSERT INTO detall VALUES (617, 1, 100860, 35, 50, 1750);
INSERT INTO detall VALUES (617, 2, 100861, 45, 100, 4500);
INSERT INTO detall VALUES (614, 3, 100871, 5.6, 1000, 5600);
INSERT INTO detall VALUES (616, 1, 100861, 45, 10, 450);
INSERT INTO detall VALUES (616, 2, 100870, 2.8, 50, 140);
INSERT INTO detall VALUES (616, 3, 100890, 58, 2, 116);
INSERT INTO detall VALUES (616, 4, 102130, 3.4, 10, 34);
INSERT INTO detall VALUES (616, 5, 200376, 2.4, 10, 24);
INSERT INTO detall VALUES (619, 1, 200380, 4, 100, 400);
INSERT INTO detall VALUES (619, 2, 200376, 2.4, 100, 240);
INSERT INTO detall VALUES (615, 1, 100861, 45, 4, 180);
INSERT INTO detall VALUES (607, 1, 100871, 5.6, 1, 5.6);
INSERT INTO detall VALUES (615, 2, 100870, 2.8, 100, 280);
INSERT INTO detall VALUES (617, 3, 100870, 2.8, 500, 1400);
INSERT INTO detall VALUES (617, 4, 100871, 5.6, 500, 2800);
INSERT INTO detall VALUES (617, 5, 100890, 58, 500, 29000);
INSERT INTO detall VALUES (617, 6, 101860, 24, 100, 2400);
INSERT INTO detall VALUES (617, 7, 101863, 12.5, 200, 2500);
INSERT INTO detall VALUES (617, 8, 102130, 3.4, 100, 340);
INSERT INTO detall VALUES (617, 9, 200376, 2.4, 200, 480);
INSERT INTO detall VALUES (617, 10, 200380, 4, 300, 1200);
INSERT INTO detall VALUES (609, 2, 100870, 2.5, 5, 12.5);
INSERT INTO detall VALUES (609, 3, 100890, 50, 1, 50);
INSERT INTO detall VALUES (618, 1, 100860, 35, 23, 805);
INSERT INTO detall VALUES (618, 2, 100861, 45.11, 50, 2255.5);
INSERT INTO detall VALUES (621, 1, 100861, 45, 10, 450);
INSERT INTO detall VALUES (621, 2, 100870, 2.8, 100, 280);
INSERT INTO detall VALUES (615, 3, 100871, 5, 50, 250);
INSERT INTO detall VALUES (608, 1, 101860, 24, 1, 24);
INSERT INTO detall VALUES (608, 2, 100871, 5.6, 2, 11.2);
INSERT INTO detall VALUES (609, 1, 100861, 35, 1, 35);
INSERT INTO detall VALUES (606, 1, 102130, 3.4, 1, 3.4);
INSERT INTO detall VALUES (605, 1, 100861, 45, 100, 4500);
INSERT INTO detall VALUES (605, 2, 100870, 2.8, 500, 1400);
INSERT INTO detall VALUES (605, 3, 100890, 58, 5, 290);
INSERT INTO detall VALUES (605, 4, 101860, 24, 50, 1200);
INSERT INTO detall VALUES (605, 5, 101863, 9, 100, 900);
INSERT INTO detall VALUES (605, 6, 102130, 3.4, 10, 34);
INSERT INTO detall VALUES (612, 4, 100871, 5.5, 100, 550);
INSERT INTO detall VALUES (619, 4, 100871, 5.6, 50, 280);

/*3

1) sqlite> select emp.emp_no, emp.cognom, dept.dept_no, dept.dnom from emp INNER JOIN dept where emp.dept_no=dept.dept_no;
emp_no      cognom      dept_no     dnom        
----------  ----------  ----------  ------------
7369        SANCHEZ     20          INVESTIGACIO
7499        ARROYO      30          VENDES      
7521        SALA        30          VENDES      
7566        JIMENEZ     20          INVESTIGACIO
7654        MARTIN      30          VENDES      
7698        NEGRO       30          VENDES      
7782        CEREZO      10          COMPTABILITA
7788        GIL         20          INVESTIGACIO
7839        REY         10          COMPTABILITA
7844        TOVAR       30          VENDES      
7876        ALONSO      20          INVESTIGACIO
7900        JIMENO      30          VENDES      
7902        FERNANDEZ   20          INVESTIGACIO
7934        MUNOZ       10          COMPTABILITA

2) sqlite> select dept.dept_no, dept.dnom, nova.max_salari from dept LEFT JOIN (select dept_no, max(salari) as max_salari from emp group by dept_no) as nova on dept.dept_no=nova.dept_no;
dept_no     dnom           max_salari
----------  -------------  ----------
10          COMPTABILITAT  650000    
20          INVESTIGACIO   390000    
30          VENDES         370500    
40          PRODUCCIO        

//SQLITE NO POSA NULL AL REALITZAR EL MAPEIG i NO TROBAR-LA.      

3) sqlite> select emp.emp_no, emp.cognom, client.client_cod, client.nom from emp LEFT JOIN client on emp.emp_no=client.repr_cod;
emp_no      cognom      CLIENT_COD  NOM       
----------  ----------  ----------  ----------
7369        SANCHEZ                           
7499        ARROYO      104         EVERY MOUN
7499        ARROYO      107         WOMEN SPOR
7521        SALA        101         TKB SPORT 
7521        SALA        103         JUST TENNI
7521        SALA        106         SHAPE UP  
7566        JIMENEZ                           
7654        MARTIN      102         VOLLYRITE 
7698        NEGRO                             
7782        CEREZO                            
7788        GIL                               
7839        REY                               
7844        TOVAR       100         JOCKSPORTS
7844        TOVAR       105         K + T SPOR
7844        TOVAR       108         NORTH WOOD
7876        ALONSO                            
7900        JIMENO                            
7902        FERNANDEZ                         
7934        MUNOZ                             

//HEM ENTES TOTS ELS EMPLEATS, SIGUIN REPRESENTANTS O NO.

//SI VOLGUESSIM NOMES AQUELLS QUE SON REPRESENTANTS...????

4) sqlite> select client.client_cod, client.nom, emp.emp_no, emp.cognom from client LEFT JOIN emp on emp.emp_no=client.repr_cod;
CLIENT_COD  NOM         emp_no      cognom    
----------  ----------  ----------  ----------
100         JOCKSPORTS  7844        TOVAR     
101         TKB SPORT   7521        SALA      
102         VOLLYRITE   7654        MARTIN    
103         JUST TENNI  7521        SALA      
104         EVERY MOUN  7499        ARROYO    
105         K + T SPOR  7844        TOVAR     
106         SHAPE UP    7521        SALA      
107         WOMEN SPOR  7499        ARROYO    
108         NORTH WOOD  7844        TOVAR     
109         SPRINGFIEL                        

//QUE PASSA SI NO TENEN REPRESENTANT???

5) i 6) repetides!!!

7) sqlite> select emp.emp_no, emp.salari, nova.salari_mig_dept from emp LEFT JOIN (select dept_no, avg(salari) as salari_mig_dept from emp group by dept_no) as nova where emp.dept_no=nova.dept_no and emp.salari>nova.salari_mig_dept;
emp_no      salari      salari_mig_dept 
----------  ----------  ----------------
7499        208000      203666.666666667
7566        386750      282750.0        
7698        370500      203666.666666667
7788        390000      282750.0        
7839        650000      379166.666666667
7902        390000      282750.0        

//COMPROVAR SI ESTA BE!!!

8)sqlite> select emp.cognom from emp where emp.ofici=(select emp.ofici from emp where emp.cognom='SALA');
ARROYO
SALA
MARTIN
TOVAR

9) sqlite> select emp.cognom,emp.ofici from emp where emp.dept_no=20 and emp.ofici in (select emp.ofici from emp,dept where emp.dept_no=dept.dept_no and dept.dnom='VENDES' group by emp.ofici);
cognom      ofici     
----------  ----------
SANCHEZ     EMPLEAT   
JIMENEZ     DIRECTOR  
ALONSO      EMPLEAT 


10)sqlite> select emp.cognom from emp where emp.ofici=(select emp.ofici from emp where emp.cognom='NEGRO') or emp.salari>=(select emp.salari from emp where emp.cognom='GIL');
cognom    
----------
JIMENEZ   
NEGRO     
CEREZO    
GIL       
REY       
FERNANDEZ 

11) sqlite> select emp.emp_no,emp.cognom,dept.dnom from emp inner join dept where emp.dept_no=dept.dept_no and emp.ofici='DIRECTOR' order by emp.cognom;
emp_no      cognom      dnom         
----------  ----------  -------------
7782        CEREZO      COMPTABILITAT
7566        JIMENEZ     INVESTIGACIO 
7698        NEGRO       VENDES  

12) sqlite> select dept.dnom,sum(emp.salari) as Total from emp inner join dept where emp.dept_no=dept.dept_no group by emp.dept_no order by Total desc;
dnom          Total     
------------  ----------
INVESTIGACIO  1413750   
VENDES        1222000   
COMPTABILITA  1137500 

13) sqlite> select dnom as Departament from (select dept.dnom,min(emp.data_alta) as Data from emp inner join dept where dept.dept_no=emp.dept_no group by dept.dnom order by Data desc);
Departament  
-------------
COMPTABILITAT
INVESTIGACIO 
VENDES

14) sqlite> select emp.emp_no, emp.cognom, nova2.comandes_gestionades from emp left join (select client.repr_cod, sum(nova.num_comandes) as comandes_gestionades from client left join (select client_cod, count(client_cod) as num_comandes from comanda group by(client_cod)) as nova where client.client_cod=nova.client_cod group by repr_cod) as nova2 on emp.emp_no=nova2.repr_cod order by emp.cognom;
emp_no      cognom      comandes_gestionades
----------  ----------  --------------------
7876        ALONSO                          
7499        ARROYO      6                   
7782        CEREZO                          
7902        FERNANDEZ                       
7788        GIL                             
7566        JIMENEZ                         
7900        JIMENO                          
7654        MARTIN      5                   
7934        MUNOZ                           
7698        NEGRO                           
7839        REY                             
7521        SALA        5                   
7369        SANCHEZ                         
7844        TOVAR       5                   

15) sqlite> select emp.emp_no, emp.cognom, nova2.comandes_gestionades from emp left join (select client.repr_cod, sum(nova.num_comandes) as comandes_gestionades from client left join (select client_cod, count(client_cod) as num_comandes from comanda group by(client_cod)) as nova where client.client_cod=nova.client_cod group by repr_cod) as nova2 on emp.emp_no=nova2.repr_cod where nova2.comandes_gestionades > 3 order by nova2.comandes_gestionades DESC;
emp_no      cognom      comandes_gestionades
----------  ----------  --------------------
7499        ARROYO      6                   
7521        SALA        5                   
7654        MARTIN      5                   
7844        TOVAR       5                   

16) sqlite> select detall.prod_num, detall.preu_venda,max(comanda.com_data) as Ultima_venda from detall inner join comanda where detall.com_num=comanda.com_num group by detall.prod_num;
PROD_NUM    PREU_VENDA  Ultima_venda
----------  ----------  ------------
100860      35          2014-03-12  
100861      45          2014-03-15  
100870      2.8         2014-03-15  
100871      5.6         2014-02-22  
100890      58          2014-02-05  
101860      24          2014-02-05  
101863      12.5        2014-02-05  
102130      3.4         2014-03-12  
200376      2.4         2014-03-12  
200380      4           2014-02-22 

17) sqlite> select nova.client_cod from (select client_cod, sum(total) as total from comanda where strftime('%Y',com_data) = "2014" group by client_cod) as nova left join (select client_cod, limit_credit/2 as max from client) as nova2 on nova.client_cod=nova2.client_cod where nova.total > nova2.max;
client_cod
----------
100       
102       
104       
108       

*/
