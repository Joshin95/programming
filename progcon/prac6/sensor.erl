-module(sensor).      
-compile(export_all).

-define(SENS_PL_1,0.5).
-define(SENS_PL_2,5.5).
-define(SENS_PL_3,8.5).
-define(SENS_PL_4,12.5).
-define(SENS_PL_5,16.5).
-define(SENS_PL_6,20.5).



at(top) ->
    sensor!at_top;
at(bottom) ->
    sensor!at_bottom;
at(Pos) ->
    sensor!{at,Pos}.

ready() ->
    sensor!ready.

kill() ->
    sensor!kill.



start()->
    P0=0, %posicio inicial?
    register(sensor,spawn(sensor,sensor,[P0])),
    ascensor:ready().


sensor(P0)->
    receive 
	at_top -> 
	    %io:format("At top ~n"),
	    ascensor:at(top), sensor(P0);
	at_bottom -> 
	    %io:format("At bottom ~n"),
	    ascensor:at(bottom), sensor(P0);
	{at,P} -> 
	    calcula_pis(P,P0), sensor(P0);
	ready -> 
	    io:format("Ready! ~n"),
	    ascensor:ready(), sensor(P0);
	reset ->   
	    ascensor:reset(0), sensor(P0);
	kill -> exit(normal)
    end.


calcula_pis(P,P0) ->
    if 
	((P0<?SENS_PL_1) and (?SENS_PL_1<P)) or ((P<?SENS_PL_1) and (?SENS_PL_1<P0)) ->
	    io:format("Ascensor en el pis 1 ~n"),
	    ascensor:sens_pl(1); 
	((P0<?SENS_PL_2) and (?SENS_PL_2<P)) or ((P<?SENS_PL_2) and (?SENS_PL_2<P0))->
	    io:format("Ascensor en el pis 2 ~n"),
	    ascensor:sens_pl(2);
	((P0<?SENS_PL_3) and (?SENS_PL_3<P)) or ((P<?SENS_PL_3) and (?SENS_PL_3<P0)) ->
	    io:format("Ascensor en el pis 3 ~n"),
	    ascensor:sens_pl(3); 
	((P0<?SENS_PL_4) and (?SENS_PL_4<P)) or ((P<?SENS_PL_4) and (?SENS_PL_4<P0)) ->
	    io:format("Ascensor en el pis 4 ~n"),
	    ascensor:sens_pl(4);
	


	((P0<?SENS_PL_5) and (?SENS_PL_5<P)) or ((P<?SENS_PL_5) and (?SENS_PL_5<P0)) ->
	    io:format("Ascensor en el pis 5 ~n"),
	    ascensor:sens_pl(5); 
	((P0<?SENS_PL_6) and (?SENS_PL_6<P)) or ((P<?SENS_PL_6) and (?SENS_PL_6<P0)) ->
	    io:format("Ascensor en el pis 6 ~n"),
	    ascensor:sens_pl(6);
	true -> ok     
    end,
    sensor(P).
