import urllib2
import csv #llibreria per al tractament de dades amb dades separades per coma
fdades="dades_11_08_01"
f=urllib2.urlopen('http://localhost:8000/'+fdades) #es com obrir amb open de fitxer normal
dades=csv.reader(f)
for linia in dades:
    print linia
f.close()

