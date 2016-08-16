-module(sensor).      
-compile(export_all).

-define(SENS_PL_1,0.5).
-define(SENS_PL_2,5.5).
-define(SENS_PL_3,8.5).
-define(SENS_PL_4,12.5).


start(Pid)->
    P0=0, %posicio inicial?
    S=spawn(sensor,sensor,[Pid,P0]),
    Pid!ready,
    S.


sensor(Pid,P0)->
    receive 
	at_top -> 
	    %io:format("At top ~n"),
	    Pid!at_top, sensor(Pid,P0);
	at_bottom -> 
	    %io:format("At bottom ~n"),
	    Pid!at_bottom, sensor(Pid,P0);
	{at,P} -> 
	    calcula_pis(Pid,P,P0), sensor(Pid,P0);
	ready -> 
	    io:format("Ready! ~n"),
	    Pid!ready, sensor(Pid,P0);
	reset ->   
	    Pid!reset, sensor(Pid,P0);
	kill -> exit(normal)
    end.


calcula_pis(Pid,P,P0) ->
    if 
	((P0<?SENS_PL_1) and (?SENS_PL_1<P)) or ((P<?SENS_PL_1) and (?SENS_PL_1<P0)) ->
	    io:format("Ascensor en el pis 1 ~n"),
	    Pid!{sens_pl,1}; 
	((P0<?SENS_PL_2) and (?SENS_PL_2<P)) or ((P<?SENS_PL_2) and (?SENS_PL_2<P0))->
	    io:format("Ascensor en el pis 2 ~n"),
	    Pid!{sens_pl,2};
	((P0<?SENS_PL_3) and (?SENS_PL_3<P)) or ((P<?SENS_PL_3) and (?SENS_PL_3<P0)) ->
	    io:format("Ascensor en el pis 3 ~n"),
	    Pid!{sens_pl,3}; 
	((P0<?SENS_PL_4) and (?SENS_PL_4<P)) or ((P<?SENS_PL_4) and (?SENS_PL_4<P0)) ->
	    io:format("Ascensor en el pis 4 ~n"),
	    Pid!{sens_pl,4};
	true -> ok     
    end,
    sensor(Pid,P).
