import Image
def load_patterns(prefix):
    nombres=[]
    for c in range(10):
        nomf=prefix+"_"+str(c)+".jpeg"
        image=Image.open(nomf).convert('1')
        pix=image.load()
        X=image.size[0]
        Y=image.size[1]
        data=[[pix[x,y] for x in range(X)] for y in range(Y)]
        nombres+=[data]
    return nombres



#patro="patro"
#patlst=load_patterns(patro)


def match(img,patlst):
    similar=[]
    imatge=img[1]
    x=len(imatge)
    y=len(imatge[0])
    imatget=[]
    for fila in range(y):
            f=[]
            for columna in range(x):
                f+=[0]
            imatget+=[f]
    for i in range(y):
            for j in range(x):
                imatget[i][j]=imatge[j][i]
    valormesgran=0
    filimatge=len(imatget)
    for a in range(10):
        llistapatro=[]
        numero=patlst[a]
        xn=len(numero)
        yn=len(numero[0])
        numerot=[]
        for fila in range(yn):
            f=[]
            for columna in range(xn):
                f+=[0]
            numerot+=[f]
        for i in range(yn):
            for j in range(xn):
                numerot[i][j]=numero[j][i]
        filpatro=len(numerot)  #files patro
        repeticions=filimatge-filpatro #numero de superoposicions del patro a la imatge fins arribar al final de la imatge - diferencia de columnes entre imatge i patro
        for b in range(repeticions+1):
            comparacio=0
            final=filpatro+b
            llistaimg=[]
            llistapatro=[]
            for c in numerot:
                for d in c:
                    llistapatro+=[d]
            for e in imatget[b:final]:                   #imatge d'entrada definida com (1,[[]])
                for f in e:
                    llistaimg+=[f]
            for i,j in enumerate(llistapatro):
                if j==llistaimg[i]:
                    comparacio+=1
                if comparacio>=valormesgran:
                    valormesgran=comparacio
                    similar=a

    return similar

 
#print match(("1",patlst[9]),patlst)

             
                 
        
             
                    
                    
            
    






    
