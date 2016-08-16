import math

h=input ("Escriu l'alcada a quina es troba el cos en metres: ")

def alcada(h):
    x=math.sqrt(h/9.81)
    return x

t=alcada(h)

print "El cos tardara" ,t ,"segons"
