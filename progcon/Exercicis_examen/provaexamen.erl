-module(provaexamen).
-compile(export_all).

start(N) ->
    L = [],
    spawn_func(0,N,L),
    rebre().

spawn_func(N,N,L) ->
    envia(L,0),
    ok;
spawn_func(I,N,L) ->
    A = spawn(provaexamen,p,[self()]),
    R = [A|L],
    spawn_func(I+1,N,R).

rebre() ->
    receive 
	missatge2 ->
	    io:format("rebut ~n"),
	    rebre();
	atura ->
	    io:format("atura"),
	    ok
    end.
	   
envia([Ca|Cu],C) ->
    Ca!{missatge,C},
    envia(Cu,C+1);
envia([],_) ->
    %io:format("PEIDE ~p ~n",PEIDE),
    ok.

p(Pid) ->
    receive
	{missatge,4} ->
	    Pid!atura;
	{missatge,_} ->
	    io:format("entrap ~n"),
	    Pid!missatge2
    end.
