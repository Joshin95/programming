class fraccio(object):
    def __init__(self,n,d):
        self.n=n
        self.d=d
    def sumaFrac(self,x):
        den=self.d*x.d
        num=(self.n*x.d)+(x.n*self.d)
        return fraccio(num,den)
    def divisio(self,x):
        num=self.n*x.d
        den=self.d*x.n
        return fraccio(num,den)
    def obtenirNum(self):
        return self.n
    def obtenirDen(self):
        return self.d

f1=fraccio(1,2)
f2=fraccio(2,3)
f3=f1.divisio(f2)
n1=str(f3.obtenirNum())
n2=str(f3.obtenirDen())

#print "El resultat es ",n1,"/",n2 
