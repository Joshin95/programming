# -*- coding: utf-8 -*-
>>> from repertoir import *
>>> from instruction import *
    
    >>> l=Repertoir([Ldi(),Add(),Nop(),Adc()])
    >>> l.find(0b1110000000000000)
    LDI
    >>> l.find(0b0000110000000000)
    ADD
    >>> l.find(0b0000000000000000)
    NOP
