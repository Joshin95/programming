"""
Aquest modul s'ocupa de crear objectes de productes
"""

class Producte(object):
    """
    Aquesta simple classe s'ocupa de la generacio del objecte producte
    """

    def __init__(self,nom):
        """
        Metode constructor que emmagatzema el nom del producte
        """
        self.nom=nom

    def __str__(self):
        """
        Metode especial que mostra el nom del producte
        """
        return str(self.nom)

    def getName(self):
        """
        Aquest metode retorna el nom del objecte
        """
        return self.nom

