================
Títol principal
================

:author: Pere Pi

Apartat
=======

Aquests el primer apartat. Escriviu-lo així com el veieu aquí.
Fixeu-vos que, com en Python, les tabulacions són molt importants atès
que determinen l’estructura del document.

Subapartat
----------
També podeu escriure enumeracions i llistes convencionals usant una 
sintaxi molt natural com la que segueix:

    * Primer element
    * Segon element
      - Primera subllista
      - Segona subllista
    * Tercer element

Una altra facilitat molt corrents la de poder inserir codi o exemples
programació d’una forma senzilla i elegant com per exemple:

.. code-block:: python

   def exemple(a,b):
      """
      Una funció per exemplificar reST
      """
      x=a
      for i in b:
           if i%2==0: x+=a
      return x
