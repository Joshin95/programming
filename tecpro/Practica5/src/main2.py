from node import Node,Entrada,Sortida
from triport import Or,And
from supervisor import Supervisor


#definició de les entrades
e1=Entrada("E1")
e2=Entrada("E2")
e3=Entrada("E3")

#definició de la sortida
s=Sortida("S1")

#definició circuit
n1=Node("N1")
o1=Or(e1,e2,n1)
o2=And(n1,e3,s)

#creació del supervisor
sup=Supervisor()
sup.add_node(n1)
sup.add_triport(o1)
sup.add_triport(o2)

#valor entrades i simualció
e1.down()
e2.up()
e3.up()
sup.run(True)

#resultats
print s
