def escriun(t):
    parell=0
    i=1
    while i<=t:
        print parell
        parell+=2
        i+=1


def suman(k):
    suma=0
    i=1
    while i<=k:
        suma+=i
        i+=1
    return suma

def menu():
    print "Calculador de N"
    print "1.Escriure els N primers parells"
    print "2.Escriure el sumatori de N"
    print "0.Sortir"

x=10

while x!=0:
    menu()    
    x=input("Introdueixi opcio: ")
    if x==1:
        t=input("Posa la quantitat de numeros que vols saber: ")
        print escriun(t)

    elif x==2:
        k=input("Posa la quantita de numeros que vols sumar: ")
        print suman (k)

    elif x==0:
        print "Fi del programa"
        
    else: print "Posa l'opcio correcte (1/2/0)"

