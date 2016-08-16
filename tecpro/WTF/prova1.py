import Image

def null():
    return ('NULL',None)


def is_null(img):
    x=False
    if img==('NULL',None):
        x=True
    return x

print is_null(('NULL',None))
        
    
def white_rgb(w,h):
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



print white_rgb(3,3)

def white_grey(w,h):
    mat=[]
    t=()
    t+=("L",)
    for fila in range(w):
        f=[]
        for columna in range(h):
            f+=[255]
        mat+=[f]
    t+=(mat,)
    return t
print white_grey(3,3)

def white_bn(w,h):
    mat=[]
    t=()
    t+=("1",)
    for fila in range(w):
        f=[]
        for columna in range(h):
            f+=[255]
        mat+=[f]
    t+=(mat,)
    return t
print white_bn(3,3)

def format(img):
    if img!=('NULL',None):
        return img[0]
print format(("1", [[255, 255, 255], [255, 255, 255], [255, 255, 255]]))

def matrix(img):
    if img!=('NULL',None):
        return img[1]
print matrix(("1", [[255, 255, 255], [255, 255, 255], [255, 255, 255]]))    

def img(m,model="DISCOVER"):
    t=[255,0]
    tipus="0"
    if len(m[0][0])==3:
        tipus="RGB"
    else:
        for fila in m:
            for columna in fila:
                if columna not in t:
                    tipus="L"
                    break
            else:
                tipus="1"
    return (tipus,m)

print img([[(255, 255, 255), (255, 255, 255), (255, 255, 255)], [(255, 255, 255), (255, 255, 255),
(255, 255, 255)], [(255, 255, 255), (255, 255, 255), (255, 255, 255)]],"DISCOVER")
