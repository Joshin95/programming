/*
sqlite3 sensors.bd < sensorsCreation.sql >out.txt
*/
CREATE TABLE IF NOT EXISTS sensors (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 result_time  DATETIME,
 epoch INT,
 nodeid INT,
 light INT,
 temp INT,
 voltage INT) ;


INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 09:10:18',639,1,555,26,400);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:20:10',653,1,556,12,420);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,1,557,38,430);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,1,557,40,430);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:33:15',712,1,558,15,433);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:40:23',715,1,560,0,512);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 12:42:28',725,1,562,27,323);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),727,1,555,20,401);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),729,1,566,12,333);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),734,1,568,13,0);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 09:10:20',639,2,555,0,325);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:20:10',653,2,556,5,386);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,2,557,10,402);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,2,557,15,402);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:33:15',712,2,558,11,415);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:40:23',715,2,560,12,411);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 12:42:28',725,2,562,13,450);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),727,2,564,14,300);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),729,2,566,15,400);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),734,2,568,16,408);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 09:10:18',639,3,555,-2,418);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:20:10',653,3,556,0,300);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,3,557,2,0);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 10:30:11',683,3,557,8,0);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:33:15',712,3,558,4,420);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:40:23',715,3,560,10,478);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 12:42:28',725,3,562,12,499);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),727,3,564,13,501);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),729,3,566,14,512);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),734,3,568,15,534);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),812,1,null,null,null);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),812,2,568,15,538);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),812,3,null,null,null);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),813,1,null,null,null);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),813,2,568,15,538);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES (DATETIME('now'),813,3,null,null,null);
INSERT INTO sensors (result_time,epoch,nodeid,light,temp,voltage) VALUES ('2015-03-05 11:33:15',712,3,558,null,420);



CREATE TABLE calib_temp as select temp, avg(temp)+temp as calib from sensors group by temp;
CREATE TABLE calib_light as select light, avg(light)+light as calib from sensors group by light;

/*
1.
sqlite> select id,result_time from sensors where light>550;
id          result_time        
----------  -------------------
1           2015-03-05 09:10:18
2           2015-03-05 10:20:10
3           2015-03-05 10:30:11
4           2015-03-05 11:33:15
5           2015-03-05 11:40:23
6           2015-03-05 12:42:28
7           2016-03-07 17:51:45
8           2016-03-07 17:51:45
9           2016-03-07 17:51:46
10          2015-03-05 09:10:18
11          2015-03-05 10:20:10
12          2015-03-05 10:30:11
13          2015-03-05 11:33:15
14          2015-03-05 11:40:23
15          2015-03-05 12:42:28
16          2016-03-07 17:51:47
17          2016-03-07 17:51:48
18          2016-03-07 17:51:48
19          2015-03-05 09:10:18
20          2015-03-05 10:20:10
21          2015-03-05 10:30:11
22          2015-03-05 11:33:15
23          2015-03-05 11:40:23
24          2015-03-05 12:42:28
25          2016-03-07 17:51:50
26          2016-03-07 17:51:50
27          2016-03-07 17:51:50


2.
sqlite> select avg(light) from sensors where time(result_time) >= '10:00:00' and time(result_time) <= '11:00:00' and nodeid = 1;
avg(light)
----------
556.5      

Fem entre les 10 PM i les 11 PM ja que entre les 6 PM i les 9 PM no hi ha cap.

3.
sqlite> select nodeid,avg(temp) as PromigTemp,avg(light) as PromigLight from sensors where time(result_time) >= '10:00:00' and time(result_time) <= '11:00:00' and voltage <= 418 group by nodeid;
nodeid      PromigTemp  PromigLight
----------  ----------  -----------
2           7.5         556.5      
3           1.0         556.5         

Fem entre les 10 PM i les 11 PM ja que entre les 6 PM i les 9 PM no hi ha cap.

4.

sqlite> select strftime('%H',result_time) as Time,avg(temp)+temp as PromigTemp from sensors where nodeid = 2 and time(result_time) >= '09:00:00' and time(result_time) <= '12:00:00' group by strftime('%H',result_time);
Time        PromigTemp
----------  ----------
09          0.0       
10          17.5      
11          23.5      

Fem entre les 10 PM i les 12 PM ja que entre les 6 PM i les 9 PM no hi ha cap.

5.
sqlite> select distinct T.epoch as epoch, (S.T2 - T.T1) as diferencia from (select epoch,strftime('%S',result_time) as T1 from sensors where nodeid=1) as T, (select epoch,strftime('%S',result_time) as T2 from sensors where nodeid=2) as S where S.epoch=T.epoch and (S.T2-T.T1)>1;
epoch       diferencia
----------  ----------
639         2         


6. 
sqlite3> select epoch from sensors where light is null or temp is null or voltage is null group by epoch order by epoch;
epoch     
----------
812       
813       


7) sqlite> select nodeid,avg(temp) as Promig from sensors where epoch=683 group by nodeid;
nodeid      Promig    
----------  ----------
1           39.0      
2           12.5      
3           5.0   


8)sqlite> select epoch from sensors where temp is null group by epoch;
epoch     
----------
712       
812       
813       
*/
