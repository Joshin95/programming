-module(ex21).
-export([compta/1,suprimeix/2]).

compta([_|L]) ->
    1+compta(L);
compta([]) ->
    0.

suprimeix([E|L],E) -> suprimeix(L,E);
suprimeix([C|L],E) -> [C|suprimeix(L,E)];	    
suprimeix([],_) -> [].
