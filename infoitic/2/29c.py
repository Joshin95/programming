import math

t=input("Posa el temps d'oscilacio del pendol: ")

def llargada(t):
    return (t**2/(2**2*math.pi**2))*9.81

l=llargada(t)

if l==0:
    print "La llargada del pendol es d'",l ,"metre"
else:  print "La llargada del pendol es de" ,l ,"metres" 
