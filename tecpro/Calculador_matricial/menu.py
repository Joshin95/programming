from matriu import *
z=-20
while z!=0:
    print "Benvingut al calculador matricial"
    print
    print "Menu"
    print "1.Llegir matriu A"
    print "2.Llegir matriu B"
    print "3.Calcular A+B"
    print "4.Calcular A*B"
    print "5.Calcular det(A)"
    print "6.Calcular A-B"
    print "7.Test de simetria"
    print "8.Calcular la transposada"
    print "9.Calcular inversa"
    print "0.Sortir"
    
    z=input("Escolleixi una opcio del menu: ")
    if z==1:
        f=input("Introdueixi el nombre de files: ")
        c=input("Introdueixi el nombre de columnes: ")
        ma=llegirMatriu(f,c)
        a=escriureMatriu(ma)
        a
    elif z==2:
        f=input("Introdueixi el nombre de files: ")
        c=input("Introdueixi el nombre de columnes: ")
        mb=llegirMatriu(f,c)
        b=escriureMatriu(mb)
        b
    elif z==3:
        f=input("Introdueixi el nombre de files de la primera matriu: ")
        c=input("Introdueixi el nombre de columnes de la primera matriu: ")
        ma=llegirMatriu(f,c)
        f=input("Introdueixi el nombre de files de la segona matriu: ")
        c=input("Introdueixi el nombre de columnes de la segona matriu: ")
        mb=llegirMatriu(f,c)
        o=sumaMatrius(ma,mb)
        suma=escriureMatriu(o)
        suma
    elif z==4:
        f=input("Introdueixi el nombre de files de la primera matriu: ")
        c=input("Introdueixi el nombre de columnes de la primera matriu: ")
        ma=llegirMatriu(f,c)
        f=input("Introdueixi el nombre de files de la segona matriu: ")
        c=input("Introdueixi el nombre de columnes de la segona matriu: ")
        mb=llegirMatriu(f,c)
        p=multiplicarMatrius(ma,mb)
        multiplicacio=escriureMatriu(p)
        multiplicacio
    elif z==5:
        f=3
        c=3
        ma=llegirMatriu(f,c)
        w=det3(ma)
        print w
    elif z==6:
        f=input("Introdueixi el nombre de files de la primera matriu: ")
        c=input("Introdueixi el nombre de columnes de la primera matriu: ")
        ma=llegirMatriu(f,c)
        f=input("Introdueixi el nombre de files de la segona matriu: ")
        c=input("Introdueixi el nombre de columnes de la segona matriu: ")
        mb=llegirMatriu(f,c)
        q=restaMatrius(ma,mb)
        escriureMatriu(q)
    elif z==7:
        f=input("Introdueixi el nombre de files: ")
        c=input("Introdueixi el nombre de columnes: ")
        ma=llegirMatriu(f,c)
        simetria(ma)
    elif z==8:
        f=3
        c=3
        ma=llegirMatriu(f,c)
        sd=transposada(ma)                    
        sd
        escriureMatriu(sd)
        
    elif z==9:
        f=3
        c=3
        ma=llegirMatriu(f,c)
        pl=inversa(ma)
        escriureMatriu(pl)

print
print "Fi del programa"

       
