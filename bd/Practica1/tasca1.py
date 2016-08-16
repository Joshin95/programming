import os              #si entres malament algo no va ex: matricula mes de 7

f = open("dades.dat","w")
for i in range(1001):
    f.write("XXXXXXX")
f.close()

def entrarcotxe(posicio,matricula):
    f = open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if not x:
        if auxconsulta(posicio):
            f.seek(7*posicio)
            f.write(matricula)
            print posicio,"FULL", matricula
        else:
            print "La placa ja esta ocupada"
    else:
        print "El cotxe ja esta al parking"
    f.close()
        
def ocuparprimera(matricula):
    f=open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if not x:
        for i in range(1001):
            f.seek(7*i)
            if f.read(7) == "XXXXXXX":
                f.seek(7*i)
                f.write(matricula)
                print i,"FULL", matricula
                break
    else:
        print "El cotxe ja esta al parking"
    f.close()

def sortir(matricula):
    f=open("dades.dat","r+")
    x,y=auxbusca(matricula)
    if x:
        for i in range(1001):
            f.seek(7*i)
            if f.read(7) == matricula:
                f.seek(7*i)
                f.write("XXXXXXX")
                print i,"EMPTY"
                break
    else:
        print "Cotxe no trobat"
        
def consulta(posicio):
    if auxconsulta(posicio):
        print "Placa lliure"
    else:
        print "Placa ocupada"

def auxconsulta(posicio):
    f = open("dades.dat","r+")
    f.seek(7*posicio)
    if f.read(7) == "XXXXXXX":
        u=True
    else:
        u=False
    f.close()
    return u

def placesbuides():
    f=open("dades.dat","r+")
    for i in range(1001):
        f.seek(7*i)
        if auxconsulta(i):
            print i,
    f.close()
    print "\n"

def auxbusca(matricula):
    f=open("dades.dat","r+")
    for i in range(1001):
        f.seek(7*i)
        if f.read(7) == matricula:
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
    f.close()

def printfitxer():
    os.system("cat dades.dat")
    print "\n"


def parking():
    print "____________________________________"
    print "Benvingut al gestor del parking"
    print 
    print "Entri la comanda <help> per coneixer les ordres"
    print
    d=raw_input("Entri comanda: ")
    s=str.split(d," ")
    while(s[0]!="surt"):
        if s[0]=="help":
            print
            print "--------------------------------------------------"
            print
            print "Benvingut al parking"
            print
            print "entrarcotxe <posicio> <matricula>"
            print "ocuparprimera <matricula>"
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
            if len(s) < 3:
                print "Falten parametres"
            else:
                entrarcotxe(int(s[1]),s[2])
        elif s[0]=="ocuparprimera":
            if len(s) < 2:
                print "Falten parametres"
            else:
                ocuparprimera(s[1])
        elif s[0]=="ocuparprimera":
            if len(s) < 2:
                print "Falten parametres"
            else:
                ocuparprimera(s[1])
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


