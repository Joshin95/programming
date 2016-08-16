from urllib2 import urlopen
from csv import reader
import os           
import struct             
import string             
import sqlite3 as lite
import sys

def crear_taula1():                     
    try:
        con = lite.connect('barcelona.db')
        
        cur = con.cursor()  
    
        cur.executescript("""
        DROP TABLE IF EXISTS DEFUNCIONS;
        CREATE TABLE DEFUNCIONS(
        DTE INT  NOT NULL,
        BARRIS VARCHAR(80) NOT NULL,
        TOTAL INT  NOT NULL,
        HOMES INT NOT NULL,
        DONES INT NOT NULL,
        PRIMARY KEY(DTE,BARRIS));
        """)
        
        con.commit()
    
    except lite.Error, e:
        
        if con:
            con.rollback()
        
        print "Error %s:" % e.args[0]
        sys.exit(1)
        
    finally:
        
        if con:
            con.close() 

def afegir_dades1():
    r=0
    con = lite.connect('barcelona.db')

    with con:
        
        cur = con.cursor()    
        try:
           
            f=urlopen("http://opendata.bcn.cat/opendata/ca/descarrega-fitxer?url=http%3a%2f%2fbismartopendata.blob.core.windows.net%2fopendata%2fopendata%2f2013_defuncionsa2013.csv&name=defuncionsa2013.csv")
            j=reader(f)
            for i in j:
                if r>3:
                    if len(i) == 2:
                        pass
                    else:
                        x=i[0].split(";")
                        if (x[0]!=""):
                            cur.execute("INSERT INTO DEFUNCIONS(DTE,BARRIS,TOTAL,HOMES,DONES) VALUES (?,?,?,?,?);", ((x[0],comprova(x[1]),x[2],x[3],x[4])))
                r+=1
            con.commit()
            print
            print "Dades afegides correctament"
            print
        except Exception:
            print "Error en afegir les dades"
    con.close()

def crear_taula2():                     
    try:
        con = lite.connect('barcelona.db')
        
        cur = con.cursor()  
    
        cur.executescript("""
        DROP TABLE IF EXISTS DENSITAT;
        CREATE TABLE DENSITAT(
        DTE INT NOT NULL,
        BARRIS VARCHAR(80) NOT NULL,
        POBLACIO INT NOT NULL,
        SUPERFICIE INT NOT NULL,
        DENSITAT INT NOT NULL,
        DENSITAT_NETA INT NOT NULL,
        PRIMARY KEY(DTE,BARRIS));
        """)
        
        con.commit()
    
    except lite.Error, e:
        
        if con:
            con.rollback()
        
        print "Error %s:" % e.args[0]
        sys.exit(1)
        
    finally:
        
        if con:
            con.close() 

def afegir_dades2():
    r=0
    con = lite.connect('barcelona.db')

    with con:
        
        cur = con.cursor()    
        try:
           
            f=urlopen("http://opendata.bcn.cat/opendata/ca/descarrega-fitxer?url=http%3a%2f%2fbismartopendata.blob.core.windows.net%2fopendata%2fopendata%2f2013_superficiedens2013.csv&name=superficiedens2013.csv")
            j=reader(f)
            for i in j:
                if r>3:
                    if len(i) == 2:
                        pass
                    else:
                        x=i[0].split(";")
                        if (x[0]!=""):
                            cur.execute("INSERT INTO DENSITAT(DTE,BARRIS,POBLACIO,SUPERFICIE,DENSITAT,DENSITAT_NETA) VALUES (?,?,?,?,?,?);", (int(x[0]),comprova(x[1]),int(comprova2(x[2])),int(comprova2(x[3])),int(comprova2(x[4])),int(comprova2(x[5]))))
                r+=1
                
            con.commit()
            print
            print "Dades afegides correctament"
            print
        except Exception:
            print "Error en afegir les dades"
    con.close()


def comprova(i):

    d=""

    for c in i:

        if c in string.digits:
            d=d+c
        elif c==".":
            d=d+c
        elif c==" ":
            d=d+c
        elif c not in string.ascii_letters:
            d=d+"@"
        else:
            d=d+c
    return d

def comprova2(i):

    d=""

    for c in i:

        if c==".":
            pass
        elif c in string.digits:
            d=d+c       
    return d


