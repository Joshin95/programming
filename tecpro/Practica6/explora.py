from datetime import date, datetime, timedelta  
from datafetcher import DataSetFetcher
from dsplot import DataSetPlot
from sensortransf import *
from sys import argv
from dataset import DataSet

plot=DataSetPlot()
algu=argv[1:]
algu="".join(algu)
dataf=""
if "-f" in algu:
    dataf=algu.split("-f")[1]
if "-s" and "-v" and "-d" in algu:
    url=algu.split("-v")[1].split("-s")[0]
    sensor=algu.split("-s")[1].split("-d")[0].split(",")
    datai=algu.split("-d")[1].split("-f")[0]
    datai=datai.split("/")
    dataidate=date(int(datai[2]),int(datai[1]),int(datai[0]))
    if dataf=="":
        for c in sensor:
            dsf=DataSetFetcher(str(url))
            datasen=dsf.fetch(dataidate,int(c))
            datasen=normalize(datasen,int(c))
            plot.plot(datasen)
    elif dataf=="":
        dataf=dataf.split("/")
        datafdate=date(int(dataf[2]),int(dataf[1]),int(dataf[0]))
        for c in sensor:
            dsf=DataSetFetcher(str(url))
            datasen=dsf.fetch_interval(dataidate,datafdate,int(c))
            datasen=normalize(datasen,int(c))
            plot.plot(datasen)
else:
    print "Format de crida incorretce"
    exit()


plot.show()
