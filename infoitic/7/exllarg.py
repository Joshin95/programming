import string

def menuOpcions():
    """
    printa per pantalla menu opcions
    """
    print "1. Inici partida"
    print "0. Sortir"

def checkOpcio(dada):
    """
    retorna True si dada correspon a opcio 1 i 0
    >>> checkOpcio('01')
    False
    >>> checkOpcio('aba')
    False
    >>> checkOpcio('0')
    True
    >>> checkOpcio('1')
    True
    """
    return len (dada)==1 and (dada=='0' or dada=='1')

def opcioCorrecta():
    """
    Demana opcions a l'usuari fins que es tracta d'una opcio correcta i retorna l'opcio triada
    """
    t=False
    while not t:
        menuOpcions()
        opcio=raw_input("Entri opcio: ")
        t=checkOpcio(opcio)
    return opcio


def checkParaula(p):
    """
    retorna True si p esta formada unicament per lletres de l'alafabet
    >>>checkParaula('info@avui')
    False
    >>>checkParaula('dada12')
    False
    >>>checkParaula('aula info')
    False
    >>>checkParaula(('informatica')
    True
    """
    for l in p:
        if l not in string.letters:
            t=False
            break
    else:
        t=True
    return t

def paraulaCorrecta():
    """
    Demana paraules fins que no sigui una paraula correcta i retorna la paraula correcta
    """
    t=False
    while not t:
        paraula=raw_input("Introdueixi paraula: ")
        t=checkParaula(paraula)
        if not t:
            print "La paraula conte algun caracter no alfanumeric"
    return paraula


def natejarPantalla():
    """
    Escriu 25 linies en blanc
    """
    for i in range(25):
        print 
    
def comprovaCaracter(lletra):
    """
    retorna True si es una lletra de l'alfabet
    """

    return lletra in string.letters and len(lletra)==1


def comprovaCaracterOk():
    """
    Demana lletres dins que no sigui una de l'alfabet i retorna la lletra
    """
    t=False
    while not t:
        c=raw_input("Introdueixi lletra a comprovar: ")
        t=comprovaCaracter(c)
        if not t:
            print "La lletra no es de l'alfabet"
    return c

def actualitzaOculta(paraula,c,oculta):
    """
    retorna la paraula resultant d'actualitazr oculta
    >>> actualitzaOculta('informatica','i','@@@@@@@@@@@')
    'i@@@@@@@i@@'
    >>> actualitzaOculta('informatica','a','i@@@@@@@i@@')
    'i@@@@@a@i@a'
    """
    s=''
    i=0
    for lletra in paraula:
        if lletra==c:
            s+=c
        else:
            s+=oculta[i]
        i+=1
    return s
