#!/usr/bin/env python
# -*- coding: utf-8 -*-

def resultat(a):
    print "El resultat es: ", a

def multn(n):
    resultat(n*1)
    resultat(n*2)
    resultat(n*3)

multn(4)
multn("A")


print "Aquest programa te 10 línies (sense contar els meus canvis) i després de la execució mostra una cosa així:"
print "El resultat es:  4" 
print "El resultat es:  8" 
print "El resultat es:  12" 
print "El resultat es:  A" 
print "El resultat es:  AA" 
print "El resultat es:  AAA"
