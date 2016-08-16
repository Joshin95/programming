def llegirMatriu(f,c):
    """
    Retorna la matriu d'ordre fxc resultant de demanar les dades a l'usuari
    """
    mat=[]
    for a in range(f):
        print "Introdueixi dades de la fla" ,a
        fila=[]
        for b in range(c):
            print "columna",b
            fila+=[input()]
        mat+=[fila]
    return mat


def escriureMatriuFitxer(m):
    """
    Guarda la mtriu m a fitxer
    """
    f=open("mat.txt","w")
    for fila in m:
        for columna in fila:
            f.write(str(columna)+" ")
        f.write("\n")
    f.close()

def llegirMatriuDeFitxer():
    """
    Llegeix la matriu del fitxer
    """
    f=open("mat.txt")
    m=[]
    for linia in f:
        l=linia.split()
        fila=[]
        for e in l:
            fila+=[int(e)]
        m+=[fila]    
    f.close()
    return m
