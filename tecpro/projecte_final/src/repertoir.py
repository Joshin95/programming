from avrexcep import *
from instruction import *

class Repertoir(object):

    def __init__(self,li):
        self._li=li

    def find(self, instr):
        for instruccio in self._li:
            if instruccio.match(instr):
                return instruccio  #instruccio ja ha de ser un objecte Instrunner, ja que self._li es una llista d'objectes instrunner.
        else:
            raise UnknownCodeError()
        
class UnknownCodeError(AVRException):
    pass
