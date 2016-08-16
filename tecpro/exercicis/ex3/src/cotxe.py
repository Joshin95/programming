"""
Aquest modul s'ocupa de crear cotxes per despres enviar-los cap al garatge i manipular-los
"""
class Cotxes(object):
    """
    Aquesta classe intenta simular les caracteristiques d'un cotxe per poder gestionar-lo
    """
    def __init__(self,matricula,model,color,motor):
        self._l=[matricula,model,color,motor]
    def getMatricula(self):
        """
        Aquest metode retorna la matricula del cotxe
        """
        return self._l[0]
    def getModel(self):
        """
        Aquest metode retorna el model del cotxe
        """
        return self._l[1]
    def getColor(self):
        """
        Aquest metode retorna el color del cotxe
        """
        return self._l[2]
    def getMotor(self):
        """
        Aquest metode retorna la informacio sobre el motor del cotxe
        """
        return self._l[3]
    def mostraCotxe(self):
        """
        Aquest metoda retorna totes les caracteristiques del cotxe
        """
        return str(self._l[0])+" "+str(self._l[1])+" "+str(self._l[2])+" "+str(self._l[3])
                     
