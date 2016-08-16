# -*- coding: utf-8 -*-
from memory import *

carry=0
zero=1
neg=2

class State(object):
    def __init__(self,data=128,prog=128):
        self.data=DataMemory(data)
        self.prog=ProgramMemory(prog)
        self.pc=Word(0)
        self.flags=Byte(0)
    def dump_dat(self):
        return self.data
    def dump_prog(self):
        return self.prog
    def dump_reg(self):
        a=self.data.dump_reg()
        a+="PC: {0}\n".format(self.pc)
        a+="CARRY: {0} ZERO: {1} NEG: {2}\n".format(int(self.flags[carry]),int(self.flags[zero]),int(self.flags[neg])) #El int el posem perque no surti True o False.
        return a
        
    
