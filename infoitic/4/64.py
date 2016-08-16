a=1
while a<3:
    if a%2==0:
        b=1
        while b<3:
            print "X",
            b=b+1
        print "0",
    a=a+1


print "Aquest programa acaba escribint /X X 0/ en la pantalla, ho fa perque la funcio if es TRUE quan la variable /a/ es un numero parell entre el 1 i el 3(en aquest cas nomes pot ser el 2) i llavorns defineix la variable b=1 que executa la funcio while nr.2 que excriu /X/ a la pantalla fins que la b sigui un numero mes petit que 3 i com que sempre al final del recorregut d'aquesta funcio se li suma un 1 a la variable b, nomes escriu 2 cops la X. Despres surt del bucle del while i es troba la funcio que li diu que escrigui un 0 per pantalla. Aqui s'acaba el programa perque al final d'aquest hi ha un linia que li suma un 1 a /a/ i aquesta deixa de ser parella."
