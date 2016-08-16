-module(ex22).
-export([buida/0,empila/2,desempila/1,cim/1]).

buida()-> [].


empila(L,E) -> [E|L].

desempila([_|L]) -> L.

cim([C|_]) -> C.
    
