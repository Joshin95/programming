#!/usr/bin/env python
# -*- coding: utf-8 -*-

def desbloqueig():
    pin=1234
    puk=123456789
    a=input("Entri el codi PIN: ")
    i=1
    j=1
    b=0
    while i<3 and a!=pin:
        print "Codi PIN incorrecte!"
        print "Li queden" ,3-i ,"intents"
        print "Torni a escriu el codi PIN."
        a=input("Entri el codi PIN: ")
        i+=1
    if a==pin:
        print "SIM desbloquejada"
    elif i==3:
        print "SIM bloquejada"
        b=input("Entri el codi PUK: ")
        while j<5 and b!=puk:
            print "Codi PUK incorrecte!"
            print "Li queden" ,5-j ,"intents"
            print "Torni a escriure el codi PUK"
            b=input("Entri el codi PUK: ")
            j+=1
        if b==puk:
            print "SIM desbloquejada"
        elif j==5:
            print "Targeta SIM bloquejada definitivament, posa't en contacte amb el teu operador de la xarxa"

desbloqueig()        

    
    
