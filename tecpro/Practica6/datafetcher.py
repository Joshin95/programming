from urllib2 import *
import csv
from datetime import *
from dataset import DataSet

class DataSetFetcher(object):

    def __init__(self,url='http://localhost:8000'):
        self.url=url

    def fetch(self,dia,sensor=0):
        try:
            dades="/dades_"+dia.strftime("%y")+"_"+dia.strftime("%m")+"_"+dia.strftime("%d")
            fitxer=urlopen(self.url+dades)
            reader=csv.reader(fitxer)
            dataset=DataSet("Sensor "+str(sensor))
            for row in reader:
                #print "@@@@@@@@@@@@@@@@@@@@@@@@@2"
                #print row
                #print sensor
                #print "@@@@@@@@@@@@@@@@@@@@@2"
                if row[1]==str(sensor):
                    time_r=row[0].split(':')
                    dataset.add(time(int(time_r[0]),int(time_r[1]),int(time_r[2])), float(row[2]))
        
        except:
            raise UnknownDataSetException()

        return dataset
"""
    def fetch_interval(self,from_day,to_day,sensor=0):
        #try:
        t=[]
        v=[]
        print to_day
        dataset=DataSet("Sensor "+str(sensor))
        while from_day<to_day:
            print "@@@@@@@@@@"
            print from_day
            t.append(self.fetch(from_day,sensor).time_vector)#com fer pk no retorni un objecte??
            v.append(self.fetch(from_day,sensor).time_value)# el mateix
            from_day=date(int("20"+(from_day.strftime("%y"))),int(from_day.strftime("%m")),int(str(int(from_day.strftime("%d"))+1)))
        #except:
            #raise UnknownDataSetException()
       
        return dataset
"""

def fetch_interval(self,from_day,to_day,sensor=0):
    dataset=DataSet("Sensor "+str(sensor))
    while from_day<to_day:
        
        from_day=date(int("20"+(from_day.strftime("%y"))),int(from_day.strftime("%m")),int(str(int(from_day.strftime("%d"))+1)))
        
class UnknownDataSetException(Exception):

    pass


"""
if __name__=="__main__":
    dfe=DataSetFetcher('http://ohm.upc.es/sensor/')
    #print dfe.fetch(date(2013,9,18),1)
    #dfe.fetch_interval(date(2013,9,18),date(2013,9,20),1)
    
"""
