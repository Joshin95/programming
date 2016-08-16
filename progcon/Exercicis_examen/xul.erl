%Exemple llistes recursives

[X || X <-[1,2,3,4,5,6], X<5].

%Exemple fun() (funcions anonimes)

EsParell = fun(X)->
		   (X rem 2) =:= 0 end.

TemperaturaC = fun({c,C}) ->
		       {f,32+C*9/5};
		  ({f,F}) -> {c,(F-32)*5/9} end.

%Exemple funcionament lists:map

lists:map(EsParell,[1,2,3,4,5,6]). %Aplica una funcio a una llista.
