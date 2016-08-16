# -*- coding: utf-8 -*-

>>> from instruction import *
>>> from state import *
>>> from memory import *

#Instruccio ADD
   >>> s=State()
   >>> s.data.trace_on()
   >>> s.prog[0]=Word(0b0000110000000001)
   >>> add=Add()
   >>> add.match(s.prog[0])
   True
   >>> s.data[0]=Byte(255)
   Write FF to 0000
   >>> s.data[1]=Byte(1)
   Write 01 to 0001
   >>> add.execute(s.prog[0],s)
   Read FF from 0000
   Read 01 from 0001
   Write 00 to 0000
   >>> s.pc
   0001
   >>> s.flags
   03
   >>> s.prog[1]=Word(0b0000110000010010)
   >>> add.match(s.prog[1])
   True
   >>> add.execute(s.prog[1],s)
   Read 01 from 0001
   Read 00 from 0002
   Write 01 to 0001
   >>> s.flags
   00
   >>> s.pc
   0002

#Instruccio ADC
   >>> s.prog[2]=Word(0b0001110000100011)
   >>> adc=Adc()
   >>> adc.match(s.prog[2])
   True
   >>> s.data[2]=Byte(145)
   Write 91 to 0002
   >>> s.data[3]=Byte(100)
   Write 64 to 0003
   >>> adc.execute(s.prog[2],s)
   Read 91 from 0002
   Read 64 from 0003
   Write F5 to 0002
   >>> s.flags
   04
   >>> s.pc
   0003
   >>> s.prog[3]=Word(0b0001110000010011)
   >>> adc.match(s.prog[3])
   True
   >>> s.data[1]=Byte(50)
   Write 32 to 0001
   >>> s.data[3]=Byte(245)
   Write F5 to 0003
   >>> adc.execute(s.prog[3],s)
   Read 32 from 0001
   Read F5 from 0003
   Write 27 to 0001
   >>> s.flags
   01
   >>> s.pc
   0004

#Instruccio NOP
   >>> nop=Nop()
   >>> s.prog[26]=Word(0b0000000000000000)
   >>> nop.match(s.prog[26])
   True
   >>> s.pc
   0004
   >>> nop.execute(s.prog[26],s)
   >>> s.pc
   0005

#Instruccio LDI
   >>> ldi=Ldi()
   >>> s.prog[12]=Word(0b1110000001101110)
   >>> ldi.match(s.prog[12])
   True
   >>> s.data[22]=Byte(7)
   Write 07 to 0016
   >>> ldi.execute(s.prog[12],s)
   Write 0E to 0016
   >>> s.flags
   01
   >>> s.pc
   0006

#Instruccio SUB
   >>> s.prog[4]=Word(0b0001100001010100)
   >>> sub=Sub()
   >>> sub.match(s.prog[4])
   True
   >>> s.data[4]=Byte(24) 
   Write 18 to 0004
   >>> s.data[5]=Byte(19)
   Write 13 to 0005
   >>> sub.execute(s.prog[4],s)
   Read 13 from 0005
   Read 18 from 0004
   Write FB to 0005
   >>> s.flags
   07
   >>> s.pc
   0007
   >>> s.prog[5]=Word(0b0001100000100011) 
   >>> sub.match(s.prog[5])
   True
   >>> s.data[2]=Byte(10)
   Write 0A to 0002
   >>> sub.execute(s.prog[5],s)
   Read 0A from 0002
   Read F5 from 0003
   Write 15 to 0002
   >>> s.flags
   03
   >>> s.pc
   0008


#Instruction Eor
   >>> eor=Eor()	
   >>> s.prog[9]=Word(0b0010010010111010)
   >>> eor.match(s.prog[9])
   True
   >>> s.data[10]=Byte(14)
   Write 0E to 000A
   >>> s.data[11]=Byte(15)
   Write 0F to 000B
   >>> eor.execute(s.prog[9],s)
   Read 0F from 000B
   Read 0E from 000A
   Write 01 to 000B
   >>> s.flags
   01
   >>> s.pc
   0009

#Instruction Sts	
   >>> sts=Sts()
   >>> s.prog[13]=Word(0b1010100001101110)
   >>> sts.match(s.prog[13])
   True
   >>> sts.execute(s.prog[13],s)	
   Read 0E from 0016
   Write 0E to 000E
   >>> s.flags
   01
   >>> s.pc	
   000A
	
#Instruction Lds
   >>> lds=Lds()
   >>> s.data[8]=Byte(14)
   Write 0E to 0008
   >>> s.prog[14]=Word(0b1010000001101000)
   >>> lds.match(s.prog[14])
   True
   >>> lds.execute(s.prog[14],s)	
   Read 0E from 0008
   Write 0E to 0016
   >>> s.flags
   01
   >>> s.pc	
   000B
