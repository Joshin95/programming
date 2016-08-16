#!/usr/bin/env python
# -*- coding: utf-8 -*-
def comprovaPIN(a,b,p):
    """
    Et dona tres intents per esciure el code PIN correcte
    
    >>> comprovaPIN(1,1234,1234)
    False
    >>> comprovaPIN(2,1235,1234)
    True
    >>> comprovaPIN(4,1234,1234)
    False
    >>> comprovaPIN(5,1236,1234)
    False
    """
    
    return a<3 and b!=p
def comprovaPUK(c,d,m):
    """
    Et dona cinc intents per esciure el code PUK correcte
    
    >>> comprovaPUK(1,123456789,123456789)
    False
    >>> comprovaPUK(2,123456787,123456789)
    True
    >>> comprovaPUK(6,123456789,123456789)
    False
    >>> comprovaPUK(7,123456798,123456789)
    False
    """
    return c<5 and d!=m
def desbloqueig():
    """
    Gestiona el desbloqueig correcte de la tarjeta SIM
    """
    pin=1234
    puk=123456789
    a=input("Entri el codi PIN: ")
    i=1
    j=1
    b=0
    while comprovaPIN(i,a,pin):
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
        while comprovaPUK(j,b,puk):
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
