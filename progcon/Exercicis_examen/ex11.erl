-module(ex11).
-compile(export_all).

minmax2([],MIN,MAX) -> {MIN,MAX};

minmax2([D|L],MIN,MAX) -> 
    if
	D<MIN ->
	    MINI=D,
	    MAXI=MAX;
	D>MAX ->
	    MAXI=D,
	    MINI=MIN;
	true -> MINI=MIN,
		MAXI=MAX
    end,		   
    minmax2(L,MINI,MAXI).

minmax([H|C]) ->
    MIN=H,
    MAX=H,
    minmax2(C,MIN,MAX).

