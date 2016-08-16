-module(ex21).
-export([suma/1,multiplica/1,fold/3,resta/1,divisio/1]).

fold([H|C],F,I) ->
    fold(C,F,F(I,H));

fold ([],_,I) ->
    I.

suma(L) ->
    Suma = fun (A,B) -> 
		   A+B end,
    fold(L,Suma,0).

resta([H|C]) ->
    Resta = fun (A,B) -> 
		   A-B end,
    fold(C,Resta,H).

divisio([H|C]) ->
    Divisio = fun (A,B) -> 
		   A/B end,
    fold(C,Divisio,H).

multiplica(L) ->
    Multiplica = fun (A,B) -> 
		   A*B end,
    fold(L,Multiplica,1).
