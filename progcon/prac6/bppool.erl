%%%-------------------------------------------------------------------
%%% @author Sebas Vila-Marta <sebas@microbi.localnet>
%%% @copyright (C) 2012, Sebas Vila-Marta
%%% @doc
%%%
%%% @end
%%% Created : 25 Nov 2012 by Sebas Vila-Marta <sebas@microbi.localnet>
%%%-------------------------------------------------------------------
-module(bppool).
-export([start/1, init/1, set_light/3, display/2, kill/0]).


%% Public functions

start(Npis) ->
    register(bppool, spawn(bppool, init, [Npis])).

set_light(Pis, all, State) ->
    bppool!{set_light, Pis, up, State},
    bppool!{set_light, Pis, down, State};
set_light(Pis, Dir, State) ->
    bppool!{set_light, Pis, Dir, State}.

display(Pis, M) ->
    bppool!{display, Pis, M}.

kill() ->
    bppool!kill.

%% ----------------


init(Npis) ->
    PisToPid = create_all(1,Npis),
    loop(PisToPid).

create_all(I, Npis) when I > Npis->
    [];
create_all(I, Npis) ->
    Pid = bpis:new(I),
    [Pid|create_all(I+1, Npis)].

send_all(PisToPid, M) ->
    F = fun (V) -> V!M end,
    lists:map(F, PisToPid),
    ok.
		      

loop(PisToPid) ->
    receive
	{set_light, Pis, Dir, State} ->
	    bpis:set_light(lists:nth(Pis, PisToPid), Dir, State),
	    loop(PisToPid);
	{display, all, M} ->
	    F = fun (X) -> bpis:display(X, M) end,
	    lists:map(F, PisToPid),
	    loop(PisToPid);
	{display, Pis, M} ->
	    bpis:display(lists:nth(Pis, PisToPid), M),
	    loop(PisToPid);
	kill ->
	    send_all(PisToPid, kill),
		exit(normal),
	    ok;
	_ ->
	    loop(PisToPid)
    end.

