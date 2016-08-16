import os           
import struct             
import string             
import sqlite3 as lite
import sys

def crear_base():                     
    try:
        con = lite.connect('parking.db')
        
        cur = con.cursor()  
    
        cur.executescript("""
        DROP TABLE IF EXISTS PARKING;
        CREATE TABLE PARKING(
        MATRICULA VARCHAR(10) PRIMARY KEY NOT NULL,
        POSICIO INT NOT NULL,
        MARCA VARCHAR(15) NOT NULL,
        COLOR VARCHAR(10) DEFAULT NULL,
        ENTRADA DATE DEFAULT CURRENT_DATE,
        UNIQUE (POSICIO));
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

def entrarcotxe():
    con = lite.connect('parking.db')
    Matricula=raw_input("Entra la matricula: ")
    Posicio=input("Entra la posicio: ")
    Marca=raw_input("Entra la marca: ")
    Color=raw_input("Entra el color: ")

    with con:

        cur = con.cursor()    
        try: 
            cur.execute("INSERT INTO PARKING (MATRICULA,POSICIO,MARCA,COLOR) VALUES (?,?,?,?);", (Matricula, Posicio, Marca, Color))        
            con.commit()
        except Exception:
            print "Entrada del cotxe erronia"

    con.close()

def consulta_pos():
    con = lite.connect('parking.db')
    posicio=input("Entra posicio a consultar: ")
    with con:
        
        cur = con.cursor()    
        
        cur.execute("SELECT * FROM PARKING WHERE POSICIO=?", (posicio,))       
       
        row = cur.fetchone()
        
        if row == None:
            e=True
        else:
            print row[0],row[1],row[2],row[3],row[4]
            e=False
    con.close()
    return e

def consulta():
    con = lite.connect('parking.db')
    consulta=raw_input("Que vols consultar? (matricula/posicio/color/marca) ")
    with con:
        
        cur = con.cursor()    
        if consulta=="matricula":
            matricula=raw_input("Entri la matricula: ")
            cur.execute("SELECT * FROM PARKING WHERE MATRICULA=?", (matricula,))       
            row = cur.fetchone()
        
            if row == None:
                print "La matricula no existeix"
                e=True
            else:
                print row[0],row[1],row[2],row[3],row[4]
                e=False

        elif consulta=="posicio":
            posicio=input("Entri la posicio: ")
            cur.execute("SELECT * FROM PARKING WHERE POSICIO=?", (posicio,))       
            row = cur.fetchone()
            
            if row == None:
                print "La posicio no esta ocupada"
                e=True
            else:
                print row[0],row[1],row[2],row[3],row[4]
                e=False
            
        elif consulta=="color":
            color=raw_input("Entri el color: ")
            cur.execute("SELECT * FROM PARKING WHERE COLOR=?", (color,))       
            row = cur.fetchone()
            
            if row == None:
                print "No hi ha cap cotxe daquest color"
                e=True
            else:
                print row[0],row[1],row[2],row[3],row[4]
                e=False

        elif consulta=="marca":
            model=raw_input("Entri la marca: ")
            cur.execute("SELECT * FROM PARKING WHERE MARCA=?", (model,))       
            row = cur.fetchone()
        
            if row == None:
                print "No hi ha cap cotxe daquesta marca"
                e=True
            else:
                print row[0],row[1],row[2],row[3],row[4]
                e=False
        
        else:
            e=True
            print "Consulta erronea"

    con.close()
    return e

def buscarcotxe():
    con = lite.connect('parking.db')
    mat=raw_input("Entra matricula a buscar: ")
    with con:
        
        cur = con.cursor()    
        
        cur.execute("SELECT * FROM PARKING WHERE MATRICULA=?", (mat,))       
       
        row = cur.fetchone()
        
        if row == None:
            print "El cotxe no es troba al parking"
        else:
            print "El cotxe amb matricula",mat,"es troba a la posicio", row[1]
            
    con.close()

def sortir():
    con = lite.connect('parking.db')
    mat=raw_input("Entra cotxe per sortir: ")
    with con:
        cur = con.cursor() 
        cur.execute("SELECT * FROM PARKING WHERE MATRICULA=?", (mat,)) 
        row = cur.fetchone()
        if row == None:
            print "El cotxe no es troba al parking"
        else:
            cur.execute("DELETE FROM PARKING WHERE MATRICULA=?", (mat,)) 
            print "El cotxe ha sortit del parking"
    con.close()

def update():
    con = lite.connect('parking.db')
    mat=raw_input("Entra cotxe a modificar (Matricula): ")
    Posicio=input("Entra la nova posicio: ")
    Marca=raw_input("Entra la nova marca: ")
    Color=raw_input("Entra el nou color: ")
    with con:
        cur = con.cursor()    
        cur.execute("SELECT * FROM PARKING WHERE POSICIO=?", (Posicio,)) 
        row = cur.fetchone()
        
        if row == None:
            
            cur = con.cursor()    
            cur.execute("SELECT * FROM PARKING WHERE MATRICULA=?", (mat,)) 
            row = cur.fetchone()
            
            if row == None:
                print "El cotxe no es troba al parking"
            else:
                cur.execute("UPDATE PARKING SET POSICIO=?,MARCA=?,COLOR=? WHERE MATRICULA=?", (Posicio,Marca,Color,mat,))       
                print "El cotxe ha estat modificat"
        else:
            print "la posicio ja esta plena"
    con.close()

    

def parking():
    print "____________________________________"
    print "Benvingut al gestor del parking"
    print 
    print "Entri la comanda <help> per coneixer les ordres"
    print

    if 'parking.db' in os.listdir(sys.path[0]):
        base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
        while (True):
            if str.upper(base) == "S":
                break           
            elif str.upper(base) == "N":
                crear_base()
                print "Base de dades creada"
                print
                break
            else:
                print "Entri s/n"
            base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
    else:
        crear_base()
        print "Base de dades creada"
        print
        
    d = raw_input("Entri comanda: ")
    s = str.split(d," ")
    while(s[0]!="surt"):
        if s[0]=="help":
            print
            print "--------------------------------------------------"
            print
            print "Benvingut al parking"
            print
            print "entrarcotxe" 
            print "sortir"
            print "consulta"
            print "buscarcotxe"
            print "update"
            print "surt"
            print
            print "---------------------------------------------------"
            print
        
        elif s[0]=="entrarcotxe":
            entrarcotxe()
        elif s[0]=="sortir":
            sortir()
        elif s[0]=="consulta":
            consulta()
        elif s[0]=="buscarcotxe":
            buscarcotxe()
        elif s[0]=="update":
            update()
        else:
            print "Ordre no trobada"            
        d=raw_input("Entri comanda: ")
        s=str.split(d," ")



parking()

