def desplega(p):
    """
    retorna la llista de tots els prefixos d'una paraula
    >>> desplega(hola)
    ['h','ho','hol','hola']
    """
    l=[]
    s=""
    x=len(p)
    for c in range(x):
        s=p[:c+1]
        l+=[s]
    print l
    
#p="hola"
#desplega(p)
