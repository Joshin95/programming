"""
Aquest modul crea un interpret d'ordres que de forma interactiva, llegeix ordres de l'usuari i les va executant una a una.
"""

class Interpret(object):
    """
    Aquesta classe conte tota l'estructura interna del interpret i es la que fa referencia als altres moduls
    """
    def __init__(self):
        """
        Metode constructor que crea un interpret buit preparat per afegir-hi ordres
        """
        self._prompt=""
        self._dcom={}

    def set_prompt(self,p):
        """
        Metode modificador que posa el string p com el prompt de l'interpret
        """
        self._prompt=p

    def getd(self):
        """
        Metode que retorna el diccionari d'ordres
        """
        return self._dcom

    def afegeix_ordre(self,nomc,ordre):
        """
        Metode modificador que afegeix al diccionari una ordre de clau nomc amb el valor ordre
        """
        if nomc in self._dcom.keys():
            print "L'ordre ja existeix"
        else:
            self._dcom[str(nomc)]=ordre
            
    def run(self):
        """
        Metode que executa a l'interpret i crida altres funcions emmagatzemades en el diccionari
        """
	print ""
	print "--------------------------------------------"
	print "Welcome to the semaphore crossing controller"
	print "--------------------------------------------"
	print ""
	print "Enter <HELP> to see the available functions"
	print ""
        a=-1
        while a!="EXIT":
            l=[]
	    print "Introduce a function: "
            a=raw_input(str(self._prompt))
            b=a.split(" ")
            l=b[1:]
            if a!="EXIT":
                if b[0] not in self._dcom.keys():
                    print "Function undefined"
                else:
                    self._dcom[b[0]]()
                    
	print "Thanks for using the semaphore crossing controller"
