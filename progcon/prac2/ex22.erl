-module(ex22).
-export([negative/1,sumaparell/1,duplica_parells/1,sumasenar/1]).

negative(L) ->
    lists:any(fun (A) ->
		      A < 0 end, L).

sumaparell(L) ->
    Filtrada=lists:filter(fun (A) ->
				  A rem 2 == 0 end, L),
    lists:foldl(fun(X,Sum) ->
			X + Sum end, 0, Filtrada).
    
duplica_parells(L) ->
    lists:map(fun(A) -> duplica(A) end, L).

duplica(A) ->
    if A rem 2 == 0 ->
	    2*A;
    true -> A
    end.

sumasenar(L) ->
    Filtrada = senars(L),
    lists:foldl(fun(X,Sum) ->
			X + Sum end, 0, Filtrada).

senars(L) -> senars(L,0).

senars([H|C],I) ->
    if
	I rem 2 =:= 0 -> senars(C,I+1);
	true -> [H]++ senars(C,I+1)
    end;

senars([],_) -> [].
    
