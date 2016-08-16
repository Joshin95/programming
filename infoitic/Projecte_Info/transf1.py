def htrim(img):
    if img[1]!=[]:
        count1=1
        l=[]
        eliminada=[]
        mat=[]
        mat1=[]
        m=img[1]
        x=len(m)
        y=len(m[0])
        for fila in range(y):
            f=[]
            for columna in range(x):
                f+=[0]
            mat+=[f]
        for i in range(y):
            for j in range(x):
                mat[i][j]=m[j][i]
        for c in mat:
            count1=0
            l=[]
            for u in c:
                e=len(c)
                if u==255:
                    count1+=1
                l+=[u]
            if count1==e:
                eliminada+=[l]
            elif count1!=e:
                break
        k=len(eliminada)
        q=mat[k:]
        o=len(q)
        s=o-1
        eliminada2=[]
        while s<=o and s>=0:
            count1=0
            l=[]
            for u in q[s]:
                e=len(q[s])
                if u==255:
                    count1+=1
                l+=[u]
            if count1==e:
                eliminada2+=[l]
            elif count1!=e:
                break
            s-=1
        p=len(eliminada2)
        z=q[:o-p]
        x1=len(z)
        y1=len(z[0])
        for fila in range(y1):
            f=[]
            for columna in range(x1):
                f+=[0]
            mat1+=[f]
        for i in range(y1):
            for j in range(x1):
                mat1[i][j]=z[j][i]
        return ("1",mat1)

def vtrim(img):
    eliminada=[]
    for c in img[1]:
        count1=0
        l=[]
        for u in c:
            e=len(c)
            if u==255:
                count1+=1
            l+=[u]
        if count1!=e:
            eliminada+=[l]
    return ("1",eliminada)
        
    
def scale(i,h):
    """
    >>> scale(('1',[[255, 0, 0,0],[255, 255, 255,0],[255, 255, 255,0]]),11)
    [[255], [255], [255]]
    """
    matriu=i[1]
    mat=[]
    H=len(matriu)
    W=len(matriu[0])
    f=float(H)/h
    w=float(W)/f
    w=int(w)
    for fila in range(h):
            s=[]
            for columna in range(w):
                s+=[0]
            mat+=[s]
    for fila in range(len(mat)):
        for columna in range(len(mat[0])):
            mat[fila][columna]=matriu[int(fila*f)][int(columna*f)]
    return ("1",mat)        
        

#print scale(('1',[[255, 0, 0,0],[255, 255, 255,0],[255, 255, 255,0],[0,255,255,0]]),3)
 
