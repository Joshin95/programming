===========
Mòdul split
===========

Funció split_digit
==================

La funció split_digit rep una matriu de nombres, corresponent a una imatge en blanc i negre("1") retallada per les funcions vtrim i htrim i escalada correctament. A continuació recorre la matriu fins a trobar una columna de pixels completament blancs, llabors separa en dues matrius diferents la part recorreguda  i la que queda per recorre.

.. code-block:: python

   def split_digit(img):
       """
       Retorna una tupla de amb el numero retallat i la resta de la imatge retallada
       >>> split_digit(('1', [[0,255,0,255], [0,255,0,255], [0, 255,0,255],[0,255, 0,255], [0, 255,0,255]]))
       (('1', [[0], [0], [0], [0], [0]]), ('1', [[255, 0, 255], [255, 0, 255], [255, 0, 255], [255, 0, 255], [255, 0, 255]]))
       """
       count1=1
       l=[]
       eliminada=[]
       mat=[]
       mat1=[]
       mat2=[]
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
       for c in mat: #Fins aqui transposa
           count1=0
           l=[]
           for u in c:
               e=len(c)
               if u==255:
                  count1+=1
               l+=[u]
           if count1!=e:
              eliminada+=[l]
           elif count1==e:
            	break
        k=len(eliminada)
    	nombre=mat[:k]  #Fins aqui agafa un nombre transposat
    	x1=len(nombre)
    	y1=len(nombre[0])
    	for fila in range(y1):
            f=[]
            for columna in range(x1):
            	f+=[0]
            mat1+=[f]
    	for i in range(y1):
            for j in range(x1):
            	mat1[i][j]=nombre[j][i]
    	n=("1",mat1) #Retorna el primer nombre de la matricula arreglat
    	r=mat[k:]
    	x2=len(r)
    	y2=len(r[0])
    	for fila in range(y2):
            f=[]
            for columna in range(x2):
            	f+=[0]
            mat2+=[f]
    	for i in range(y2):
            for j in range(x2):
            	mat2[i][j]=r[j][i]
        m=("1",mat2) #Retorna la resta de la imatge
    	return (n,m)

    

