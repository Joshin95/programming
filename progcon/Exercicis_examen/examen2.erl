-module(examen2).
-compile(export_all).

garbell(N) ->
    Nova = [],
    garbell(N,2,Nova).

garbell(N,Div,New) ->
    if (Div =< N) ->
	    if (N rem Div) /= 0 ->
		    New2 = New ++ [Div],
		    garbell(N, Div+1, New2)
	    end;
       true -> 
	    New
    end.
    
	     
	    
	    
