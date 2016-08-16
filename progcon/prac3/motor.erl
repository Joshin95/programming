-module(motor).                        %Alguna cosa a solucionar(no tingui memoria)
-compile(export_all).

-define(VELCAB,0.6).
-define(RESOL,100).
-define(MAXREC,22).

start(Pid) ->
    M=spawn(motor,motor,[Pid,0,aturat]),
    Pid!{ready},
    M.

motor(Pid,Posicio,Estat) -> 
    receive 
	run_up -> 
	    if 
		Estat=:=aturat ->
		    %io:format("UP"),
		    Estat2=engegat,
		    engegar_motor_up(Pid,Posicio);
		
		true ->
		    Estat2=engegat,
		    motor(Pid,Posicio,Estat2)
			
	    end,
	    motor(Pid,Posicio,Estat2);

	run_down -> 
	    if 
		Estat=:=aturat ->
		    %io:format("DOWN"),
		    Estat2=engegat,
		    engegar_motor_down(Pid,Posicio);
		true ->
		    Estat2=engegat,
		    motor(Pid,Posicio,Estat2)
	    end,
	    motor(Pid,Posicio,Estat2);
	stop -> io:format("Motor apagat"),
		Estat2=aturat,
		motor(Pid,Posicio,Estat2);
	kill -> exit(normal)   
    end.

engegar_motor_up(Pid,Posicio)-> 
    if 
	Posicio<?MAXREC ->
	    receive
		stop -> 
		    Estat=aturat,
		    motor(Pid,Posicio,Estat)
	    after ?RESOL -> 
		    %io:format("~p ~n",[Posicio+(?RESOL/1000)*?VELCAB]),
		    Pid!{at,Posicio+(?RESOL/1000)*?VELCAB},
		    engegar_motor_up(Pid,Posicio+(?RESOL/1000)*?VELCAB)
	    end;
	true -> 
	    io:format("AT_TOP ~n"),
	    Pid!at_top,
	    motor(Pid,Posicio,aturat)
    end.
    
	    
engegar_motor_down(Pid,Posicio)->
    if 
	Posicio>0 ->
	    receive
		stop -> 
		    Estat=aturat,
		    motor(Pid,Posicio,Estat)
	    after ?RESOL -> 
		    %io:format("~p ~n",[Posicio-(?RESOL/1000)*?VELCAB]),
		    Pid!{at,Posicio-(?RESOL/1000)*?VELCAB},
		    engegar_motor_down(Pid,Posicio-(?RESOL/1000)*?VELCAB)
	    end;
	true -> 
	    io:format("AT_BOTTOM ~n"),
	    Pid!at_bottom,
	    motor(Pid,Posicio,aturat)
    end.
    

   

