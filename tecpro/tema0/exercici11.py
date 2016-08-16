def palindroma(f):
    """
    retorna True si 'f' es palindroma
    >>> palindroma("cuc")
    True
    >>> palindroma("que")
    False
    """
    r=False
    string=""
    for e in range(len(f)):
        e=-e
        string+=f[e-1]
    if f==string:
        r=True
    return r

#f="acuca"
#print palindroma(f)
