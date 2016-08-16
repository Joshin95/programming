"""
El modul ajunta tots els components creats
"""

from component import component
class circuit(object):
    """
    Aquesta classe to com a objectiu controlar el conjunt de components d'un circuit
    """
    def __init__(self):
        self._components=[]
    def afegirComponent(self,c):
	"""
	El metode afegeix component de nom 'c'
	"""
        self._components.append(c)
    def dadesCircuit(self):
	"""
	El metode retorna el nom de cada component
	"""
        for c in self._components:
            return c.toString()
    def preu(self):
	"""
	El metode retorna el preu total dels components
	"""
        return sum([component.getpreu() for component in self._components])
    def numeroElements(self):
	"""
	El metode retorna el numero total d'elements
	"""
        count=0
        for c in self._components:
            count+=1
        return count
