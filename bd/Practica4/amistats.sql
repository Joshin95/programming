drop table if exists usuaris;
drop table if exists amistats;
drop table if exists preferencies;

create table usuaris(ID int not null, nom text, grau int,
PRIMARY KEY (ID));

create table amistats(ID1 int, ID2 int,
PRIMARY KEY (ID1,ID2),
FOREIGN KEY (ID1) REFERENCES usuaris(ID),
FOREIGN KEY (ID2) REFERENCES usuaris(ID));

create table amicsPotencials(ID1 int, ID2 int,
PRIMARY KEY (ID1,ID2),
FOREIGN KEY (ID1) REFERENCES usuaris(ID),
FOREIGN KEY (ID2) REFERENCES usuaris(ID));


create table preferencies(ID1 int, ID2 int,
PRIMARY KEY (ID1,ID2)
FOREIGN KEY (ID1) REFERENCES usuaris(ID),
FOREIGN KEY (ID2) REFERENCES usuaris(ID));


insert into usuaris values (1510, 'Jordan', 9);
insert into usuaris values (1689, 'Gabriel', 9);
insert into usuaris values (1381, 'Tiffany', 9);
insert into usuaris values (1709, 'Cassandra', 9);
insert into usuaris values (1101, 'Haley', 10);
insert into usuaris values (1782, 'Andrew', 10);
insert into usuaris values (1468, 'Kris', 10);
insert into usuaris values (1641, 'Brittany', 10);
insert into usuaris values (1247, 'Alexis', 11);
insert into usuaris values (1316, 'Austin', 11);
insert into usuaris values (1911, 'Gabriel', 11);
insert into usuaris values (1501, 'Jessica', 11);
insert into usuaris values (1304, 'Jordan', 12);
insert into usuaris values (1025, 'John', 12);
insert into usuaris values (1934, 'Kyle', 12);
insert into usuaris values (1661, 'Logan', 12);

insert into amistats values (1510, 1381);
insert into amistats values (1510, 1689);
insert into amistats values (1689, 1709);
insert into amistats values (1381, 1247);
insert into amistats values (1709, 1247);
insert into amistats values (1689, 1782);
insert into amistats values (1782, 1468);
insert into amistats values (1782, 1316);
insert into amistats values (1782, 1304);
insert into amistats values (1468, 1101);
insert into amistats values (1468, 1641);
insert into amistats values (1101, 1641);
insert into amistats values (1247, 1911);
insert into amistats values (1247, 1501);
insert into amistats values (1911, 1501);
insert into amistats values (1501, 1934);
insert into amistats values (1316, 1934);
insert into amistats values (1934, 1304);
insert into amistats values (1304, 1661);
insert into amistats values (1661, 1025);
insert into amistats select ID2, ID1 from amistats; 

insert into preferencies values(1689, 1709);
insert into preferencies values(1709, 1689);
insert into preferencies values(1782, 1709);
insert into preferencies values(1911, 1247);
insert into preferencies values(1247, 1468);
insert into preferencies values(1641, 1468);
insert into preferencies values(1316, 1304);
insert into preferencies values(1501, 1934);
insert into preferencies values(1934, 1501);
insert into preferencies values(1025, 1101);



create trigger T1
after insert on usuaris
for each row
begin
  insert into amicsPotencials select New.ID,ID from usuaris where New.grau=grau and New.Id!=Id;
end;

insert into usuaris values (9999, 'Iniesta', 9);


create trigger T2
after insert on usuaris
for each row
when (New.grau is null)
begin
  update usuaris set grau=9 where grau=New.grau;
end;


create trigger T3
after insert on usuaris
for each row
when (New.grau < 9 or New.grau > 12)
begin
  update usuaris set grau=null where grau=New.grau;
end;

insert into usuaris values (1899, 'David', 8);
insert into usuaris values (1111, 'Alejandro',null);


create trigger T4
after insert on amistats
for each row
when (New.ID2 not in (select ID1 from amistats)) and (New.ID1 not in (select ID2 from amistats))
begin
  insert into amistats values (New.ID2, New.ID1);
end;

insert into usuaris values (7777, 'Sergi', 10);
insert into usuaris values (8888, 'Gregor', 11);
insert into amistats values (7777, 8888);


create trigger T5
after update of grau on usuaris
for each row
when New.grau > 12
begin
  delete from usuaris where grau=New.grau;
end;

update usuaris set grau=13 where nom='David';


create trigger T6
after update of grau on usuaris
for each row
when New.grau=Old.grau+1
begin
  update usuaris set grau=New.grau where ID in (select ID1 from amistats where ID2==old.ID union select ID2 from amistats where ID1==old.ID); 
end;

update usuaris set grau=13 where nom='Logan';


create trigger T7
after update on preferencies
for each row
when exists (select * from amistats where old.ID2==ID1 and new.ID2==ID2)
begin
  delete from amistats where ID1==old.ID2 and ID2==new.ID2;
  delete from amistats where ID1==new.ID2 and ID2==old.ID2;
end;


insert into usuaris values (3333, 'A', 8);
insert into usuaris values (4444, 'B', 8);
insert into usuaris values (5555, 'C', 8);
insert into preferencies values (3333,4444);
insert into amistats values (4444,5555);
update preferencies set ID2=5555 where ID1=3333;

/*
sqlite> select * from usuaris;

ID          nom         grau      
----------  ----------  ----------
1510        Jordan      9         
1689        Gabriel     9         
1381        Tiffany     9         
1709        Cassandra   9         
1101        Haley       10        
1782        Andrew      10        
1468        Kris        10        
1641        Brittany    10        
1247        Alexis      11        
1316        Austin      11        
1911        Gabriel     11        
1501        Jessica     11        
1934        Kyle        12        
9999        Iniesta     9         
1111        Alejandro             
7777        Sergi       10        
8888        Gregor      11        
3333        A                     
4444        B                     
5555        C    


sqlite> select * from preferencies;

ID1         ID2       
----------  ----------
1689        1709      
1709        1689      
1782        1709      
1911        1247      
1247        1468      
1641        1468      
1316        1304      
1501        1934      
1934        1501      
1025        1101      
3333        5555      
                 

sqlite> select * from amistats;

ID1         ID2       
----------  ----------
1510        1381      
1510        1689      
1689        1709      
1381        1247      
1709        1247      
1689        1782      
1782        1468      
1782        1316      
1782        1304      
1468        1101      
1468        1641      
1101        1641      
1247        1911      
1247        1501      
1911        1501      
1501        1934      
1316        1934      
1934        1304      
1304        1661      
1661        1025      
1381        1510      
1689        1510      
1709        1689      
1247        1381      
1247        1709      
1782        1689      
1468        1782      
1316        1782      
1304        1782      
1101        1468      
1641        1468      
1641        1101      
1911        1247      
1501        1247      
1501        1911      
1934        1501      
1934        1316      
1304        1934      
1661        1304      
1025        1661      
7777        8888      
8888        7777      
*/
