# -*- coding: utf-8 -*-

#FALTA extract_field_s



class BitVector(object):
    """
    Aquesta clase representa una paraula binària de mida arbritrària però menor o igual a 16 bits que s'interpreta sempre sense signes.
    """
    
    def __init__(self,w=0):
        mask=2**(len(self))-1
        self._w=w&mask
    
    def extract_field_u(self,mask): #Entendre
        """
        Facilita l’extracció de camps d’una paraula. Donada una màscara mask que indica un subconjunt de bits de la paraula self, aquest mètode retorna l’enter sense signe representat per aquest subconjunt de bits.
        """
        a=0
        for i in range(15,-1,-1):
            if mask & 2**i != 0:
                a=(a<<1)+((self._w & 2**i)>>i)
        return a

    def extract_field_s(self,mask): #Acabar
        """
        Fa exactament el mateix que el mètode anterior però interpreta el resultat com un enter amb signe.
        """
        pass

    def __int__(self): 
        """
        Torna el valor enter corresponent a self interpretat sempre com a valor sense signe.
        """
        return int(self._w)

    def __index__(self):
        """
        Torna el mateix que en el mètode anterior.
        """
        return int(self._w)

    def __repr__(self):
        """
        Torna la representació en hexadecimal del valor del BitVector. Cal tenir en comptea llargada de la paraula i escriure sempre el nombre de dígits corresponents.
        """
        if len(self)==8:
            return '{0:02X}'.format(self._w)
        else:
            return '{0:04X}'.format(self._w)

    def __add__(self,o):
        """
        Suma paraules. Retorna sempre un objecte de la mateixa classe que self.
        """
        suma=int(self)+int(o)
        if isinstance(self,Byte):
            return Byte(suma)
        elif isinstance(self,Word):
            return Word(suma)

    def __sub__(self,o):
        """
        Resta paraules. Retorna sempre un objecte de la mateixa classe que self.
        """
        resta=int(self)-int(o)
        if isinstance(self,Byte):
             return Byte(resta)
        elif isinstance(self,Word):
             return Word(resta)

    def __and__(self,o):
        """
        Implementa l'operació AND bit a bit. El mètode retorna un objecte de la mateixa classe que self.
        """
        andlogic=int(self)&int(o)
        if isinstance(self,Byte):
            return Byte(andlogic)
        elif isinstance(self,Word):
            return Word(andlogic)

    def __or__(self,o):
        """
        Implementa l'operació OR bit a bit. El mètode retorna un objecte de la mateixa classe que self.
        """
        orlogic=int(self)|int(o)
        if isinstance(self,Byte):
            return Byte(orlogic)
        elif isinstance(self,Word):
            return Word(orlogic)

    def __xor__(self,o):
        """
        Implementa l'operació XOR bit a bit. El mètode retorna un objecte de la mateixa classe que self.
        """
        xor=int(self)^int(o)
        if isinstance(self,Byte):
            return Byte(xor)
        elif isinstance(self,Word):
            return Word(xor)

    def __invert__(self):
        """
        Implementa l'operació NOT bit a bit. El mètode retorna un objecte de la mateixa classe que self.
        """
        notlogic=~(self._w)
        if isinstance(self,Byte):
            return Byte(notlogic)
        elif isinstance(self,Word):
            return Word(notlogic)

    def __lshift__(self,i):
        """
        Implementa l'operació de rotació cap a l'esquerra. El mètode retorna un objecte de la mateixa classe que self.
        """
        if i<=len(self):
            self._w=self._w<<i
            return type(self)(self._w)
        else:
            raise IndexError()

    def __rshift__(self,i):
        """
        Implementa l'operació de rotació cap a la dreta. El mètode retorna un objecte de la mateixa classe que self.
        """
        if i<=len(self):
            self._w=self._w>>i
            return type(self)(self._w)
        else:
            raise IndexError()

    def __eq__(self,o):
        """
        Implementa la igualtat. Cal tenir en compte que per decidir si dos BitVector són iguals només s'han de considerar els bits inclosos dins la mida de la paraula.
        """
        return int(self)==int(o)
    
    def __ne__(self,o):
        """
        Implementa la desigualtat. Cal tenir en compte que per decidir si dos BitVector són iguals només s'han de considerar els bits inclosos dins la mida de la paraula.
        """
        return int(self)!=int(o)
    
    def __getitem__(self,i): 
        """
        Permet implementar l'accés als bits d'una paraula individualment.
        En cas que l'índex emprat superi la mida de la paraula, és llença l'excepció KeyError.
        """
        if i<=len(self)-1:
            mask=1<<i
            item=self._w&mask
            return bool(item)
        else:
            raise KeyError()


    def __setitem__(self,i,v): 
        """
        Permet implementar el canvi de bits d'una paraula individualment.
        En cas que l'índex emprat superi la mida de la paraula, és llença l'excepció KeyError.
        """
        if i<=len(self)-1:
            c=1<<i
            if v==0:
                notc=~(c)
                self._w=self._w&notc
            else:
                self._w=self._w|c
        else:
            raise KeyError()

class IndexError(Exception):
    """
    Excepció que s'aixeca en cas de que l'index estigui fora de rang en el cas de les rotacions
    """
    pass

class KeyError(Exception):
    """
    Excepció que s'aixeca en cas de que l'index estigui fora de rang en del get i set.
    """
    pass


class Byte(BitVector):
    """
    Representa una paraula de 8 bits, és a dir, un byte. La seva superclasse és BitVector i no té atributs propis.
    """
    
    def __len__(self):
        """
        Sempre torna l'enter 8 ja que un byte té una amplada de 8 bits.
        """

        return 8
    
    def concat(self,b): 
        """
        Concatena self amb el Byte b i retorna un objecte de classe Word. S'ha de tenir en compte que self és el MSB i b el LSB.
        """
        a=self._w<<8
        conc=a+b
        return Word(conc)


class Word(BitVector):
    """
    Representa una paraula de 16 bits. La seva superclasse és BitVector i no té atributs propis.
    """
    
    def __len__(self):
        """
        Sempre torna l'enter 16 ja que correspont a la llargada de dos bytes.
        """
        return 16
    
    def lsb(self):
        """
        Retorna el Byte de menys pes.
        """
        return Byte(self._w)
    
    def msb(self):
        """
        Retorna el Byte de més pes.
        """
        return Byte(self._w>>8)


"""
#h=BitVector(0b00000000000000000000000010100110)
h=BitVector(0b00000000000000000000000000001010)
print h.extract_field_u(0b00110011)
print int(h)
print index(h)
print h
"""

