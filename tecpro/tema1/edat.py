class Persona(object):
    def __init__(self,n,d):
        self.nom=n
        self.data=d
    def obtenir_nom(self):
        return self.nom
    def obtenir_data(self):
        return self.data
    def edat(self):
        x=self.data
        l=x.split("/")
        n=int(l[2])+1900
        return 2014-n

#p=Persona("Maria","27/10/84")
#print p.nom
#print p.data
#print p.edat()
