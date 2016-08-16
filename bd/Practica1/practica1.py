import os
import sys                 #si entro alguna cosa malament no va. HEEECHO
import struct              #exemple: matricula mes gran de 7 HEEEEEECHO
import string              #fitxer quan sortim es borra i es sobrescriu HEEEECHO
                           #Comprovar si existeix fitxer, sino donar nomes opcio de crearlo. HEEEECHO


def crear_base():                     
    f = open("dades.dat","w")
    for i in range(1001):    
        f.write(struct.pack("7s9s10s",7*"X",9*"X",10*"X"))
    f.close()

def entrarcotxe(posicio,matricula,color,marca):
    f = open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if len(matricula) == 7:
        if len(color) <= 9:
            if len(marca) <= 10:
                if not x:
                    if auxconsulta(posicio):
                        f.seek(26*posicio)
                        f.write(struct.pack("7s9s10s",matricula,color,marca))
                        print posicio,"FULL", matricula, color, marca
                    else:
                        print "La placa ja esta ocupada"
                else:
                    print "El cotxe ja esta al parking"
            else:
                print "Nom de marca massa llarg"
        else:
            print "Nom de color massa llarg"
    else:
        print "Matricula incorrecte"
    f.close()
        
def ocuparprimera(matricula,color,marca):
    f=open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if len(matricula) == 7:
        if len(color) <= 9:
            if len(marca) <= 10:
                if not x:
                    for i in range(1001):
                        if auxconsulta(i):
                            f.seek(26*i)
                            f.write(struct.pack("7s9s10s",matricula,color,marca))
                            print i,"FULL", matricula, color, marca
                            break
                        else:
                            print "El cotxe ja esta al parking"
                else:
                    print "El cotxe ja esta al parking"
            else:
                print "Nom de marca massa llarg"
        else:
            print "Nom de color massa llarg"
    else:
        print "Matricula incorrecte"
        
    f.close()

def sortir(matricula):
    f=open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if x:
        f.seek(26*y)
        f.write(struct.pack("7s9s10s",7*"X",9*"X",10*"X"))
        print y,"EMPTY"
            
    else:
        print "Cotxe no trobat"
        
def consulta(posicio):
    if auxconsulta(posicio):
        print "Placa lliure"
    else:
        print "Placa ocupada"

def auxconsulta(posicio):
    f = open("dades.dat","r+")
    f.seek(26*posicio)
    a=struct.unpack("7s9s10s",f.read(26))
    if a[0] == "XXXXXXX":
        u=True
    else:
        u=False
    f.close()
    return u

def placesbuides():
    f=open("dades.dat","r+")
    for i in range(1001):
        if auxconsulta(i):
            print i,
    f.close()
    print "\n"

def auxbusca(matricula):
    f=open("dades.dat","r+")
    for i in range(1001):
        f.seek(26*i)
        a=struct.unpack("7s9s10s",f.read(26))
        if a[0] == matricula:
            o=True
            break
        else:
            o=False
    f.close()
    return o,i
    
def buscarcotxe(matricula):
    x,y=auxbusca(matricula)
    if x:
        print "El cotxe amb matricula",matricula, "es troba a la posicio",y 
    else:
        print "No es troba al parking"

def printfitxer():
    os.system("cat dades.dat")
    print "\n"


def parking():
    print "____________________________________"
    print "Benvingut al gestor del parking"
    print 
    print "Entri la comanda <help> per coneixer les ordres"
    print

    if 'dades.dat' in os.listdir(sys.path[0]):
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
            print "entrarcotxe <posicio> <matricula> <color> <marca>"
            print "ocuparprimera <matricula> <color> <marca>"
            print "sortir <matricula>"
            print "consulta <posicio>"
            print "placesbuides"
            print "buscarcotxe <matricula>"
            print "printfitxer"
            print "surt"
            print
            print "---------------------------------------------------"
            print
        
        elif s[0]=="entrarcotxe":
            if len(s) < 5:
                print "Falten parametres"
            else:
                entrarcotxe(int(s[1]),s[2],s[3],s[4])
        elif s[0]=="ocuparprimera":
            if len(s) < 4:
                print "Falten parametres"
            else:
                ocuparprimera(s[1],s[2],s[3])
        elif s[0]=="sortir":
            if len(s) < 2:
                print "Falten parametres"
            else:
                sortir(s[1])
        elif s[0]=="consulta":
            if len(s) < 2:
                print "Falten parametres"
            else:
                consulta(int(s[1]))
        elif s[0]=="placesbuides":
            placesbuides()
        elif s[0]=="buscarcotxe":
            if len(s) < 2:
                print "Falten parametres"
            else:
                buscarcotxe(s[1])
        elif s[0]=="printfitxer":
            printfitxer()
        else:
            print "Ordre no trobada"            
        d=raw_input("Entri comanda: ")
        s=str.split(d," ")



parking()



