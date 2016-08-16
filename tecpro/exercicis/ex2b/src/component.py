"""
Aquest modul crea components i les seves caracteristiques
"""


class component(object):
    """
    Aquesta classe te com a objectiu dissenyar cada component per separat per despres combinar-los en un circuit
    """
    def __init__(self,nom,preu,pes):
        self._nom=nom
        self._preu=preu
        self._pes=pes
    def getId(self):
        """
        El metode retorna el nom del component
        """
        return self._nom
    def setPreu(self,preunou):
        """
        El metode estableix el preu a un component
        """
        self._preu=preunou
    def toString(self):
        """
        El metode retorna el component amb la seva informacio
        """
        return str(self._nom)+" "+str(self._preu)+" "+str(self._pes)
    
    