def consulta1():
    con = lite.connect('barcelona.db')
    with con:
        
        cur = con.cursor()
        cur.execute("select barris, max(poblacio) as Poblacio_barri from densitat")
        print "Barris\t\t\t\t\t\tPoblacio_barri"
        print "------\t\t\t\t\t\t--------------"
        while True:
            row = cur.fetchone()
            if row == None:
                break
            else:
                print row[0],"\t","\t",row[1]

    con.close()

def consulta2():
    con = lite.connect('barcelona.db')
    with con:
        
        cur = con.cursor()
        cur.execute("select barris, max(total) as Defuncio_barri from defuncions")
        print "Barris\t\t\t\tDefuncio_barri"
        print "------\t\t\t\t--------------"
        while True:
            row = cur.fetchone()
            if row == None:
                break
            else:
                print row[0],"\t","\t",row[1]

    con.close()

def consulta3():
    con = lite.connect('barcelona.db')
    with con:
        
        cur = con.cursor()
        cur.execute("select densitat.barris,densitat.densitat,defuncions.total from densitat,defuncions where densitat.barris=defuncions.barris order by defuncions.total")
        print "Barris\t\t\t\t\tDensitat\tTotal_defuncions"
        print "------\t\t\t\t\t--------\t----------------"
        while True:
            row = cur.fetchone()
            if row == None:
                break
            else:
                print row[0][0:14],"\t","\t","\t","\t",row[1],"\t","\t",row[2]

    con.close()

def consulta4():
    con = lite.connect('barcelona.db')
    with con:
        
        cur = con.cursor()
        cur.execute("select densitat.dte as Departament,sum(densitat.poblacio) as Total_poblacio,sum(defuncions.total) as Total_defuncions, sum(defuncions.homes) as Defuncions_homes, sum(defuncions.dones) as Defuncions_dones from densitat,defuncions where densitat.dte=defuncions.dte and densitat.barris=defuncions.barris group by densitat.dte")
        print "Departament\tTotal_poblacio\tTotal_defuncions\tDefuncions_homes\tDefuncions_dones"
        print "-----------\t--------------\t----------------\t----------------\t----------------"
        while True:
            row = cur.fetchone()
            if row == None:
                break
            else:
                print row[0],"\t","\t",row[1],"\t","\t",row[2],"\t","\t","\t",row[3],"\t","\t","\t",row[4]

    con.close()


def repteSocial():
    print "____________________________________"
    print "Benvingut al Repte Social"
    print 
    print "Entri la comanda <help> per coneixer les ordres"
    print

    if 'barcelona.db' in os.listdir(sys.path[0]):
        base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
        while (True):
            if str.upper(base) == "S":
                break           
            elif str.upper(base) == "N":
                crear_taula1()
                crear_taula2()
                print "Base de dades creada"
                print
                break
            else:
                print "Entri s/n"
            base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
    else:
        crear_taula1()
        crear_taula2()
        print "Base de dades creada"
        print
        
    d = raw_input("Entri comanda: ")
    s = str.split(d," ")
    while(s[0]!="surt"):
        if s[0]=="help":
            print
            print "--------------------------------------------------"
            print
            print "Benvingut al Repte Social"
            print
            print "afegir_dades1: Afegeix dades a la taula DEFUNCIONS" 
            print "afegir_dades2: Afegeix dades a la taula DENSITAT"
            print "consulta1: Consulta el barri amb mes poblacio "
            print "consulta2: Consulta el barri amb mes defuncions "
            print "consulta3: Consulta la densitat i el nombre total de defuncions ordenat per el nombre de defuncions"
            print "consulta4: Consulta la poblacio total i defuncions per a cada departament"
            print "surt"
            print
            print "---------------------------------------------------"
            print
        
        elif s[0]=="afegir_dades1":
            afegir_dades1()
        elif s[0]=="afegir_dades2":
            afegir_dades2()
        elif s[0]=="consulta1":
            consulta1()
        elif s[0]=="consulta2":
            consulta2()
        elif s[0]=="consulta3":
            consulta3()
        elif s[0]=="consulta4":
            consulta4()
        else:
            print "Ordre no trobada"            
        d=raw_input("Entri comanda: ")
        s=str.split(d," ")


repteSocial()
