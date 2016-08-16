"""
Aquest modul s'ocupa de la gestio de les receptes

"""
from producte import Producte

class Recepta(object):
    """
    Aquesta classe emmagatzema una llista de tuples de productes i les seves quantitats i despres les gestiona

    """
    def __init__(self,nom):
        """
        Metode constructor que genera una llista buida
        """
        self.nom=nom
        self._ingredients=[]

    def getNom(self):
        """
        Aquest metode retorna el nom de la recepta
        """
        return self.nom

    def getIng(self):
        """
        Aquest metode retorna la tupla del producte amb la seva quantitat total
        """
        return self._ingredients

    def afegeix_ingredients(self,p,q):
        """
        Metode modificador que afegeix q grams del producte p a la recepta, si el producte ja existeix suma les quantitats
        """
        t=(Producte(p),q)
        if self._ingredients==[]:
            self._ingredients+=[t]
        else:
            count=0
            for c in self._ingredients:
                if p==c[0].nom:
                    a=list(c)
                    a[1]+=q
                    w=tuple(a)
                    self._ingredients[count]=w
                    #print self._ingredients[count][0].tostring()+" "+str(self._ingredients[count][1])
                    count+=1
                    break
            else:
                self._ingredients+=[t]

    def conte_ingredients(self,p):
        """
        Aquest metode retorna True si la recepta conte l'ingredient p
        """
        f=False
        if self._ingredients==[]:
            print "La recepta no conte cap ingredient actualment"
        else:
            for c in self._ingredients:
                if p==c[0].nom:
                    f=True
                    break
        return f

    def quantitat_ingredient(self,p):
        """
        Aquest metode retorna la quantitat total del producte p
        """
        if self._ingredients==[]:
            print "La recepta no conte cap ingredient actualment"
        else:
            for c in self._ingredients:
                print p.nom,c[0].nom
                if p==c[0].nom:
                    a=c[1]
                    break
            else:
                a=0
        return a

    def pes_total(self):
        """
        Aquest metode retorna el pes total de tots els ingredients de la recepta
        """
        a=0
        if self._ingredients==[]:
            print "La recepta no conte cap ingredient actualment"
        else:
            for c in self._ingredients:
                a+=c[1]
            return a

    def ingredients(self):
        """
        Aquest metode retorna una lliste de tots els ingredients de la recepta
        """
        y=[]
        if self._ingredients==[]:
            print "La recepta no conte cap ingredient actualment"
        else:
            for c in self._ingredients:
                y+=[c[0].nom]
            return y

    def __eq__(self,other):
        """
        Metode especial que genera la igualtat de 2 objectes
        """
        return self.getNom()==other.getNom()

    def __str__(self):
        """
        Metode especial que mostra tots el ingredients del objecte
        """
        print self.nom
        for c in self._ingredients:
            print c[0].nom,c[1]
        return ""
                    
        
        
