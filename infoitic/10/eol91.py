#!/usr/bin/env python
# -*- coding: utf-8 -*-


def afegirUsuari(d):
    a=raw_input("Escriu el teu nom d'usuari: ")
    if d.has_key(a):
        b=raw_input("Escriu el teu nom complet: ")
        c=raw_input("Escriu el teu correu electrònic: ")
        t=raw_input("Escriu el teu número de telèfon: ")
        cl=raw_input("Escriu la teva paraula clau: ")
        d[a]=[b,c,cl]
    else:
        print "El nom d'usuari ja existeix"
    return d

def esborrarUsuari(d):
    bor=raw_input("Escriu el nom d'usuari que vols borrar: ")
    sn=raw_input("Segur que vols borrar?(s/n): ")
    if sn.upper()=="S":
        del d[bor]
    else:
        print "Has anulat l'operació"
    return d

def modificarUsuari(d):
    mod=raw_input("Escriu el nom d'usuari que vols modificar: ")
    print "1.Nom"
    print "2.Correu electrònic"
    print "3.Telèfon"
    print "4.Adreça"
    print "5.Paraula clau"
    o=input("Tria l'opció que vols modificar: ")
    

d={}
modificarUsuari(d)
