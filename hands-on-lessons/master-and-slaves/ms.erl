% module master
-module(ms).
-export([start/1, to_slave/2]).

start(N)    -> 
    register(master, spawn(fun()-> loop([]) end)),
    master!{create_processes, N}.
    

to_slave(Message, N)    ->
    master!{Message, N}.

loop(Lst)  ->
    receive
        {create_processes, N}                   -> NewLst = create_processes(N, [], N),
                                                    loop(NewLst);
        {Message, N}                            -> (get_process(N, Lst))!{Message, N},
                                                    loop(Lst);
        {'DOWN', _, process, Pid, _}            -> io:format("master restarting dead slave ~p died~n", [Pid]),
                                                    loop(restart_process(Pid, Lst, []))
    end.

create_processes(0, Lst, _) ->
    Lst;
create_processes(N, Lst, NumTot) -> 
    {Pid, _} = spawn_monitor(fun() -> sl:loop() end),
    create_processes(N-1, Lst++[{Pid, NumTot-N}], NumTot).

get_process(0, _)  ->
    exit("no processes with the number");
get_process(N, [{Pid, Num}|_]) when N == Num  ->
    Pid;
get_process(N, [_|T]) ->
    get_process(N, T).


restart_process(Pid, [{P, Num}|T], New) when Pid == P    ->
    {NPid, _} = spawn_monitor(fun() -> sl:loop() end),
    L = New++[{NPid, Num}],
    L++T;
restart_process(Pid, [H|T], New)    ->
    restart_process(Pid, T, New++[H]).
