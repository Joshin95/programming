-module(processosexamen).
-compile(export_all).


start() ->
    PIDa = spawn(?MODULE,actuador,[]),
    spawn(?MODULE,controlador,[PIDa]).

controlador(PID) ->
    Tempfinal = 0,
    receive
	{s1,Temp1} ->
	    Tempfinal = Temp1,
	    receive
		{s2,Temp2} ->
		    Tempfinal2 = Tempfinal + Temp2,
		    receive
			{s3,Temp3} ->
			    Tempfinal3 = Tempfinal + Temp3,
			    PID!Tempfinal3,
			    controlador(PID)
		    end;
		{s3,Temp3} ->
		    Tempfinal2 = Tempfinal + Temp3,
		    receive
			{s2,Temp2} ->
			    Tempfinal3 = Tempfinal + Temp2,
			    PID!Tempfinal3,
			    controlador(PID)
		    end
	    end;
	{s2,Temp2} ->
	    Tempfinal = Temp2,
	    receive 
		{s1,Temp1} ->
		    Tempfinal2 = Tempfinal + Temp1,
		    receive
			{s3,Temp3} ->
			    Tempfinal3 = Tempfinal + Temp3,
			    PID!Tempfinal3,
			    controlador(PID)
		    end;
		{s3,Temp3} ->
		    Tempfinal2 = Tempfinal + Temp3,
		    receive
			{s1,Temp1} ->
			    Tempfinal3 = Tempfinal + Temp1,
			    PID!Tempfinal3,
			    controlador(PID)
		    end
	    end;
	{s3,Temp3} ->
	    Tempfinal = + Temp3,
	    receive 
		{s1,Temp1} ->
		    Tempfinal2 = Tempfinal + Temp1,
		    receive
			{s2,Temp2} ->
			    Tempfinal3 = Tempfinal + Temp2,
			    PID!Tempfinal3,
			    controlador(PID)
		    end;
		{s2,Temp3} ->
		    Tempfinal2 = Tempfinal + Temp3,
		    receive
			{s1,Temp1} ->
			    Tempfinal3 = Tempfinal + Temp1,
			    PID!Tempfinal3,
			    controlador(PID)
		    end
	    end		
    end.
