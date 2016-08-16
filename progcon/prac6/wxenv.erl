%%%-------------------------------------------------------------------
%%% @author Sebas Vila-Marta <sebas@microbi.localnet>
%%% @copyright (C) 2012, Sebas Vila-Marta
%%% @doc
%%% Singleton process that serves current wx environment
%%% @end
%%% Created : 25 Nov 2012 by Sebas Vila-Marta <sebas@microbi.localnet>
%%%-------------------------------------------------------------------
-module(wxenv).

-export([start/0, init/0, get/0, kill/0]).

kill() ->
    wxenv!kill.

start() ->
    register(wxenv, spawn(wxenv, init, [])).

get() ->
    wxenv!{get, self()},
    receive
	{wxenv, E} ->
	    E
    end.



init() ->
    wx:new(),
    E = wx:get_env(),
    loop(E).

loop(E) ->
    receive
	kill ->
	    exit(normal);
	{get, CallerPid} ->
	    CallerPid!{wxenv, E},
	    loop(E);
	_ ->
	    loop(E)
    end.

