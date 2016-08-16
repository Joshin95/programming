%%% @author Sebas Vila <sebas@bubinga.upc.es>
%%% @copyright (C) 2012, Sebas Vila
%%% @doc
%%% Botonera de cabina de l'ascensor. Té display i polsadors per
%%% obrir i tancar portes.
%%% @end
%%% Created :  8 Oct 2012 by Sebas Vila <sebas@bubinga.upc.es>
-module(bcab).
-include_lib("wx/include/wx.hrl").
-export([new/2,bcab_proc/3]).

-define(BUTTON_ID_OPEN,  200).
-define(BUTTON_ID_CLOSE, 201).


%%--------------------------------------------------------------------
%% @doc Crea una botonera de cabina. 
%%      N=num pisos. P=proc que rep info
%%      Torna el Pid de la botonera
%% @spec
%% @end
%%--------------------------------------------------------------------
new(N,P) ->
    Env=wx:get_env(),
    spawn(?MODULE, bcab_proc, [N,P,Env]).


bcab_proc(N,P,Env) ->
    wx:set_env(Env),
    Frame = create_window(),
    L = create_buttons(Frame,N),
    wxWindow:show(Frame),
    loop(Frame, L, P),
    ok.

create_window() ->
    Frame = wxFrame:new(wx:null(), -1, "Botonera"), % window title
    wxFrame:connect(Frame, close_window),
    Frame.

list_of_buttons(_,0) ->
    [];
list_of_buttons(Panel,N) ->
    Blabel = io_lib:format("~B",[N]),
    Btip   = io_lib:format("Planta ~B",[N]),
    B = wxButton:new(Panel, N, [{label,Blabel}]),
    wxButton:setToolTip(B, Btip),
    [B|list_of_buttons(Panel,N-1)].

create_buttons(Panel,N) ->
    Sz = wxBoxSizer:new(?wxVERTICAL),
    SzFlags = [{proportion, 0}, {border, 4}, {flag, ?wxALL}],

    % Create display ans add to sizer
    Display = wxTextCtrl:new(Panel, 100, 
			     [{style,?wxTE_READONLY bor ?wxTE_RIGHT},
			      {value, "0"}]),
    Redtext = wxTextAttr:new({255,10,10}),
    wxTextCtrl:setDefaultStyle(Display, Redtext),
    wxSizer:add(Sz,Display,SzFlags),

    % Get button list and add to sizer
    ButtonLst = list_of_buttons(Panel,N),
    [wxSizer:add(Sz, B, SzFlags) || B <- ButtonLst],

    % connect buttons to events and set background
    wx:foreach(fun (B)-> wxButton:connect(B, command_button_clicked) end, 
	       ButtonLst),
    wx:foreach(fun (B)-> wxButton:setBackgroundColour(B,{246,246,245}) end,
	       ButtonLst),

    % Create open/close doors buttons
    OpenB = wxButton:new(Panel, ?BUTTON_ID_OPEN, [{label,"< >"}]),
    wxButton:setToolTip(OpenB, "Obre portes"),
    CloseB = wxButton:new(Panel, ?BUTTON_ID_CLOSE, [{label,"> <"}]),
    wxButton:setToolTip(CloseB, "Tanca portes"),
    wxSizer:add(Sz,OpenB, SzFlags),
    wxSizer:add(Sz,CloseB,SzFlags),
    wxButton:connect(OpenB, command_button_clicked),
    wxButton:connect(CloseB, command_button_clicked),

    % fits the window to the childs
    wxSizer:layout(Sz),
    wxSizer:fit(Sz,Panel),
    {ButtonLst,Display}.


loop(Frame, W, P) ->
    {ButtonLst,Display} = W,
    receive 
   	#wx{event=#wxClose{}} ->
   	    io:format("~p Closing window ~n",[self()]),
	    wxWindow:destroy(Frame),
	    P!abort,
	    ok;
   	#wx{id=?BUTTON_ID_OPEN,
	    event=#wxCommand{type=command_button_clicked}} ->
	    P!open_doors,
	    loop(Frame,W,P);
   	#wx{id=?BUTTON_ID_CLOSE,
	    event=#wxCommand{type=command_button_clicked}} ->
	    P!close_doors,
	    loop(Frame,W,P);
   	#wx{id=Id,event=#wxCommand{type=command_button_clicked}} ->
	    P!{clicked,Id},
	    loop(Frame,W,P);
 	kill -> 
	    wxWindow:destroy(Frame),
	    ok;
	{light_on, F} ->
	    B = lists:nth(length(ButtonLst)-F+1,ButtonLst),
	    wxButton:setBackgroundColour(B,{255,255,153}),
	    loop(Frame,W,P);
	{light_off, F} ->
	    B = lists:nth(length(ButtonLst)-F+1,ButtonLst),
	    wxButton:setBackgroundColour(B,{246,246,245}), % nullColour
	    loop(Frame,W,P);
	{display, V} when is_integer(V) ->
	    % show V in the display
	    T = io_lib:format("~B",[V]),
	    wxTextCtrl:clear(Display),
	    wxTextCtrl:setValue(Display,T),
	    loop(Frame,W,P);
	{display, L} when is_list(L) ->
	    % show V in the display
	    T = io_lib:format("~6s",[L]),
	    wxTextCtrl:clear(Display),
	    wxTextCtrl:setValue(Display,T),
	    loop(Frame,W,P);
	Msg ->
	    io:format("Botonera got unknown message ~p ~n", [Msg]),
	    loop(Frame,W,P)
    end.


