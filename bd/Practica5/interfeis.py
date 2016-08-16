from Tkinter import *
from multi import *
#from agenda import *
import sqlite3 as lite
import tkFileDialog
import os

#EL MODIFICAR ESTA MALAMENT, SHA DE MIRAR MES BE COM FERLO

#EL MSG NO VA, NO SE PK NO LACTUALITZA, he mirat el valor de msg i es correcte, falta k ho mostri a la label

#tot l'ho altre en teoria va dpm

def crear_taula():                     
    try:
        con = lite.connect('agenda.db')
        
        cur = con.cursor()  
    
        cur.executescript("""
        DROP TABLE IF EXISTS AGENDA;
        DROP TABLE IF EXISTS DADES;
        CREATE TABLE AGENDA(
        USUARI VARCHAR(50) NOT NULL,
        TELEFON VARCHAR(15) NOT NULL,
        PRIMARY KEY (USUARI,TELEFON),
        FOREIGN KEY (USUARI) REFERENCES DADES(USUARI));
        
        CREATE TABLE DADES(
        USUARI VARCHAR(50) NOT NULL PRIMARY KEY,
        EMAIL VARCHAR(50),
        IMAGE VARCHAR(50));
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



def seleccio():
    return int(seleccionat.curselection()[0])

def afegir():

    #global msg

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()    
        
        try:
            cur.execute("INSERT INTO DADES(USUARI,EMAIL,IMAGE) VALUES (?,?,?);", ((nom.get(),None,None)))
            
            cur.execute("INSERT INTO AGENDA(USUARI,TELEFON) VALUES (?,?);", ((nom.get(),telefon.get())))

            con.commit()
            print msg.get()
            print "d===================================="
            msg.set("Contacte afegit")
            print msg.get()
        except Exception:
            msg.set("Error en afegir el contacte")
    con.close()
    actualitza()

def eliminar():

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()
        try:
            cur.execute("DELETE FROM AGENDA WHERE USUARI=? AND TELEFON=?",(seleccionat.get(seleccio())[0],seleccionat.get(seleccio())[1]))

            con.commit()
            print
            print "Dades eliminades correctament"
            print
            msg.set("Contacte eliminat")
        except Exception:
            msg.set("Error en eliminar el contacte")
    con.close()

    actualitza()

    
def modificar():

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()
        
        try:
           
            cur.execute("UPDATE AGENDA SET USUARI=?,TELEFON=? WHERE USUARI=? AND TELEFON=?", (nom.get(),telefon.get(),seleccionat.get(seleccio())[0],seleccionat.get(seleccio())[1])) 
            con.commit()
            print
            print "Dades modificades correctament"
            print
            msg.set("Contacte modificat")
        except Exception:
            msg.set("Error en modificar el contacte")
    con.close()

    actualitza()

def tancar(): 
    program.destroy()

def imprimir():

    llista=[]

    f = open('workfile.txt', 'w')
    f.write("NOM"+(30-len("NOM"))*" "+"TELEFON"+(30-len("TELEFON"))*" "+"\n")
    f.write("==="+(30-len("NOM"))*" "+"======="+(30-len("TELEFON"))*" "+"\n\n")
    
    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()    
        try:

            cur.execute("SELECT * FROM AGENDA;")
            seleccionat.delete(0,END)
            while True:
                row=cur.fetchone()
                if row==None:
                    break
                else:
                    llista.append(row)

            llista.sort()
            for c in llista:
                f.write(c[0]+(30-len(c[0]))*" "+c[1]+(30-len(c[1]))*" "+"\n\n")

            f.close()
            print "fet"
        except Exception:
            print "Error en afegir les dades"

    con.close()
    actualitza()

    
    
def interficie():
    global nom, telefon, seleccionat, msg

    root = Tk()
    root.title('GESTOR DE CONTACTES')

    myframe5 = Frame(root, bd=2, relief=SUNKEN)
    Button(myframe5, text="Eliminar seleccionat", fg="blue", command=eliminar).grid(row=0, column=0, sticky=E)
    Button(myframe5, text="Modificar seleccionat", fg="blue", command=modificar).grid(row=0, column=1, sticky=E)
    Button(myframe5, text="Imprimir", fg="blue", command=imprimir).grid(row=0, column=2, sticky=E)
    Button(myframe5, text="Sortir", fg="blue", command=tancar).grid(row=0, column=3, sticky=E)
    myframe5.pack(side = BOTTOM)


    myframe3 = Frame(root, bd=2, relief=SUNKEN)
    Label(myframe3, text='Contactes:').pack()
    scroll = Scrollbar(myframe3, orient=VERTICAL)
    seleccionat = MultiListbox(myframe3, (('NOM',30), ('TELEFON',30) ))
    #scroll.config (command=seleccionat.yview)
    #scroll.pack(side=RIGHT, fill=Y)
    #for line in [1,3,4]:
    #    seleccionat.insert(END, line)
    seleccionat.pack(fill=BOTH, expand=YES)
    myframe3.pack(side = BOTTOM)

    myframe4 = Frame(root, bd=2, relief=SUNKEN)
    Button(myframe4, text="Mostra contacte", fg="blue", width=10, command=mostrar).grid(sticky=E)
    msg=StringVar()
    msg.set("Agenda de contactes")
    Message(myframe4, textvariable=msg,width=1000,fg="red").grid(row=0, column=1)
    myframe4.pack(side = BOTTOM)


    myframe1 = Frame(root, bd=2, relief=SUNKEN)
    myframe1.pack(side=LEFT)

    Label(myframe1, text='Gestor de contactes v.1.1').pack()
    bitmap = BitmapImage(file="gir.xbm")
    mylabel = Label(myframe1,image=bitmap)
    mylabel.image = bitmap # keep a reference!
    mylabel.pack()

    myframe2 = Frame(root, bd=2, relief=SUNKEN)
    myframe2.pack(side = LEFT)

    Label(myframe2, text="Nou registre", fg="blue").grid(row=0)
    Label(myframe2, text="Nom",fg="blue").grid(row=1, sticky=W)
    nom=StringVar()
    Entry(myframe2, textvariable=nom).grid(row=1, column=1, sticky=E)
    
    Label(myframe2, text="Telefon",fg="blue").grid(row=2, sticky=W)
    telefon=StringVar()
    Entry(myframe2, textvariable=telefon).grid(row=2, column=1, sticky=E)
    Button(myframe2, text="Registrar",command=afegir,fg="blue").grid(row=3, column=1, sticky=E)
    mylabel.pack()
    return root

def actualitza():

    llista=[]

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()    
        try:

            cur.execute("SELECT * FROM AGENDA;")
            seleccionat.delete(0,END)
            while True:
                row=cur.fetchone()
                print row
                if row==None:
                    break
                else:
                    llista.append(row)

            llista.sort()
            for c in llista:
                seleccionat.insert(END,c)

            print "fet"
            msg.set("Agenda de contactes")
        except Exception:
            msg.set("Error mostrant agenda de contactes")
            print "Error en afegir les dades"

    con.close()

def get_mail():

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()
        try:
            cur.execute("SELECT EMAIL FROM DADES WHERE USUARI=?",(seleccionat.get(seleccio())[0],))

            con.commit()
            print
            print "Dades modificades correctament"
            print
            row=cur.fetchone()
        except Exception:
            print "Error"
    con.close()

    return row


def get_image():

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()
        
        cur.execute("SELECT IMAGE FROM DADES WHERE USUARI=?",(seleccionat.get(seleccio())[0],))
            
        con.commit()
        try:
            print
            print "Dades modificades correctament"
            print
            row=cur.fetchone()
        except Exception:
            print "Error"
    con.close()

    return row


def modificar_2():

    global path

    con = lite.connect('agenda.db')
    
    with con:
        
        cur = con.cursor()

        print email.get()
        print path
        print seleccionat.get(seleccio())[0]
        
        cur.execute("UPDATE AGENDA SET TELEFON=? WHERE USUARI=? AND TELEFON=?", (telefon2.get(),seleccionat.get(seleccio())[0],seleccionat.get(seleccio())[1])) 

        if path[0] != None:
            cur.execute("UPDATE DADES SET EMAIL=?,IMAGE=? WHERE USUARI=?", (email.get(),path,seleccionat.get(seleccio())[0]))
        else:
            cur.execute("UPDATE DADES SET EMAIL=?,IMAGE=? WHERE USUARI=?", (email.get(),None,seleccionat.get(seleccio())[0]))
            
        con.commit()
        try:
            print
            print "Dades modificades correctament"
            print
        except Exception:
            print "Error"
    con.close()

    actualitza()
    top.destroy()

def get_path_image():

    global path
    
    path=tkFileDialog.askopenfilename()

    print path
    

def mostrar():

    global email, telefon2, top, path
    
    path = ''
    
    top = Toplevel()
    
    top.title("Visualitzacio contacte")

    myframe10 = Frame(top)
    myframe10.pack(side = LEFT)

    
    path = get_image()
    print path[0]

    if path[0] != None:
        bitmap = BitmapImage(file=path)
        mylabel = Label(myframe10,image=bitmap)
        mylabel.image = bitmap # keep a reference!
        mylabel.pack()
    
    myframe11=Frame(top)
    myframe11.pack(side = RIGHT)

    Label(myframe11, text="Nom", fg="blue").grid(row=0, sticky=W)
    Message(myframe11, text=seleccionat.get(seleccio())[0],width=1000).grid(row=0, column=1)
    Label(myframe11, text="Telefon antic",fg="blue").grid(row=1, sticky=W)
    Message(myframe11, text=seleccionat.get(seleccio())[1],width=1000).grid(row=1, column=1)
    Label(myframe11, text="Telefon nou",fg="blue").grid(row=2, sticky=W)
    telefon2=StringVar()
    Entry(myframe11, textvariable=telefon2).grid(row=2, column=1, sticky=E)
    Label(myframe11, text="Email antic",fg="blue").grid(row=3, sticky=W)
    Message(myframe11, text=get_mail(),width=1000).grid(row=3, column=1)
    Label(myframe11, text="Email nou",fg="blue").grid(row=4, sticky=W)
    email=StringVar()
    Entry(myframe11, textvariable=email).grid(row=4, column=1, sticky=E)
    Label(myframe11, text="Imatge", fg="blue").grid(row=5, column=0, sticky=W)
    Button(myframe11, text='Selecciona imatge', command=get_path_image).grid(row=5, column=1, sticky=E)
    Button(myframe11, text="Modificar", command=modificar_2).grid(row=6, column=1)
    Button(myframe11, text="Tancar", command=top.destroy).grid(row=6, column=0)



if 'agenda.db' in os.listdir(sys.path[0]):
    base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
    while (True):
        if str.upper(base) == "S":
            break           
        elif str.upper(base) == "N":
            crear_taula()
            print "Base de dades creada"
            print
            break
        else:
            print "Entri s/n"
            base = raw_input("Vol mantenir la base de dades existent? (s/n): ")
else:
    crear_taula()
    print "Base de dades creada"
    print

    



program=interficie()
actualitza()
program.mainloop()
