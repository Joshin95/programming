import math

x=input("Escriu la quantitat del capital diponible: ")
y=input("Escriu l'interes per any en tan per cent: ")
z=input("Escriu els anys de repos del capital: ")

def conte(x):
    return x*y/100*z

i=conte(x)

r=i+x

if z==1:
    print "Despres de" ,z ,"any trindras" ,r ,"euros"
elif z>1:
    print "Despres de" ,z ,"anys trindras" ,r ,"euros"
else: print "Posa un numero d'anys correcte"

