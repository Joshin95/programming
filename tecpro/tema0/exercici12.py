def subcadena(d,s):
    """
    retorna True si existeix algun valor del diccionari d que es una subcadena d's
    >>> subcadena({1:"asf",2:"ola",3:"si"},"casa")
    False
    >>> subcadena({1:"as",2:"ola",3:"si"},"casa")
    True
    """
    x=False
    for c in d.values():
        if c in s:
            x=True
    return x


#d={1:"as",2:"ola",3:"si"}
#s="casa"
#print subcadena(d,s)
