-module(ascensor).                         
-compile(export_all).


start() ->
    spawn(ascensor,ascensor_init,[]).

ascensor_init() ->
    wx:new(),
    Estat=0,
    Botonera=bcab:new(4,self()),
    Sensor=sensor:start(self()),
    Motor=motor:start(Sensor),
    reset(Motor,Botonera,Estat).

reset(Motor,Botonera,Estat) ->
    Botonera!{display,"RESET"},
    Motor!run_down,
    receive
	at_bottom -> 
	    Motor!run_up,
	    receive
		{sens_pl,1} ->
		    Motor!stop,
		    Botonera!{display,1},
		    ascensor(Motor,Botonera,1,Estat)
		end
    end.

ascensor(Motor,Botonera,X,Estat)->  
    %io:format("ascensor"),
    if 
	Estat=:=0 ->
	    
	    receive 
		{clicked,N} ->
			
		    if
			X>N -> 
			    Botonera!{light_on,N},
			    Motor!run_down,
			    Estat2=1;
			X==N ->
			    Estat2=0;
			true -> 
			    Botonera!{light_on,N},
			    Motor!run_up,
			    Estat2=1
		    end,
		    ascensor(Motor,Botonera,N,Estat2)
	    end;
	true ->
	    receive 
		{sens_pl,P} -> 
						%io:format("sensor"),
		    if
			P==X -> Motor!stop,
				Botonera!{display,P},
				Botonera!{light_off,P},Estat2=0;
			true -> Botonera!{display,P},
				Estat2=1
		    end,
		    ascensor(Motor,Botonera,X,Estat2)
	    end
    end.
	      
			  
	    
    
