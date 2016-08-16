-module(motor).                        
-compile(export_all).

-define(VELCAB,0.6).
-define(RESOL,100).
-define(MAXREC,22).


run(up) ->
    motor!run_up;
run(down) ->
    motor!run_down.

stop() ->
    motor!stop.

kill() ->
    motor!kill.


start() ->
    register(motor,spawn(motor,motor,[0,aturat])),
    sensor:ready().

motor(Posicio,Estat) -> 
    receive 
	run_up -> 
	    if 
		Estat=:=aturat ->
		    %io:format("UP"),
		    Estat2=engegat,
		    engegar_motor_up(Posicio);
		
		true ->
		    Estat2=engegat,
		    motor(Posicio,Estat2)
			
	    end,
	    motor(Posicio,Estat2);

	run_down -> 
	    if 
		Estat=:=aturat ->
		    %io:format("DOWN"),
		    Estat2=engegat,
		    engegar_motor_down(Posicio);
		true ->
		    Estat2=engegat,
		    motor(Posicio,Estat2)
	    end,
	    motor(Posicio,Estat2);
	stop -> io:format("Motor apagat"),
		Estat2=aturat,
		motor(Posicio,Estat2);
	kill ->
	    sensor:kill(),
	    exit(normal)   
    end.

engegar_motor_up(Posicio)-> 
    if 
	Posicio<?MAXREC ->
	    receive
		stop -> 
		    Estat=aturat,
		    motor(Posicio,Estat)
	    after ?RESOL -> 
		    %io:format("~p ~n",[Posicio+(?RESOL/1000)*?VELCAB]),
		    sensor:at(Posicio+(?RESOL/1000)*?VELCAB),
		    engegar_motor_up(Posicio+(?RESOL/1000)*?VELCAB)
	    end;
	true -> 
	    io:format("AT_TOP ~n"),
	    sensor:at(top),
	    motor(Posicio,aturat)
    end.
    
	    
engegar_motor_down(Posicio)->
    if 
	Posicio>0 ->
	    receive
		stop -> 
		    Estat=aturat,
		    motor(Posicio,Estat)
	    after ?RESOL -> 
		    %io:format("~p ~n",[Posicio-(?RESOL/1000)*?VELCAB]),
		    sensor:at(Posicio-(?RESOL/1000)*?VELCAB),
		    engegar_motor_down(Posicio-(?RESOL/1000)*?VELCAB)
	    end;
	true -> 
	    io:format("AT_BOTTOM ~n"),
	    sensor:at(bottom),
	    motor(Posicio,aturat)
    end.
    

   

