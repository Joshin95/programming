class component(object):
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
    
    
