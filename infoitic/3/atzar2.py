import random

a=input("1r nr")
b=input("2n nr")

def randomnr(x,y):
    return random.randint(x,y)

if a<=b:
    r=randomnr(a,b)
    dada=input("Entra el valor")
    if r==dada:
        print "has endevinat"
    elif dada>r:
        print "el nombre era inferior" ,r
    else: print "el nombre era superior" ,r    
else: print "rang de limits erroni"
