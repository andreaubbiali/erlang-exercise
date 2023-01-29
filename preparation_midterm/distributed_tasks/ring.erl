-module(ring).
-export[send_message/1, send_message/2, stop/0, start/2].

start(Num, [H|T]) -> Next = spawn(fun() -> start_processes(Num-1, T) end),
                    register(first, spawn(fun() -> loop(Next, H) end)).

start_processes(1, [H|[]]) -> loop_last(H);
start_processes(Num, [H|T]) -> Next = spawn(fun() -> start_processes(Num-1, T) end),
                                loop(Next, H).

send_message(Msg) -> first!Msg.

send_message(Msg, Iter) -> first!{Msg, Iter-1}.

stop() -> first!break,
        unregister(first).

loop(Next, Fun) -> 
    receive
        break -> Next!break,
                exit(normal);
        {Msg, Iter} -> Next!{Fun(Msg), Iter};
        Msg -> Next!Fun(Msg)
    end,
    loop(Next, Fun).


loop_last(Fun) ->
    receive
        break -> exit(normal);
        {Msg, 0} -> io:fwrite("~p~n", [Fun(Msg)]);
        {Msg, Iter} -> first!{Fun(Msg), Iter-1};
        Msg -> io:fwrite("~p~n", [Fun(Msg)])     
    end,
    loop_last(Fun).