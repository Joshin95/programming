class algu(object):
    def __init__(self,nom,numero):
        self.nom=nom
        self.numero=numero
    def getNom(self):
        return self.nom

def getNum(algu):
    return algu.numero

listaobj=[algu("maria",23),algu("anna",73),algu("marc",7)]
x=sorted(listaobj,key=getNum)

for c in x:
    print c.getNom()

#la funcio sorted() ens ordena objectes segons la "key" que li posem

