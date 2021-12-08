-module(area1).
-export([rpc/0, loop2/0]).

rpc()->
    Pid = spawn(area1, loop2, []),
    Pid!{self(), {square, 8}},
    receive 
        {Pid, Response} -> Response   %{Pid, Response} --> almeno siamo sicuri che la risposta arrivi da quel pid
    end.
    % Pid!{self(), socks},
    % receive 
    %     {Pid, Response} -> Response
    % end.

% -export([rpc/2, loop2/0]).
% rpc(Pid, Request) ->
%     Pid ! {self(), Request},
%     receive
%         Response ->
%             Response
%     end.

loop2() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            Area = Width * Ht,
            From!{self(), Area},
            loop2();
        {From, {square, Side}} ->
            Area = Side * Side,
            From!{self(), Area},
            % io:format("Area of square is ~p~n", [Side * Side]),
            loop2();
        {From, Other} ->
            From ! {self(), error,Other},
            loop2()
    end.

% 1> c(area1).
%       {ok,area1}
% 2> Pid = spawn(area1, loop2, []).       
%       <0.87.0>
% 3> area1:rpc(Pid, {square, 5}).           
%       {25}
