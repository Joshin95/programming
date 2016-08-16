def altaAlumne(d):
    """
    Retorna el diccionari d amb l'alumne donat d'alta
    """
    dni=raw_input("Entra dni de l'alumne: ")
    nota=input("Entra nota de l'alumne: ")
    if d.has_key(dni):
        print "Alumne ja existeix"
    else:
        d[dni]=nota
    return d

def llistatAlumnes(d):
    """
    Llista els alumnes-nota donars d'alta
    """
    for k,v in d.items():
        print k,v

def esborraAlumne(d,dni):
    """
    retorna el diccionari resultant d'esborrar l'alumne amb el dni donat
    """
    if d.has_key(dni):
        print "Dades alumne a borrar:" ,d[dni]
        print "Segur esborrar?(s/n)"
        y=raw_input()
        if y.upper()=='s':
            del d[dni]
            print "Alumne", dni, "donat de baixa"
    return d
