def inicialitzarMatriu(f,c):
    """
    Inicialitza a 0s una matriu d'ordre fxc
    >>> inicialitzaMatriu(3,3)
    [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    >>> inicialitzaMatriu(2,4)
    [[0, 0, 0, 0], [0, 0, 0, 0]]
    """
    m=[]
    for i in range(f):
        fila=[]
        for j in range(c):
            fila+=[0]
        m+=[fila]
    return m

def escriureMatriu(m):
    """
    Escriu en format adequat la matriu de qualsevol ordre
    >>> escriure Matriu([[1, 1, 1], [0, 0, 1], [0, 0, 0]])
    1 1 1
    0 0 1
    0 0 0
    >>> escriureMatreiu([[0, 0], [0, 1]])
    0 0
    0 1
    """
    for f in m:
        for c in f:
            print c,
        print

def llegirMatriu(f,c):
    """
    Retorna la matriu d'ordre fxc resultant de demanar les dades a l'usuari
    """
    
