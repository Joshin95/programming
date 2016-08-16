def comprovaAB(a,b):
    """
    retorna True si a>b i a*b=1, a,b son reals
    >>> comprovaAB(-1,-0.5)
    False
    >>> comprovaAB(2,0.5)
    True
    >>> comprovaAB(-2,3)
    False
    >>> comprovaAB(4,3)
    False
    >>> comprovaAB(1,1)
    False
    """
    return a>b and a*b==1

