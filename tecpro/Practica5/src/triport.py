"""
Aquest modul conte la classe Triport
"""
from estat import Estat
from node import Node

class Triport(object):
    """
    La classe imita un triport amb 2 entrades i 1 sortida
    """
    def __init__(self,i1,i2,o):
        """
        El metode constructor que afeigeix les 2 entrades i la sortida
        """
        self._in1=i1
        self._in2=i2
        self._out=o
        
    def tick(self):
        """
        Quan es crida aquest metode el triport fa un cicle de treball, llegeix les entrade i calcula la sortida. Per fer la operacio crida la funcio _do_function(self,i1,i2)
        """
        self._out._e=Estat(self._do_function(self._in1,self._in2))
        
        
    
    def __repr__(self):
        """
        Retorna el string corresponent al triport
        """
        return "Info triport: \n"+"Entrades: \n"+str(self._in1)+" "+str(self._in2)+"\nSortida: "+str(self._out)
    
class And(Triport):
    """
    Aquesta classe hereta les entrades i la sortida de la classe Triport
    """
        
    def _do_function(self,e1,e2):
        """
        Fa la funcio logica AND de la e1 i e2
        """
        return self._in1._e&self._in2._e
    
    def get_name(self):
        """
        Retorna el nom de la funcio booleana que s'esta executant
        """
        return "Funcio AND"

class Or(Triport):
    """
    Aquesta classe hereta les entrades i la sortida de la classe Triport
    """
        
    def _do_function(self,e1,e2):
        """
        Fa la funcio logica OR de la e1 i e2
        """
        return self._in1._e|self._in2._e
        
    def get_name(self):
        """
        Retorna el nom de la funcio booleana que s'esta executant
        """
        return "Funcio OR"




