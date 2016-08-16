# -*- encoding: utf-8 -*-

from node import *

class Supervisor (object):

    def __init__(self):
        """
        Constructor. Crea un supervisor buit, sense nodes ni triports.
        """
        self._nodes=[]
        self._triports=[]
        self._changed = False

    def add_node(self, n):
        """
        Afegeix el node n a la llista de nodes controlats pel supervisor. Addicionalment, s'informa al node a traves del seu metode set_supervisor de qui es el seu supervisor.
        >>> nodes=[]
        >>> n1=1
        >>> n2=1
        >>> nodes.append(n1)
        >>> nodes.append(n2)
        >>> print nodes
        [1, 1]
        """
        self._nodes.append(n)
        n.set_supervisor(self)

    def add_triport(self,t):
        """
        Afegeix el triport t a la llista de triports controlats pel supervisor.
        >>> triports=[]
        >>> t1=1
        >>> t2=1
        >>> t3=1
        >>> triports.append(t1)
        >>> triports.append(t2)
        >>> triports.append(t3)
        >>> print triports
        [1, 1, 1]
        """
        self._triports.append(t)
        t.set_supervisor(self)

    def notify_change(self):
        """
        Notifica al supervisor que un node ha canviat d'estat. Principalment es utilitzada pels nodes.
        """
        self._changed = True

    def run (self, log=False):
        """
        Fa funcionar el circuit aplicant l'estrategia que s'ha explicat previament. Si log es True llavors escriu per la pantalla un missatge cada vegada que provoca un tick en un triport seguint el seguent esquema:
        Tick -> <Representacio del triport>
        """
        log = True
        self._changed = True
        while self._changed:
            self._changed = False
            for elements in self._triports:
                element.tick()
                if log:
                    print "Tick ->" + repr(element)
