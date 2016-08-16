import urllib2
import csv
fdades="dades_11_08_01"
f=urllib2.urlopen("http://localhost:8000/"+fdades)
dades=csv.reader(f)
for linia in dades:
    print linia

f.close()
