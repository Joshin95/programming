-module(examen1).
-compile(export_all).


particio(L)->
    {[X || X <- L, is_number(X)], [X || X <- L, is_atom(X)]}. 
			     
