#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math

def supCercle(r):
        return math.pi*math.pow(r,2)

print "Càlcul de la superfície d'un cercle"
z=input("Introdueix valor del radi: ")
print "La superfície és: " ,supCercle(z)

