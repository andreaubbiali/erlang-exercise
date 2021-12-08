-module(stimer).
-export([start/2, cancel/1]).


start(Time, Fun) -> spawn(fun() -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! cancel.

timer(Time, Fun) ->
    receive
        cancel ->
            void
    after Time ->
        Fun()
    end.


% 1> c(stimer).
%       {ok,stimer}
% 2> Pid = stimer:start(5000, fun() -> io:format("timer event~n") end).
%       <0.87.0>
%       timer event ----> STAMPATO DOPO 5 SECONDI
% 3> Pid1 = stimer:start(25000, fun() -> io:format("timer event~n") end).
%       <0.89.0>
% 4> stimer:cancel(Pid1).
%       cancel
