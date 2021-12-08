-module(area).
-export([loop/0]).

loop() ->
    receive
        {rectangle, Width, Ht} ->
            io:format("Area of rectangle is ~p~n",[Width * Ht]),
            loop();
        {square, Side} ->
            io:format("Area of square is ~p~n", [Side * Side]),
            loop()
    end.

% 1> c(area).
%     {ok,area}
% 2> Pid = spawn (area, loop, []).
%     <0.87.0>
% 3> Pid ! {square, 5}.
%     Area of square is 25
%     {square,5}
