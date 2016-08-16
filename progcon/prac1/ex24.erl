-module(ex24).
-export([loop/0,start/0,ordena/1]).

start() ->
    spawn(fun loop/0).

loop() ->
    receive
	{From,A} ->
	       From!lists:sort(A),
	       loop()
		end.

ordena(A) ->
    Esplitada = lists:split(trunc(length(A)/2),A),
    Pid = spawn(fun loop/0),
    Pid2 = spawn (fun loop/0),
    lists:merge(rpc(Pid,element(1,Esplitada)),rpc(Pid2,element(2,Esplitada))).

rpc(Pid,Request) ->
    Pid!{self(),Request},
    receive
	Response ->
	    Response
    end.
