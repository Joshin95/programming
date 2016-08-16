-module(ascensor).                         
-compile(export_all).


%OPENING i CLOSING el ascensor es mou, ARREGLAR

pbc_pushed(close_doors) ->
    ascensor!close_doors;
pbc_pushed(open_doors) ->
    ascensor!open_doors;
pbc_pushed(Pis) ->
    ascensor!{clicked, Pis}.

doors_open()->
    ascensor!open.

doors_closed()->
    ascensor!closed.    

at(top) ->
    ascensor!at_top;
at(bottom) ->
    ascensor!at_bottom.

ready() ->
    ascensor!ready.

sens_pl(P) ->
    ascensor!{sens_pl,P}.

abort()->
    ascensor!abort.

kill() ->
    ascensor!kill.

pbp_pushed(Pis,_) ->
    ascensor!{clicked,Pis}.


start() ->
    register(ascensor,spawn(ascensor,ascensor_init,[])).

ascensor_init() ->
    Estat = 0,
    Pisos = 4,
    wxenv:start(),
    bppool:start(Pisos),
    bcab:new(Pisos),
    sensor:start(),
    motor:start(),
    cdoors:start(),
    reset(Estat).

reset(Estat) ->
    bcab!{display,"RESET"},
    motor:run(down),
    receive
	at_bottom -> 
	    motor:run(up),
	    receive
		{sens_pl,1} ->
		    motor:stop(),
		    bcab:display(1),
		    bppool:display(all,1),
		    bppool:display(1,"HERE"),
		    ascensor(1,Estat,0)
		end
    end.

