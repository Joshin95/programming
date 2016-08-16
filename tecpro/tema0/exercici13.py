def permutacio(l,p):
    """
    retorna la llista permutada l amb el que li indica la p
    >>> permutacio(["a","b","c"],[2,1,2])
    ['c','b','c']
    """
    ln=[]
    for c in p:
        ln+=l[c]
    return ln

#l=["a","b","c"]
#p=[2,1,2]
#print permutacio(l,p)
        
