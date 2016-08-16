-module(ex1).
-compile(export_all).

particio(L)->
    A=[X || X<-L, is_integer(X)],
    B=[X || X<-L, is_atom(X)],
    {A,B}.



%Gregor

particio(L)->
    {[X || X <- L, is_number(X)], [X || X <- L, is_atom(X)]}. 
