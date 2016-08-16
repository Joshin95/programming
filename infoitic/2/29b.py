import math

v=input("Escriu la velocidad de sortida del projectil: ")
a=input("Escriu l'angle de sortida del projectil: ")

vx=v*math.cos(a)
vy=v*math.sin(a)

def temps(vy):
    return vy/4.905
    
t=temps(vy)

def rec(vx):
    return vx*t

x=rec(vx)

print "El temps que ha tardat el projectil a caure son" ,t ,"segons" ,"i ha recorregut" ,x ,"metres"
