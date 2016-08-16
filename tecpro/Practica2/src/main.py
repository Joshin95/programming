"""
Aquest modul es el programa principal que es el que gestiona el funcionament de tots els altres moduls. Inicialment crea instancies del "Receptari" i del "Interpret" i despres les gestiona
"""

from producte import Producte
from recepta import Recepta
from receptari import Receptari
from interpret import Interpret

def producte(l):
    """
    Funcio que afegeix un producte al receptari r
    """
    r.afegeix_producte(l)

def recepta(l):
    """
    Funcio que afegeix una recepta al receptari r
    """
    r.afegeix_recepta(l)

def ingredient(l):
    """
    Funcio que li afegeix un ingredient a una recepta
    """
    r.afegeix_ingredient_recepta(l[0],l[1],l[2])

def mostra(l):
    """
    Printa per pantalla els productes, receptes, ingredients d'una recepta i receptes on es troba un producte
    """
    if l=="receptes":
        print r.receptes()
    elif l=="productes":
        print r.ingredients()
    elif l[0]=="recepta":
        print r.recepta(l[1])
    elif l[0]=="receptes-ing":
        print r.receptes_ingredients(l[1])

print ""
print ""
print ""
print ""
print ""
print "Benvingut al gestor de receptes de cuina creat pel Gregor i Sergi"
print ""
print ""
print "producte <nom> - Afegeix un producte al receptari que te nom <nom>."
print ""
print "recepta <nom> - Afegeix una recepta al receptari que te nom <nom>."
print ""
print"ingredient <nomp> <nomr> <qua> - Afegeix <qua> grams de l'ingredient de nom <nomp> a la recepta de nom <nomr>."
print ""
print "print <ent> [<nom>] - Escriu per pantalla segons el valor de <ent>. Si <ent> es:"
print "     -productes - Escriu la llista de noms de producte del receptari."
print "     -recepta - Escriu els ingredients i la quantitat que intervenen en la recepta de nom <nom>."
print "     -receptes-ing - Escriu la llista de noms de recepta en les que participa l'ingredient anomenat <nom>."
print ""
print "surt - Surt del programa"





i=Interpret()
r=Receptari()
i.set_prompt("** ")
i.afegeix_ordre("producte",producte)
i.afegeix_ordre("recepta",recepta)
i.afegeix_ordre("ingredient",ingredient)
i.afegeix_ordre("print",mostra)
i.run()

