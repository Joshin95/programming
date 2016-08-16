import Image
import string

def null():
    """
    Retorna la imatge nula (Tipus, matruy)==('NULL',None)
    >>> null()
    ('NULL', None)
    """
    return ('NULL',None)


def is_null(img):
    """
    Comprova si una imatge (Tipus,matriu) es nula
    >>> is_null(('NULL',None))
    True
    """
    x=False
    if img==('NULL',None):
        x=True
    return x
        
    
def white_rgb(w,h):
    """
    Retorna una imatge en format RGB amb tots els pixels en blanc w x h
    >>> white_rgb(3,3)
    ('RGB', [[(255, 255, 255), (255, 255, 255), (255, 255, 255)], [(255, 255, 255), (255, 255, 255), (255, 255, 255)], [(255, 255, 255), (255, 255, 255), (255, 255, 255)]])
    """
    mat=[]
    t=()
    t+=("RGB",)
    for fila in range(w):
        f=[]
        for columna in range(h):
            f+=[(255,255,255)]
        mat+=[f]
    t+=(mat,)
    return t


def white_grey(w,h):
    """
    Retorna una imatge en format de grisos, amb tots els pixels en blanc w x h
    >>> white_grey(3,3)
    ('L', [[255, 255, 255], [255, 255, 255], [255, 255, 255]])
    >>> white_grey(5,2)
    ('L', [[255, 255, 255, 255, 255], [255, 255, 255, 255, 255]])
    """
    mat=[]
    t=()
    t+=("L",)
    for fila in range(h):
        f=[]
        for columna in range(w):
            f+=[255]
        mat+=[f]
    t+=(mat,)
    return t


def white_bn(w,h):
    """
    Retorna la imatge una imatge en format blanc i negre en tots pixels blancs w x h
    >>> white_bn(3,3)
    ('1', [[255, 255, 255], [255, 255, 255], [255, 255, 255]])
    >>> white_bn(2,3)
    ('1', [[255, 255], [255, 255], [255, 255]])
    """
    mat=[]
    t=()
    t+=("1",)
    for fila in range(h):
        f=[]
        for columna in range(w):
            f+=[255]
        mat+=[f]
    t+=(mat,)
    return t


def format(img):
    """
    Retorna el format de la imatge
    >>> format(('1', [[255, 255], [255, 255], [255, 255]]))
    '1'
    >>> format(('L', [[255, 255, 255], [255, 255, 255], [255, 255, 255]]))
    'L'
    """
    if img!=('NULL',None):
        return img[0]

def matrix(img):
    """
    Retorna la matriu en pixels d'una imatge
    >>> matrix(('1', [[255, 255], [255, 255], [255, 255]]))
    [[255, 255], [255, 255], [255, 255]]
    >>> matrix(('L', [[255, 255, 255], [255, 255, 255], [255, 255, 255]]))
    [[255, 255, 255], [255, 255, 255], [255, 255, 255]]
    """
    if img!=('NULL',None):
        return img[1]

def img(m,model):
    """
    Retorna la representacio de la imatge en format tupla (Tipus,matriu)
    >>> img([[255,255,0],[255,128,255],[191,255,255]],'DISCOVER')
    ('L', [[255, 255, 0], [255, 128, 255], [191, 255, 255]])
    >>> img([[255,255,0],[255,0,255],[0,255,255]],'DISCOVER')
    ('1', [[255, 255, 0], [255, 0, 255], [0, 255, 255]])
    """
    tipus="0"
    if model=="DISCOVER":
        t=[255,0]            
        if type(m[0][0])==tuple:
            tipus="RGB"
        else:
            for fila in m:
                for columna in fila:
                    if columna not in t:
                        tipus="L"
                        break
                else:
                    tipus="1"
                    
    elif model=="RGB":
        if type(m[0][0])==tuple:
            tipus="RGB"
            print "Model RGB correcte"
        else:
            print "Model incorrecteo"
        
    elif model=="L":
        if type(m[0][0])==tuple:
            print "Model incorrecte"
        else:
            t=[255,0]
            for fila in m:
                for columna in fila:
                    if columna not in t:
                        tipus="L"
                        print "Model Escala de grisos, L correcte"
                else:
                    tipus="Model incorrecte, es 1"
              
    elif model=="1":
        if type(m[0][0])==tuple:
            print "Model incorrecte"
        else:
            t=[255,0]
            for fila in m:
                for columna in fila:
                    if columna in t:
                        tipus="1"
                        print "Model b/n, 1"
                else:
                    tipus="Model incorrecte, es L"
        
    return (tipus,m)

def get_w(img):
    """
    Retorna l'amplada d'una imatge
    >>> get_w(('1', [[255, 255], [255, 255], [255, 255]]))
    2
    >>> get_w(('L', [[255, 255, 255, 255, 255], [255, 255, 255, 255, 255]]))
    5
    """
    m=img[1]
    return len(m[0])

def get_h(img):
    """
    Retorna l'alsada d'una imatge
    >>> get_h(('1', [[255, 255], [255, 255], [255, 255]]))
    3
    >>> get_h(('L', [[255, 255, 255], [255, 255, 255], [255, 255, 255]]))
    3
    """

    m=img[1]
    return len(m)


def subimg(img,ow,oh,w,h):
    """
    subimg(imatge,columna origen,fila origen,amplada columnes,alsada files)
    Retorna una subimatge d'una imatge amb origen de coordenades ow,oh i tamany w x h
    >>> subimg(('L', [[0, 0, 255], [255, 255, 255], [255, 255, 255]]),0,0,2,1)
    ('L', [[0, 0]])
    >>> subimg(('1', [[255, 255], [255, 255], [255, 255]]),0,1,2,1)
    ('1', [[255, 255]])
    >>> subimg(('1', [[255, 255], [255, 255], [0, 255]]),0,1,2,2)
    ('1', [[255, 255], [0, 255]])
    """
    m=img[1]
    origen=m[oh][ow]
    rang=oh+h
    totalcol=len(m[0])
    totalfil=len(m)
    files=h
    columnes=w
    nueva=[]
    for i,c in enumerate(m):
        if i>=oh and i<oh+h:
            l=[]
            for i,v in enumerate(c):
                if i>=ow and i<ow+w: 
                    l+=[v]
            nueva+=[l]
    return (img[0],nueva)
        
