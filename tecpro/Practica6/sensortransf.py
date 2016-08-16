from dataset import *

def normalize(d,s=0):
    if s==0:
        a=0.057
        b=5.847
        return d.transform(a,b)
    elif s==1:
        a=0.323
        b=-48.63
        return d.transform(a,b)
    elif s==2:
        a=0.059
        b=-8.87
        return d.transform(a,b)
    elif s==3:
        a=0.061
        b=-9.34
        return d.transform(a,b)
    elif s==4:
        a=0.019
        b=13.27
        return d.transform(a,b)
    elif s== 5:
        a=0.019
        b=14.71
        return d.transform(a,b)

    else:
        return "Numero del sensor incorrecte"
