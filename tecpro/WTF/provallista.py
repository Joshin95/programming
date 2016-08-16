import random
import time

def llista(n):
    """
    Retorna una llista de n nombres naturals aleatoris amb valors entre 0 i 2*n
    """
    return [random.randint(0,2*n) for i in range(n)]

def ordena(a):
    """
    Retorna la llista resultant d'ordenar a aplicar ordenacio per seleccio
    """
    for c in range(len(a)):
        pmin=c
        for j in range(c+1,len(a),1):
            if a[j]<a[pmin]:
                pmin=j
        a[c],a[pmin]=a[pmin],a[c]
    return a

if __name__=='__main__':
    q=10
    for n in [100,1000,10000]:
        l=llista(n)
        print l
        z=0.0
        for c in range(q):
            print "@@@@@@@@@@@@"
            start=time.clock()
            print ordena(l)
            temps=time.clock()-start
            print temps
            print "----------------"
            z+=temps
        print "promig",z/q,"de mida",n
