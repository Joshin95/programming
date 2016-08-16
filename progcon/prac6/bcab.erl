-module(bcab).          %mirar port_command
-compile(export_all).


-define(PORT, "/dev/ttyACM0").


light_on(N)->
    bcab!{light_on,N}.
light_off(N)->
    bcab!{light_off,N}.
display(M)->
    bcab!{display,M}.
kill()->
    bcab!kill.


	

start() ->
    SerialPort = open_port(?PORT,[]),
    Func = spawn(?MODULE, loop, [SerialPort]),
    port_connect(SerialPort, Func),
    register(bcab,Func).
   


loop(SerialPort) ->
    receive

	{light_on,N} ->
	    port_command(SerialPort,"E"),
	    port_command(SerialPort,integer_to_list(N));
	{light_off,N} ->
	    port_command(SerialPort,"A"),
	    port_command(SerialPort,integer_to_list(N));
	
	{display,M} ->
	    port_command(SerialPort,"D"),
	    port_command(SerialPort,integer_to_list(M));
	kill ->
	    exit(normal);

	{_,{data,"B1"}} ->
	    ascensor:pbc_pushed(1);
	{_,{data,"B2"}} ->
	    ascensor:pbc_pushed(2);
	{_,{data,"B3"}} ->
	    ascensor:pbc_pushed(3);
	{_,{data,"B4"}} ->
	    ascensor:pbc_pushed(4);
	{_,{data,"B5"}} ->
	    ascensor:pbc_pushed(5);
	{_,{data,"B6"}} ->
	    ascensor:pbc_pushed(6);
	{_,{data,"TP"}} ->
	    ascensor:pbc_pushed(close_doors);
	{_,{data,"OP"}} ->
	    ascensor:pbc_pushed(open_doors)
	

    end,
    loop(SerialPort).









   % register(bcab, Func).
   % timer:sleep(5000),
   % 
   % 




%    Port = open_port({spawn,"/dev/ttyACM0"},[binary,{line, 255}]),
 %   do_read(Port).

%loop1(SerialPort)->
 %   receive
%	_ ->
%	    ok
 %   end,    
  %  receive
%	_ ->
%	    ok
 %   end,
  %  receive
%	_ ->
%	    loop(SerialPort)
 %   end.




%
