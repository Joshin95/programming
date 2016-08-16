# -*- coding: utf-8 -*-

from bitvec import *
from avrexcep import *

class Memory (object):
    """
    Aquesta classe representa un banc de memòria. La classe és abstracta i, per tant, no poden haver-hi objectes instanciats de la classe sinó que sempre ho són de les seves subclasses DataMemory i ProgramMemory.
    """

    def __init__(self):
        """
        Assigna False a _trace.
        """
        self._m=[]
        self._trace=False

    def trace_on(self):
        """
        Activa la funcionalitat de trace. Aquesta funcionalitat permet traçar els accessos al banc de memòria.
        """
        self._trace=True

    def trace_off(self):
        """
        Desactiva la funcionalitat del trace.
        """
        self._trace=False

    def __len__(self):
        """
        Retorna el nombre de cel·les de la memòria.
        """
        return len(self._m)

    def __repr__(self): 
        """
        Retorna un str que conté un bolcat del banc de memòria en un format exactament com el que segueix.
        """
        a=""
        for i,v in enumerate(self._m):
            a+="{0}: {1}\n".format(Word(i),v)
        return a

    def dump(self,f=0,t=5):
        """
        Retorna un str que conté un bolcat del banc de memòria exactament com en el cas de __repr__ però unicament de les cel·les que estan en l'interval d'adreces [f,t).
        """
        a=""
        for i,v in enumerate(self._m[f:t+1]):
                a+="{0}: {1}\n".format(Word(i+f),v)
        return a
    
    def __getitem__(self,addr):
        """
        Implementa les operacions d'accés a la memòria. Addr és un int o qualsevol altre objecte que implementi el mètode __index__, en particular Word, i es correspon amb l'adreça de memòria a la que vol accedir. Val és un BitVector de la ateixa mida que la cel·la de la memòria, ja sigui Byte o Word.
        """
        if int(addr)<=len(self):
            if self._trace:
                print "Read", '{0}'.format(self._m[addr]),"from", '{0:04X}'.format(addr)
            return self._m[addr]
        else:
            raise OutOfMemError('Readfrom{0}outofrange'.format(int(addr)))
            
    def __setitem__(self,addr,val):
        if int(addr)<=len(self):
            if self._trace:
                print "Write", val, "to", '{0:04X}'.format(addr)
            self._m[addr]=val
        else:
            raise OutOfMemError('Writeto{0}outofrange'.format(int(addr)))

class ProgramMemory(Memory):    
    def __init__(self, ncells=1024): 
        super(ProgramMemory,self).__init__()
        for e in range(ncells):
            self._m.append(Word())
        
    
class DataMemory(Memory):
    def __init__(self, ncells=1024): 
        super(DataMemory,self).__init__()
        if ncells<32:
            ncells=32
        for e in range(ncells):
            self._m.append(Byte())

    def dump_reg(self):
        a=""
        for i,e in enumerate(self._m[:32]):
            a+="R{0:02d}: {1}\n".format(i,e)
        a+="X(R27:R26): {0}{1}\n".format(self._m[27],self._m[26])
        a+="Y(R29:R28): {0}{1}\n".format(self._m[29],self._m[28])
        a+="Z(R31:R30): {0}{1}\n".format(self._m[31],self._m[30])
        return a

class OutOfMemError(AVRException):
    pass

"""
if __name__=='__main__':
    
    r=DataMemory(3)
    
    r[0]=15
    r.trace_on()
    print r[0]
"""
 
