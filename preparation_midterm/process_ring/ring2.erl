% solution 2 "the new process spawning the next process in the ring".

-module(ring2).
-export[start/3].

start(_, N, _) when N < 1 -> io:fwrite("More than 1 actor needed~n");
start(Rep, N, Msg) -> Next = spawn(fun() -> start_processes(N-1) end),
                        register(first, self()),
                        Next!{Msg},
                        loop_fst(Rep, Next).

%first -> 4 -> 3 -> 2 -> 1 -> 0

start_processes(0) -> loop(first, 0);
start_processes(N) -> Next = spawn(fun() -> start_processes(N-1) end),
                        loop(Next, N).


loop(Next, Num) ->
    receive
        {stop}              -> io:fwrite("Sono: ~p termino ~n", [Num]),
                                Next!{stop};
        {Msg}               -> io:fwrite("Sono: ~p messaggio: ~p~n", [Num, Msg]),
                                Next!{Msg},
                                loop(Next, Num)
    end.


loop_fst(Rep, Next) ->
    receive
        {stop}                  -> io:fwrite("fine, faccio unregister~n"),
                                    unregister(first);
        {Msg} when Rep == 0     -> io:fwrite("Sono: first messaggio: ~p~n", [Msg]),
                                    Next!{stop},
                                    loop_fst(Rep, Next);
        {Msg}                   -> io:fwrite("Sono: first messaggio: ~p~n", [Msg]),
                                    Next!{Msg},
                                    loop_fst(Rep-1, Next)
    end.