import match
from sys import *
import imgio
import discret
import transf1
import split

x=argv
prefix=x[1]
nomf=x[2]
patrons=match.load_patterns(prefix)   #pas1.AQUI TENIM ELS PATRONS
#print patron
imgrgb=imgio.read_rgb(nomf)      #pas2.Aqui tenim la imatge de la matricula
#print imgrgb
imgbn=discret.rgb_to_bn(imgrgb)  #pas3.convertir matricula a blanc i negre, correcto
#print imgbn
vertical=transf1.vtrim(imgbn)     #pas4. tallar verticalment
#print vertical
horitzontal=transf1.htrim(vertical) #pas4.tallar horitzontalment
#print horitzontal
escalada=transf1.scale(horitzontal,64) #pas5.escalar
#print escalada
#print imgio.show(escalada)
l=[]
numero=split.split_digit(escalada)
numero5=numero[0]
resta=numero[1]
#print imgio.show(numero5)
a=transf1.htrim(resta)
numero=split.split_digit(a)
numero1=numero[0]
resta=numero[1]
#print imgio.show(numero1)
a=transf1.htrim(resta)
numero=split.split_digit(a)
numero3=numero[0]
#print imgio.show(numero3)
resta=numero[1]
a=transf1.htrim(resta)
#print imgio.show(a)

l=[numero5,numero1,numero3,a]

e=match.match(numero5,patrons)
r=match.match(numero1,patrons)
t=match.match(numero3,patrons)
y=match.match(a,patrons)
print "Benvingut, la seva matricula es:", e,r,t,y
