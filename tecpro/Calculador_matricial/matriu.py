def inicialitzarMatriu(f,c):
    """
    Inicialitza a zeros una matriu de ordre fxc
    >>> inicialitzaMatriu(3,3)
    [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    >>> inicialitzaMatriu(2,4)
    [[0, 0, 0, 0], [0, 0, 0, 0]]
    """
    mat=[]
    for i in range(f):
        fila=[]
        for j in range(c):
            z=0
            fila+=[z]
        mat+=[fila]
    return mat
def escriureMatriu(m):
    """
    Escriu en format adequat la matriu m de qualsevol ordre
    >>> escriuMatriu([[1,1,1],[0,0,1],[0,0,0]])

    1 1 1
    0 0 1
    0 0 0
    >>> escriureMatriu([[0,0],[0,1]])
    0 0
    0 1
    """
    for c in m:
        for k in c:
            print k,
        print
def llegirMatriu(f,c):
    """
    Retorna la matriu d'ordre fxc resultant de demanar les dades a l'usuari
    """
    mat=[]
    for i in range(f):
        fila=[]
        for j in range(c):
            z=input("Introdueixi un valor:")
            fila+=[z]
        mat+=[fila]
    return mat
def sumaMatrius(a,b):
    """
    Retorna la suma de dos matrius previament donades
    >>> sumaMatrius([[1, 1, 1], [1, 1, 1]], [[1, 1, 1], [1, 1, 1]])
    [[2, 2, 2], [2, 2, 2]]
    """
    if len(a)!=0 and len(b)!=0:
        fa=len(a)
        ca=len(a[0])
        fb=len(b)
        cb=len(b[0])
        if fa==fb and ca==cb:
            c=inicialitzarMatriu(fa,ca)
            for i in range(fa):
                for j in range(ca):
                    c[i][j]=a[i][j]+b[i][j]
            return c
        else:
            print "Les matrius tenen ordres diferents, per tant, no es pot efectuar la suma"
            return []
    else:
        print "Alguna de les matrius es una matriu buida"

def multiplicarMatrius(a,b):
    """
    Retorna la multiplicacio rebudes dos matrius
    >>> multiplicarMatrius([[2, 2], [2, 2]], [[2, 2], [2, 2]])
    [[8, 8], [8, 8]]
    """
    if len(a)!=0 and len(b)!=0:
        fa=len(a)
        ca=len(a[0])
        fb=len(b)
        cb=len(b[0])
        if ca==fb:
            c=inicialitzarMatriu(ca,fb)
            for f in range(ca):
                for t in range(fb):
                    for i in range(ca):
                        c[f][t]+=a[f][i]*b[i][t]
            return c
        else:
            print "Les columnes de la primera matriu no coincideixen amb les files de la segona"
            return []
    else:
        print "Alguna matriu es una matriu buida"

def restaMatrius(a,b):
    """
    Retorna la resta de dos matrius previament donades
    >>> sumaMatrius([[1, 1, 1], [1, 1, 1]], [[1, 1, 1], [1, 1, 1]])
    [[0, 0, 0], [0, 0, 0]]
    """
    if len(a)!=0 and len(b)!=0:
        fa=len(a)
        ca=len(a[0])
        fb=len(b)
        cb=len(b[0])
        if fa==fb and ca==cb:
            c=inicialitzarMatriu(fa,ca)
            for i in range(fa):
                for j in range(ca):
                    c[i][j]=a[i][j]-b[i][j]
            return c
        else:
            print "Les matrius tenen ordres diferents, per tant, no es pot efectuar la resta"
            return []
    else:
        print "Alguna de les matrius es una matriu buida"


def det3(a):
    """
    Retorna el resultat del determinant, donada una matriu
    >>> det3([[1, 1, 1], [1, 1, 1], [1, 1, 1]]
    0
    """
    if len(a)!=0:
        c=(a[0][0]*a[1][1]*a[2][2]+a[0][1]*a[1][2]*a[2][0]+a[0][2]*a[1][0]*a[2][1])-(a[2][0]*a[1][1]*a[0][2]+a[1][0]*a[0][1]*a[2][2]+a[0][0]*a[1][2]*a[2][1])
        return c
    else:
        print "Acabes de posar una matriu buida"                                 
def simetria(a):
    """
    Comprova si la matriu es simetrica
    >>> simetria([[1, 1, 1], [1, 1, 1], [1, 1, 1]])
    True
    """
    e=True
    if len(a)!=0:
        fa=len(a)
        ca=len(a[0])
        for i in range(fa):
            for j in range(ca):
                if a[i][j]!=a[j][i]:
                    e=False
        if e==True:
            print "Es una matriu simetrica"
        else:
            print "No es una matriu simetrica"


def transposada(a):
    """
    Retorna la matriu transposada
    >>> transposada([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    ([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
    """
    l=[]
    if len(a)!=0:
        for i in a:
            l+=i
        c=[[l[0],l[3],l[6]],[l[1],l[4],l[7]],[l[2],l[5],l[8]]]
        return c
        


def inversa(a):
    """
    Retorna la inversa d'una matriu
    >>> inversa([[2, 0, 1], [3, 0, 0],[5, 1, 1]])
    ([[0.0, 0.333333333333, 0.0], [-1.0, -1.0, 1.0],[0.0, -0.666666666667, 0.0]]
    """
    l=[]
    r=[]
    if len(a)!=0:
        for i in a:
            l+=i
        adjunta=[[l[4]*l[8]-l[7]*l[5],-(l[3]*l[8]-l[6]*l[5]),l[3]*l[7]-l[6]*l[4]],[-(l[1]*l[8]-l[7]*l[2]),l[0]*l[8]-l[6]*l[2],-(l[0]*l[7]-l[6]*l[1])],[l[1]*l[5]-l[4]*l[2],-(l[0]*l[5]-l[3]*l[2]),l[0]*l[4]-l[3]*l[1]]]
        u=transposada(adjunta)
        s=1./det3(a)
        for h in u:
            r+=h
        v=[[s*r[0],s*r[1],s*r[2]],[s*r[3],s*r[4],s*r[5]],[s*r[6],s*r[7],s*r[8]]]
        return v







    


        
        



            
        


