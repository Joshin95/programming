# -*- coding: utf-8 -*-
from state import *
#from avrexcept import *
from bitvec import *

#class BreakException(AVRException):
    #pass

class InstRunner(object):
    def __repr__(self):
        pass
    def match(self,instr):
        pass
    def execute(self,instr,state):
        pass

class Nop(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111000000000000)==(0b0000000000000000):
            return True
        else:
            return False

    def __repr__(self):
        return "NOP"

    def execute(self,instr,state):
        state.pc=state.pc+1

class Ldi(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111000000000000)==(0b1110000000000000):
            return True
        else:
            return False

    def __repr__(self):
        return "LDI"

    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b11110000)
        k=instr.extract_field_u(0b111100001111)
        state.data[d_reg+16]=Byte(k)
        state.pc=state.pc+1

class Add(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111110000000000)==(0b0000110000000000):
            return True
        else:
            return False
    def __repr__(self):
        return "ADD"
    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b111110000)
        r_reg=instr.extract_field_u(0b1000001111)
        v1=state.data[d_reg]
        v2=state.data[r_reg]
        suma=v1+v2
        state.data[d_reg]=suma
        if (v1[7]&v2[7])|(v2[7]&(~suma[7]))|((~suma[7])&v1[7])==0:
            state.flags[carry]=0
        else:
            state.flags[carry]=1
        if int(suma)==0:
            state.flags[zero]=1
        else:
            state.flags[zero]=0
        state.flags[neg]=suma[7]
        state.pc+=1

class Adc(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111110000000000)==(0b0001110000000000):
            return True
        else:
            return False

    def __repr__(self):
        return "ADC"
    
    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b111110000)
        r_reg=instr.extract_field_u(0b1000001111)
        v1=state.data[d_reg]
        v2=state.data[r_reg]
        suma=v1+v2+state.flags[carry]
        if (v1[7]&v2[7])|(v2[7]&(~suma[7]))|((~suma[7])&v1[7])==0:
            state.flags[carry]=0
        else:
            state.flags[carry]=1
        state.data[d_reg]=suma
        if int(suma)==0:
            state.flags[zero]=1
        else:
            state.flags[zero]=0
        state.flags[neg]=suma[7]
        state.pc+=1

class Sub(InstRunner):
    """
    Realitza la resta sense carry, de dos registres
    """

    def match(self,instr):
        if int(instr)&(0b1111110000000000)==(0b0001100000000000):
            return True
        else:
            return False
        
    def __repr__(self):
        return "SUB"
        
    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b111110000)
        r_reg=instr.extract_field_u(0b1000001111)
        v1=state.data[d_reg]
        v2=state.data[r_reg]
        resta=v1-v2
        state.data[d_reg]=resta
        state.flags[carry]=(~v1[7]&v2[7])|(v2[7]&resta[7])|(resta[7]&(~v1[7]))
        state.flags[zero]= ~(resta[7]|resta[6]|resta[5]|resta[4]|resta[3]|resta[2]|resta[1]|resta[0])
        state.flags[neg]=resta[7]
        state.pc+=1


        
class Break(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111111111111111)==(0b1001010110011000):
            return True
        else:
            return False

    def __repr__(self):
        return "BREAK"
        
    def execute(self,instr,state):
        state.pc+=1
        raise BreakException()

class And(InstRunner):

    def match(self,instr):
        if int(instr)&(0b1111110000000000)==(0b0010000000000000):
            return True
        else:
            return False
    def __repr__(self):
        return "AND"
    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b111110000)
        r_reg=instr.extract_field_u(0b1000001111)
        v1=state.data[d_reg]
        v2=state.data[r_reg]
        andlogic=v1&v2
        state.data[d_reg]=andlogic
        if int(suma)==0:
            state.flags[zero]=1
        else:
            state.flags[zero]=0
        state.flags[neg]=suma[7]
        state.pc+=1

class Eor(InstRunner):
    def match(self,instr):
        if int(instr)&(0b1111110000000000)==(0b0010010000000000):
            return True
        else:
            return False
    def __repr__(self):
        return "EOR"
    def execute(self,instr,state):
        d_reg=instr.extract_field_u(0b111110000)
        r_reg=instr.extract_field_u(0b1000001111)
        v1=state.data[d_reg]
        v2=state.data[r_reg]
        eorlogic=v1^v2
        state.data[d_reg]=eorlogic
        if int(eorlogic)==0:
            state.flags[zero]=1
        else:
            state.flags[zero]=0
        state.flags[neg]=eorlogic[7]
        state.pc+=1

class Sts(InstRunner):
    def match(self,instr):
        if int(instr)&(0b1111100000000000)==(0b1010100000000000):
            return True
        else:
            return False
    def __repr__(self):
        return "STS"
    def execute(self,instr,state):
        k_reg=instr.extract_field_u(0b11100001111)
        d_reg=instr.extract_field_u(0b11110000)
        state.data[k_reg]=state.data[d_reg+16]
        state.pc+=1

class Lds(InstRunner):
    def match(self,instr):
        if int(instr)&(0b1111100000000000)==(0b1010000000000000):
            return True
        else:
            return False
    def __repr__(self):
        return "LDS"
    def execute(self,instr,state):
        k_reg=instr.extract_field_u(0b11100001111)
        d_reg=instr.extract_field_u(0b11110000)
        state.data[d_reg+16]=state.data[k_reg]
        state.pc+=1
        
class BreakException(AVRException):
    pass





"""
b=State()
b.data[17]=Word(2)
b.data[18]=Word(3)
a=ADD()
a.execute(Word(0b0000110000010010),b)
print b.data[17]
"""   
        
