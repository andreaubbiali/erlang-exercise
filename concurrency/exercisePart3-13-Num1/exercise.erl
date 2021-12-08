% Write a function my_spawn(Mod, Func, Args) that behaves like spawn(Mod, Func,
% Args) but with one difference. If the spawned process dies, a message
% should be printed saying why the process died and how long the process
% lived for before it died.

-module(exercise).
-export([my_spawn/3, receiver/0]).

my_spawn(Mod, Func, Args) ->
    Pid = spawn_link(Mod, Func, Args),
    receive
        {'exit', Pid, Why} -> io:format("Errore ~p dal PID: ~p~n", [Why , Pid])
    end.

% NON SO SE SIA GIUSTO (?)