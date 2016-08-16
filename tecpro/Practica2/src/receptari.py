"""
Aquest modul s'ocupa de la gestio de les receptes i productes i de guardar tot el contingut en diferents diccionaris
"""

from producte import Producte
from recepta import Recepta

class Receptari(object):
    """
    Aquesta classe gestiona els diccionaris on es guarden els productes i les receptes
    """

    def __init__(self):
        """
        Metode contructor que genera dos diccionaris buits 
        """
        self._receptes={}
        self._productes={}

    def __eq__(self,other):
        """
        Metode especial que crea la igualtat directe de dos objectes
        """
        return self.getNom()==other.getNom() 

    def afegeix_recepta(self,n):
        """
        Metode modificador que afegeix l'objecte recepta de nom n al diccionari
        """
        if n in self._receptes:
            print "La recepta ja hi es"
        else:
            self._receptes[n]=Recepta(n)

    def afegeix_producte(self,nomp):
        """
        Metode modificador que afegeix l'objecte producte de nom p al diccionari
        """
        if nomp in self._productes:
            print "El producte ja hi es"
        else:
            self._productes[nomp]=Producte(nomp)

    def afegeix_ingredient_recepta(self,nomp,nomr,q):
        """
        Aquest metode Afegeix q grams del ingredient nomp a la recepta nomr
        """
        if nomr not in self._receptes and nomp not in self._productes:
            print "La recepta o el producte no existeixen"
        else:
            self._receptes[nomr].afegeix_ingredients(Producte(nomp),q)

    def receptes_ingredients(self,nomp):
        """
        Aquest metode retorna la llista de receptos on s'hi troba el producte nomp
        """
        l=[]
        for k,v in self._receptes.items():
            for c in v.getIng():
                if nomp==str(c[0]):
                    l+=[k]
        return l

    def receptes(self):
        """
        Aquest metode retorna la llista de totes les receptes del receptari
        """
        return self._receptes.keys()

    def ingredients(self):
        """
        Aquest metode retorna la llista de tots els ingredients del receptari
        """
        return self._productes.keys()

    def recepta(self,nomr):
        """
        Aquest metode retorna una llista de tuples on cada d'elles conte un ingredient i la seva quantitat de la recepta nomr
        """
        return self._receptes[nomr]
