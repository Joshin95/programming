def comp():
    x=input("posa el numero enter: ")
    a=input("posa el numero enter: ")
    b=input("posa el numero enter: ")
    c=input("posa el numero enter: ")
    d=input("posa el numero enter: ")
    z=x
    
    if a>=x or a<x:
        z=a
    if abs(b)<abs(a):
        z=b
    if abs(c)<abs(a):
        z=c
    if abs(d)<abs(a):
        z=d

    print "El numero mes proper a" ,x ,"es" ,z

             
comp()
