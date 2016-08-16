"""
Aquest modul conte les classes Node, Endrada i Sortida
"""

from estat import Estat
#from supervisor import Supervisor

class Node(object):
    """
    Aquesta classe imita el comportament d'un node d'un triport
    """
    def __init__(self,n):
        """
        Metode constructor que li dona un nom al node i l'inicialitza com a indefinit
        """
        self._e=Estat()
        self._n=n
        #self._s=Supervisor()
    def say(self,estat):
        """
        Aquest metode modifica l'estat del node i avisa al supervisor si ha hagut algun canvi del estat
        """
        #s=Supervisor()
        if self._e!=estat:
            self._e=estat
            #s.notify_change()
    def changeEstat(self,estat):
        """
        Aquest metode canvia l'estat del node
        """
        self._e=estat
    def ask(self):
        """
        Aquest metode retorna l'esatt actual del node
        """
        return self._e
    def set_supervisor(self,s):
        """
        Aquest metode informa al node de qui es el seu supervisor
        """
        #s=Supervisor()
        #self._s=s
    def __repr__(self):
        """
        Aquest metode especial retorna el nom del node amb el seu estat i supervisor
        """
        return "El node "+str(self._n)+" pren l'estat "+str(self._e)+" i el seu supervisor es "+str(self._s)

class Entrada(Node):
    """
    Aquesta classe hereta el atributs de la classe node i gestiona els seus estats
    """
    def up(self):
        """
        Aquest metode posa el node a estat alt (1)
        """
        self._e=1
    def down(self):
        """
        Aquest metode posa el node a estat baix (0)
        """
        self._e=0
    def undef(self):
        """
        Aquest metode posa el node a estat indefinit (-1)
        """
        self._e=-1
    def __repr__(self):
        """
        Aquest metode especial retorna el node, el seu estat i el seu supervisor
        """
        return  "El node "+str(self._n)+" es tracta d'una entrada en estat "+str(self._e)+" i el seu supervisor es "+str(self._s)

class Sortida(Node):
    """
    Aquesta classe gestiona la sortida del node
    """
    def __repr__(self):
        """
        Aquest metode especial retorna el node, el seu esatt i el seu supervisor
        """
        return  "El node "+str(self._n)+" es tracta d'una sortida en estat "+str(self._e)+" i e seu supervisor es "+str(self._s)

