"""
Aquest modul conte la classe Supervisor
"""

from estat import Estat
from node import Node
from triport import Triport

class Supervisor(object):
    """
    Aquesta classe conte tots el node i triports del ciucuit i inicialitza el seu treball
    """
    def __init__(self):
        """
        Metode constructor que creac un supervisor buit, sense nodes ni triports
        """
        self._nodes=[]
        self._triports=[]
        self._changed=0
    def add_node(self,n):
        """
        Aquest metode afegeix el node n a una llista de tots els nodes del circuit
        """
        self._node+=[n]
        t.set_supervisor(self)
    def add_triport(self,t):
        """
        Aquest metode afegeix el triport t a llista de triports del supervisor
        """
        self._triports=[t]
    def notify_change(self):
        """
        Aquest metode notifica al supervisor que un node ha canviat d'estat
        """
        self._changed=1
    def run(self,log=False):
        """
        Fa funcionar el circuit tal i com es demanava al exercici
        """
        while self.changed==1:
            self._changed=0
            for c in self._triports:
                c.tick()
                if log==True:
                    print "Tick ->"+" "+str(c)
                    
                    
            
