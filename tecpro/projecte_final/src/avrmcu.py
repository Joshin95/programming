# -*- coding: utf-8 -*-
from state import *
from repertoir import *
from avrexcep import *
from instruction import *

class AvrMcu(object):
   
    def __init__(self):
        self._s=State()
        self._rep=Repertoir([Add(),Adc(),Break(),Ldi()])  #Sub(),Subi(),And(),Or(),Eor(),Lsr(),Mov(),Sts(),Lds(),Rjmp(),Brbs(),Brbc(),Nop(),In(),Out()

    def reset(self):
        """
        Fa un reset de l'estat deixant-lo de la mateixa forma que el mètode __init__.
        """
        self._s=State()

    def set_prog(self,p):
        """
        p és una llista d'enters que representen un programa en llenguatge màquina de l'AVR. El mètode instal·la el programa p en la memòria de programa del simulador a partir de l'adreça 0000.
        """
        
        for i,e in enumerate(p):
            self._s.prog[i]=Word(e)

    def dump_reg(self):
        """
        Retorna un string que correspon amb un bolcat dels registres del simulador.
        """
        return self._s.dump_reg()

    def dump_dat(self):
        """
        Retorna un string que correspon amb un bolcat de la memòria de dades del simulador.
        """
        return self._s.dump_dat()

    def dump_prog(self):
        """
        Retorna un string que correspon amb un bolcat de la memòria de programa del simulador.
        """
        return self._s.dump_prog()

    def run(self):
        try:
            while True:
                x=self._s.prog[self._s.pc]
                a=self._rep.find(x)
                a.execute(x,self._s)
        except UnknownCodeError:
            print "La instrucció que vol executar no existeix"
            return False
        except BreakException:
            print "Fi del programa"
            return True

    def set_trace(self,t):
        """
        Quan s’invoca amb t=True activa el mode trace de la memòria de dades. Si s’activa amb t=False es desactiva el mode.
        """

        if t:
            self._s.data.trace_on()
        else:
            self._s.data.trace_off()
            
        
                
                
                
                
    

    
