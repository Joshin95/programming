#!/usr/bin/env python
# -*- coding: utf-8 -*-

from eol8182 import *

def menu():
    print "Benvingut al gestor de grups per al projecte del curs"
    print "1.Afegir alumne"
    print "2.Afegir grup"
    print "3.Llistar tots els grups"
    print "4.Avaluar projectes"
    print "5.Borrar alumne"
    print "6.Guardar dades a un fitxer"
    print "7.Obtenir dades des d'un fitxer"
    print "8.Càlcul de la mitjana de les notes"
    print "0.Sortir"
d={}
e={}
menu()
x=input("Tria una opció: ")
while x!=0:
    if x==1:
        alumne(d)
    elif x==2:
        grup(d,e)
    elif x==3:
        llistarGrup(e)
    elif x==4:
        e=nota(e)
    elif x==5:
        borrarAlumne(d,e)
    elif x==6:
        guardaralumnes2(d)
        guardargrup(e)
    elif x==7:
        d=llegirDiscAlumnes()
        e=llegirDiscgrups()
    elif x==8:
        print mitjana(e)
   
    menu()
    x=input("Tria una opció: ")
print "Fi del programa"
