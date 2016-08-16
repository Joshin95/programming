from circuit import circuit
from component import component

c=Component(22,430,150)
print c.toString()
c2=Component(10,500,10)
print c2.toString()
d=Circuit()
d.afegirComponent(c)
d.afegirComponent(c2)
print d.preu()
print dadesCircuit()
pritn d.numeroElements()
