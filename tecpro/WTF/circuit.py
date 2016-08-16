=======
Circuit
=======
=
from component import component
class circuit(object):
    def __init__(self):
        self._components=[]
    def afegirComponent(self,c):
        """
        Aquest metode el que fa es afegir un component al circuit
        """
        self._components.append(c)
    def dadesCircuit(self):
        """
        El metode retorna tots els components del circuit
        """
        for c in self._components:
            return c.toString()
    def preu(self):
        """
        El metode retorna el preu total de tots els elements del circuit
        """
        return sum([component.getpreu() for component in self._components])
    def numeroElements(self):
        """
        El metode retorna el numero total d'element
        """
        count=0
        for c in self._components:
            count+=1
        return count
