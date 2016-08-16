-module(ex23).
-export([escalar_2_vec/2,loop/0,start/0,pe/2]).

escalar_2_vec([BA|EA],[BB|EB]) -> 
    BA*BB+escalar_2_vec(EA,EB);
escalar_2_vec([],[]) -> 
    0.

start() ->
    spawn(fun loop/0).

loop() ->
    receive
	{From,{A,B}} ->
	       From!escalar_2_vec(A,B),
	       loop()
		end.


pe(A,B) ->
    Primera = lists:split(trunc(length(A)/2),A),
    Segona = lists:split(trunc(length(B)/2),B),
    Pid = spawn(fun loop/0),
    Pid2 = spawn (fun loop/0),
    rpc(Pid,{element(1,Primera),element(1,Segona)})+rpc(Pid2,{element(2,Primera),element(2,Segona)}).

rpc(Pid,Request) ->
    Pid!{self(),Request},
    receive
	Response ->
	    Response
    end.
