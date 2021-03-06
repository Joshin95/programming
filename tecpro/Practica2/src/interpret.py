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
        a=86
        while a!="surt":
            l=[]
            a=raw_input(str(self._prompt))
            b=a.split(" ")
            l=b[1:]
            if a!="surt":
                if b[0] not in self._dcom.keys():
                    print "Ordre no trobada"
                else:
                    if len(l)==0:
                        print "Falten dades"
                    elif len(l)==1:
                        self._dcom[b[0]](l[0])
                    elif len(l)==2:
                        self._dcom[b[0]]([l[0],l[1]])
                    elif len(l)==3:
                        self._dcom[b[0]]([l[0],l[1],l[2]])
