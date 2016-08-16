"""
Aquest modul fa la gestio d'un garatge
"""

from cotxe import Cotxes

class Garatge(object):
    """
    Aquesta classe te com a objectiu manipular diferents cotxes del garatge
    """
    def __init__(self):
        self._cotxes=[]
    def afegeixCotxe(self,c):
        """
        Aquest metode afegeix un cotxe al garatge
        """
        self._cotxes+=[c]
    def borrarCotxe(self):
        """
        Aquest metode treu un cotxe del garatge(inacabat...)
        """
        print self._cotxes
    def Ocupacio(self):
        """
        Aquest metode retorna la quantitat de cotxes que hi han al garatge
        """
        count=0
        for c in self._cotxes:
            count+=1
        return count
    def mostrar(self):
        """
        Aquest metode mostra tots els cotxes del garatge
        """
        print self._cotxes
