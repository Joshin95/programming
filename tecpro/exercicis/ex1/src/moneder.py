"""
Aquest modul intenta imitar el comportament d'un moneder que pot emmagatzemar monedes d'un i dos euros i billets de 5 euros
"""

class moneder(object):
    """
    Aquesta classe es el conjunt de metodes que es poden fer amb un moneder
    """
    def __init__(self,n1,n2,n3):
        self._d={1:n1,2:n2,5:n3}
    def obteMonedes1(self):
        """
        El metode retorna la quantitat de monedes d'un euro
        """
        return self._d[0]
    def obteMonedes2(self):
        """
        El metode retorna la quantitat de monede de dos euros
        """
        return self._d[1]
    def obteMonedes5(self):
        """
        El metode retorna la quantitat de billets de cinc euros
        """
        return self._d[2]
    def canviarMonedes1(self,q):
        """
        El metode afegeix la quantitat q de monedes d'un euro
        """
        self._d[0]+=q
    def canviarMonedes2(self,q):
        """
        El metode afegeix la quantitat q de monedes de dos euros
        """
        self._d[1]+=q
    def canviarMonedes5(self,q):
        """
        El metode afegeix la quantitat q de billets de cinc euros
        """
        self._d[2]+=q
    def obteDiners(self):
        """
        El metode retorna la quantitat total de diners en el moneder
        """
        return sum(int(k)*int(v) for k,v in self._d.items())
    def afegeixMonedes(self,s):
        """
        El metode afegeix els diners del moneder 's' a unaltre moneder
        """
        for clau in self._d:
            self._d[clau]+=s._d[clau]

    def buidarMoneder(self):
        """
        El metode buida el moneder
        """
        for k in self._d.keys():
            self._d[k]=0


#m=moneder(10,10,10)
#print m.obteDiners()
#s=moneder(15,15,15)
#m.afegeixMonedes(s)
#print m.obteDiners()