ascensor(X,Estat,EstatPortes)->  
    if 
	Estat=:=0 ->
	    if 
		EstatPortes =:= 0 ->
		    receive 
			abort ->
			    bcab:kill(),
			    motor:kill(),
			    cdoors:kill(),
			    bppool:kill(),
			    ok;
			kill ->
			    motor:kill(),
			    cdoors:kill(),
			    bppool:kill(),
			    ok;
			
			open_doors -> 
			    cdoors:open(),
			    bppool:display(X,"OPENING"),
			    EstatPortes2=1,
			    ascensor(X,Estat,EstatPortes2);
		
			close_doors ->
			    cdoors:close(),
			    bppool:display(X,"CLOSING"),
			    EstatPortes2=2,
			    ascensor(X,Estat,EstatPortes2);

			open ->
			    bppool:display(X,"OPEN"),
			    receive
				
				abort ->
				    bcab:kill(),
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				kill ->
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				open_doors ->
				    cdoors:open(),
				    EstatPortes2=1,
				    bppool:display(X,"OPENING"),
				    ascensor(X,Estat,EstatPortes2);
				
				close_doors ->
				    cdoors:close(),
				    EstatPortes2=2,
				    bppool:display(X,"CLOSING"),
				    ascensor(X,Estat,EstatPortes2)
			    after 
				10000->			
				    cdoors:close(),
				    bppool:display(X,"CLOSING"),
				    EstatPortes2=2,
				    ascensor(X,Estat,EstatPortes2)
			    end;
						
			
			closed ->
			    bppool:display(X,"HERE"),
			    EstatPortes2=0,
			    ascensor(X,Estat,EstatPortes2);
			
			{clicked,N} ->
			    
			    if
				X>N -> 
				    bcab:set_light(N, on),
				    bppool:set_light(N,all,on),
				    bppool:display(all,"BUSY"),
				    bppool:display(N,X),
				    motor:run(down),
				    EstatPortes2=0,
				    Estat2=1;
				X==N ->
				    Estat2=0,
				    EstatPortes2=1,
				    cdoors:open(),
				    bppool:display(X,"OPENING");
				
				true -> 
				    bcab:set_light(N, on),
				    bppool:set_light(N,all,on),
				    bppool:display(all,"BUSY"),
				    bppool:display(N,X),
				    motor:run(up),
				    EstatPortes2=0,
				    Estat2=1
			    end,
			    ascensor(N,Estat2,EstatPortes2)
		    end;
		
		EstatPortes =:= 1 ->
		    receive

			abort ->
			    bcab:kill(),
			    motor:kill(),
			    bppool:kill(),
			    cdoors:kill(),
			    ok;
			kill ->
			    motor:kill(),
			    cdoors:kill(),
			    bppool:kill(),
			    ok;
			
			open_doors -> 
			    ascensor(X,Estat,1);
			
			close_doors ->
			    cdoors:close(),
			    bppool:display(X,"CLOSING"),
			    EstatPortes2=2,
			    ascensor(X,Estat,EstatPortes2);
		
			open ->
			    bppool:display(X,"OPEN"),
			    receive
				
				abort ->
				    bcab:kill(),
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				kill ->
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				open_doors ->
				    cdoors:open(),
				    EstatPortes2=1,
				    bppool:display(X,"OPENING"),
				    ascensor(X,Estat,EstatPortes2);
				
				close_doors ->
				    cdoors:close(),
				    EstatPortes2=2,
				    bppool:display(X,"CLOSING"),
				    ascensor(X,Estat,EstatPortes2)
			    after 
				10000->			
				    cdoors:close(),
				    bppool:display(X,"CLOSING"),
				    EstatPortes2=2,
				    ascensor(X,Estat,EstatPortes2)
			    end;	
		
			
			
			closed ->
			    bppool:display(X,"HERE"),
			    EstatPortes2=0,
			    ascensor(X,Estat,EstatPortes2)
		    end;
		true ->
		    receive
			abort ->
			    bcab:kill(),
			    motor:kill(),
			    bppool:kill(),
			    cdoors:kill(),
			    ok;
			kill ->
			    motor:kill(),
			    cdoors:kill(),
			    bppool:kill(),
			    ok;
			
			open_doors -> 
			    cdoors:open(),
			    bppool:display(X,"OPENING"),
			    EstatPortes2=1,
			    ascensor(X,Estat,EstatPortes2);
			
			close_doors ->
			    ascensor(X,Estat,2);
			
			
			open ->
			    bppool:display(X,"OPEN"),
			    receive
				
				abort ->
				    bcab:kill(),
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				kill ->
				    motor:kill(),
				    cdoors:kill(),
				    bppool:kill(),
				    ok;
				open_doors ->
				    cdoors:open(),
				    EstatPortes2=1,
				    bppool:display(X,"OPENING"),
				    ascensor(X,Estat,EstatPortes2);
				
				close_doors ->
				    cdoors:close(),
				    EstatPortes2=2,
				    bppool:display(X,"CLOSING"),
				    ascensor(X,Estat,EstatPortes2)
			    after 
				10000->			
				    cdoors:close(),
				    bppool:display(X,"CLOSING"),
				    EstatPortes2=2,
				    ascensor(X,Estat,EstatPortes2)
			    end;
			
			closed ->
			    bppool:display(X,"HERE"),
			    EstatPortes2=0,
			    ascensor(X,Estat,EstatPortes2)
		    end
	    end;
	
		
		    
		    
	true ->
	    receive
		abort ->
		    bcab:kill(),
		    motor:kill(),
		    bppool:kill(),
		    cdoors:kill(),
		    ok;
		kill ->
		    motor:kill(),
		    cdoors:kill(),
		    bppool:kill(),
		    ok;
		
		open_doors ->
		    io:format("No es poden obrir les portes ara, en moviment ~n"),
		    EstatPortes2=0,
		    ascensor(X,Estat,EstatPortes2);
				
		{sens_pl,P} -> 
		    if
			P==X -> motor:stop(),
				bppool:display(all,P),
				bppool:display(P,"OPENING"),
				bppool:set_light(P,all,off),
				bcab:display(P),
				bcab:set_light(P, off),
				Estat2=0,
				EstatPortes2=1,
				cdoors:open();
			
			true -> bcab:display(P),
				bppool:display(X,P),
				EstatPortes2=0,
				Estat2=1
		    end,
		    ascensor(X,Estat2,EstatPortes2)
	    end
    end.
	      
			  
	    
    



	    
