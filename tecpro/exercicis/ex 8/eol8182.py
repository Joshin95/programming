#!/usr/bin/env python
# -*- coding: utf-8 -*-

def alumne(d):
    """
    Permet crear el diccionari d i afegir-li dades
    """
    nom=raw_input("Escriu el nom del alumne: ")
    cognom=raw_input("Escriu els cognoms del alumne: ")
    if d.has_key((nom,cognom))==False:
        d[(nom,cognom)]=""
    else:
        print "L'alumne ja s'ha donat d'alta previament"
    return d
    
def grup(d,e):
    """
    Permet crear el diccionari e i afegir-li dades
    """
    s=[]
    grup=raw_input("Escriu el nom del grup: ")
    if e.has_key(grup)==False:
        q="S"
        while q=="S":
            p=raw_input("Escriu el nom de l'alumne que vols afegir al grup: ")
            k=raw_input("Escriu el cognom de l'alumne que vols afegir al grup: ")       
            if not d.has_key((p,k)):
                print "L'alumne no existeix"
            else:
                if len(d[(p,k)])==0:
                    d[(p,k)]=grup
                    s+=[(p,k)]
                    e[grup]=s
                   
                else:
                    print "L'alumne ja està en un grup"              
                
            q=raw_input("Vols afegir més alumnes? S/N: ")
            q=q.upper()
        
            
               
           
    else:
        print "El grup ja existeix"
    if len(e[grup])>=1:
        t=raw_input("Escriu el títol del projecte: ")
        
    elif len(d[grup])==0:
        del e[grup]
    
    e[grup]+=[t]
    e[grup]+=[-10]
    print d
    print e
    return d,e

def llistarGrup(e):
    """
    Escriu per pantalla tots els grups donats d'alta previament
    """
    for c in e.keys():
        print c
def nota(e):
    """
    Permet afegir un valor numèric a la llista del diccionari e
    """
    g=raw_input("Escriu el nom del grup que vols avaluar: ")
    n=raw_input("Escriu la nota del projecte: ")
    if e.has_key(g):
        e[g][-1]=n
    else:
        print "El grup no existeix"
    return e
def borrarAlumne(d,e):
    """
    Permet eliminar un element de dins de la llista dels dos diccionaris, i si la llista del diccionari e queda buida s'elimina la clau corresponent.
    """
    r=[]
    n=raw_input("Posa el nom d'alumne que vols donar de baixa: ")
    c=raw_input("Posa el cognom d'alumne que vols donar de baixa: ")
    h=raw_input("Segur que vols donar de baixa aquest alumne? S/N  ")
    q=raw_input("Has avaluat ja el projecte? S/N ")
    g=d[(n,c)]
    if d.has_key((n,c)):    
        if h.upper()=="S":
            for grup,alumnes in e.items():
                for f in alumnes:
                    if f!=tuple([n,c]):
                        r+=[f]
            e[d[n,c]]=r
            print "Alumne eliminat del grup"
        for grup,alumnes in e.items():
            if q.upper()=="S":
                if len(alumnes)==2:
                    print "Grup eliminat"
                    del e[g]
            if q.upper()=="N":
                if len(alumnes)==1:
                    print "Grup eliminat"
                    del e[g]
        del d[(n,c)]
        print "Alumne eliminat"
    else:
        print "L'alumne no existeix"
    print e
    print d
    return e,d

def guardaralumnes2(d):
    """
    Guarda en un fitxer les dades del diccionari d
    """
    fd=raw_input("Escriu el nom de fitxer on vols guardar els alumnes: ")
    fid=open(fd+".txt","w")
    for k,v in d.items():
        for c in k:
            fid.write(str(c)+"_")
        fid.write(str(v)+"_")
        fid.write("\n")
    fid.close()
    print "El fitxer s'ha guardat correctament"
def guardargrup(e):
    """
    Guarda en un fitxer les dades del diccionari e
    """
    fe=raw_input("Escriu el nom de fitxer on vols guardar els grups: ")
    fie=open(fe+".txt","w")
    for k,v in e.items():
        fie.write(str(k)+"_")
        
        for component in v[:-2]:
            for c in component:
                fie.write(str(c)+" ")
            fie.write("_")
        fie.write(str(v[-2]))
        fie.write("_"+str(v[-1]))
        fie.write("\n")
    fie.close()
    print "El fitxer s'ha guardat correctament"

def llegirDiscAlumnes():
    """
    Obte les dades d'un fitxer per al diccionari d
    """
    d={}
    f=raw_input("Escriu el nom del fitxer que conte les dades dels alumnes: ")
    w=open(f+".txt","r")
    for c in w:
        m=c.split("_")
        d[(m[0],m[1])]=[]
        for j in m[2:-1]:
            d[(m[0],m[1])]+=[j]
    return d
def llegirDiscgrups():
    """
    Obte les dades d'un fitxer per al diccionari e
    """
    e={}
    s=[]
    f=raw_input("Escriu el nom del fitxer que conte les dades dels grups: ")
    w=open(f+".txt","r")
    for c in w:
        m=c.split("_")
        e[m[0]]=[]
        for j in m[1:-1]:
            e[m[0]]+=[j]
        e[m[0]]+=[m[-1].strip()]
            
    for k,v in e.items():
        for q in v[0:3]:
            p=q.split(" ")
            o=(p[0],p[1])
            s+=[o]
        s+=v[3:]   
    e[m[0]]=s
    return e
        
    
def mitjana(e):
    """
    retorna la mitjana de les notes dels projectes
    """
    f=0
    p=0
    z=0
    for k,v in e.items():
        x=float(v[-1])
        if x!=-10:
            p+=x
            f+=1
    z=float(p)/f
    return z 
