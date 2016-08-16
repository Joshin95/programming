import matplotlib.pyplot as plt
import matplotlib.dates as dat
from dataset import DataSet
from datafetcher import DataSetFetcher
from datetime import *
from sensortransf import normalize


class DataSetPlot(object):

    def __init__(self):
        self.graf=plt.figure("Gafica dels sensors")
        self.titol=plt.title("Grafica dels sensors")
        self.x=plt.xlabel('Temps')
        self.y=plt.ylabel('Valors de Temperatura')

    def plot(self,d):
        x=d.time_vector()
        y=d.value_vector()
        l=[]
        for z in range(len(x)):
            l+=[z]
        plt.xticks(range(len(x)),d.time_vector(),rotation=45)
        plt.plot(l,y,label=str(d.GetName()))
        plt.legend(loc='upper right')
        
    def show(self):
        
        plt.show()
"""
if __name__=='__main__':
    a=DataSetPlot()
    df=DataSetFetcher('http://ohm.upc.es/sensor/')
    dia=date(2013,9,18)
    dia2=date(2013,8,19)
    ds=df.fetch(dia,3)
    ds=normalize(ds,3)
    #print ds
    ds2=df.fetch(dia,2)
    ds2=normalize(ds2,2)
    #a.plot(ds)
    #a.plot(ds2)
    #a.show()
"""
