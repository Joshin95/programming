# -*- coding: utf-8 -*-

>>> from bitvec import Byte,Word

    >>> print Byte(2)
    02
    >>> print Byte(24)
    18
    >>> print Byte(325)
    45
    >>> print Byte(-1)
    FF

    >>> Byte(12) + Byte(2)
    0E
    >>> Byte(12) + 2
    0E
    >>> Byte(12) - Byte(2)
    0A
    >>> Byte(12) - 2
    0A
    >>> Byte(203) - 3
    C8
   
    >>> Byte(3) | Byte(4)
    07
    >>> Byte(7) | Byte(0b0010)
    07
    >>> Byte(7) & Byte(0b0010)
    02
    >>> Byte(0xff) & Byte(0b1011)
    0B
    >>> Byte(0xff) ^ Byte(0b1011)
    F4
    >>> ~Byte(0xf0)
    0F
    >>> ~Byte(0b101010)
    D5
    >>> Byte(1) << 4
    10
    >>> Byte(0xfe) << 3
    F0
    
    >>> Byte(6) == Byte(6)
    True
    >>> Byte(5) == Byte(6)
    False
    >>> Byte(5) != Byte(6)
    True
    >>> Byte(6) != Byte(6)
    False
    


    >>> a=Byte(7)
    >>> a[1]
    1
    >>> a[1]=0
    >>> a
    05
    
   
   
    >>> a = Word(54)
    >>> b = Word(150)
    >>> c = Word(0b1011)
    >>> len(a)
    16
    >>> len(b)
    16
    >>> len(c)
    16
    
    
    >>> a = Word(54)
    >>> b = Word(150)
    >>> c = Word(0b1011)
    >>> len(a)
    16
    >>> len(b)
    16
    >>> len(c)
    16

    >>> a = Word(54)
    >>> b = Word(300)
    >>> c = Word(0b11011)
    >>> a.lsb() # retorna un byte(8 bits)
    36
    >>> isinstance(a.lsb(),Byte)
    True
    >>> a.msb()
    00
