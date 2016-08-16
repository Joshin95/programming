from exllarg import *
opcio=opcioCorrecta()
while opcio=='1':
    print "Opcio triada" ,opcio
    if opcio=='1':
        paraula=paraulaCorrecta()
        natejarPantalla()
        oculta='@'*len(paraula)
        while paraula!=oculta:
            print "Paraula a endevinar"
            print oculta
            c=comprovaCaracterOk()
            c=c.lower()
            oculta=actualitzaOculta(paraula,c,oculta)
            print "La paraula es: ", paraula
            print "Molt be!"
            print "Tria un altre cop al opcio"
        opcio=opcioCorrecta()
