-module(cdoors).                        
-compile(export_all).

-define(VELDOOR,1/2).
-define(MAXREC,2).
-define(RESOL,10).


open() ->
    cdoors!open.
close() ->
    cdoors!close.

kill() ->
    cdoors!kill.


start() ->
    register(cdoors,spawn(cdoors,door,[0])),
    ascensor:doors_closed().

door(Posicio) -> 
    receive 
	open -> 
	    io:format("Opening ~n"),
	    open_doors(Posicio),
	    door(Posicio);
	close -> 
	    io:format("Closing ~n"),
	    close_doors(Posicio),
	    door(Posicio);
	kill ->
	    exit(normal)   
    end.

open_doors(Posicio)-> 
    if 
	Posicio<?MAXREC ->
	    receive
		close -> 
		    io:format("Closing2 ~n"),
		    close_doors(Posicio)
	    after ?RESOL -> 
		    io:format("Opening ~n"),
		    io:format("~p ~n",[Posicio+(?RESOL/1000)*?VELDOOR]),
		    open_doors(Posicio+(?RESOL/1000)*?VELDOOR)
	    end;
	true -> 
	    io:format("Open ~n"),
	    ascensor:doors_open(),
	    door(Posicio)
    end.
    

close_doors(Posicio)-> 
    if 
	Posicio > 0 ->
	    receive
		open -> 
		    io:format("Opening2 ~n"),
		    open_doors(Posicio)
	    after ?RESOL -> 
		    io:format("Closing ~n"),
		    io:format("~p ~n",[Posicio-(?RESOL/1000)*?VELDOOR]),
		    close_doors(Posicio-(?RESOL/1000)*?VELDOOR)
	    end;
	true -> 
	    io:format("Closed ~n"),
	    ascensor:doors_closed(),
	    door(Posicio)
    end.



    

   

