"""
Aquest modul conte la classe Estat
"""

class Estat(object):
    """
    Aquesta classe representa els estats que prenen els nodes d'un triport
    """

    def __init__(self,e=-1):
        """
        Metode constructor predefinit a -1
        """
        self._e=e
    def undef(self):
        """
        Posa com a indefinit (-1) un node
        >>> e1=Estat(-1)
        >>> e1.undef()
        True
        >>> e2=Estat(0)
        >>> e2.undef()
        False
        """
        t=False
        if self._e==-1:
            t=True
        return t
    def __nonzero__(self):
        """
        Aquest metode retorna True si self._e esta definit a 1 o 0
        """
        return self._e==0 or self._e==1
    def __repr__(self):
        """
        Aquest metode especial fa la representacio del objecte estat
        """
        return str(self._e)
    def __and__(self,other):
        """
        Aquest metode especial fa el "and" logic del self i other
        >>> e1=Estat(0)
        >>> e2=Estat(0)
        >>> print e1&e2
        0
        >>> e3=Estat(0)
        >>> e4=Estat(1)
        >>> print e3&e4
        0
        >>> e5=Estat(1)
        >>> e6=Estat(1)
        >>> print e5&e6
        1
        """
        if self._e==0 or other._e==0:
            return 0
        else:
            return self._e and other._e
    def __or__(self,other):
        """
        Aquest metode especial fa el "and" logic del self i other
        >>> e1=Estat(0)
        >>> e2=Estat(0)
        >>> print e1 | e2
        0
        >>> e3=Estat(1)
        >>> e4=Estat(0)
        >>> print e3 | e4
        1
        >>> e5=Estat(1)
        >>> e6=Estat(1)
        >>> print e5 | e6
        1
        """
        if self._e==1 or other._e==1:
            return 1
        else:
            return self._e or other._e
    def __eq__(self,other):
        """
        Aquest metode especial comprova la igualtat de dos estats
        >>> e1=Estat(1)
        >>> e2=Estat(0)
        >>> print e1==e2
        False
        >>> e3=Estat(1)
        >>> print e1==e3
        True
        """
        return self._e==other._e
    def __invert__(self):
        """
        Aquest metode especial fa la inversa d'un estat
        >>> e1=Estat(1)
        >>> e2=Estat(-1)
        >>> e3=Estat(0)
        >>> print ~e1
        0
        >>> print ~e2
        -1
        >>> print ~e3
        1
        """
        if self._e==1:
            self._e=0
            return 0
        elif self._e==0:
            self._e=1
            return 1
        else:
            self._e=-1
            return -1




