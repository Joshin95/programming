=====================
Estructura de Python
=====================

:autors: Grzegorz Marek Szymanski i Sergi Torrabadella Faucon

Llistes
=======

Les llistes són elements molt útils en la programació en el llenguatge de programació de Python. Són elements mutables, es a dir, que podem variar el seu contingut sense utilitzar cap comanda per a transformar-les prèviament, i això ho podem fer mitjançant función predeterminades de python o pròpies funcions dissenyades pel programador.
Anem a coneixer algunes de les comandes més útils per a l'ús de les llistes:

     * Crear una llista buida: es fa utilitzant dos claudators assignats a una variable, com podem veure a continuació. 

     .. code-block:: python
     
	l=[]
     
     * Afegir elements a una llista: es pot fer de diferents maneres, mitjançant una funció interna de python o amb un signe de +, com podem veure a continuació:

     .. code-block:: python
     	
	l=[]
	l+=[2]
	l+=[3]
	print l

Un cop tenim una llista amb dades, el més interessant és la manera d'accedir-hi, anem a coneixer els diferents metodes de iteració de llistes:

   * Utilitzant un bucle for, amb la següent sintaxi:

   .. code-block:: python

      l=[2,3,4]
      for c in l:
      	  print c
      "El resultat seria:"
      2
      3
      4

   * Utilitzant funcions predeterminades de python:
     
     - Enumerate: Aquesta funció de python recorre cada element de la llista, guardant així, la posició i el valor de cadascun dels elements de la llista. En tenim un exemple a continuació:

     .. code-block:: python

     	l=[2,3,4]
	for p,v in enumerate(l):
	    print p,v
	
	"El resultat seria:"
	0 2
	1 3
	2 4

     - Index: Retorna la primera posició on apareix l'element introduit prèviament. Funciona de la següent manera:
     
     .. code-block:: python
     	
	l=[2,3,4]
	s=l.index(3)
	print s
	
	"El resultat seria:"
	1

     - Count: Retorna el nombre de vegades que apareix l'element introduit a dintre d'una llista. Vegem un exemple de execució:
     
     .. code-block:: python
     		  
	l=[2,3,4,2]
	s=l.count(2)
	print s
	
	"El resultat seria:"
	2

     - Sort: Ordena el elements de la llista per ordre alfabetic o numèricament. Tenim un exemple a continuació:
     
     .. code-block:: python

     	l=[3,5,1]
	s=l.sort()
	print s
	
	"El resultat seria:"
	[1,3,5]

Aquests són algunes de les funcions que estan predefinides al python per facilitar la feina, totes elles es poden consultar la pagina web principal de python en la secció de llistes. Aqui teniu l'enllaç directe: http://docs.python.org/2/tutorial/datastructures.html

	         	
	 
   
   
	
