% solution 1 "central process that sets up the ring and initiates sending the message".
% Between logs there is the log of the pid resulted by "spof the  awn(fun() -> start_last(Rep, Msg, Lst) end)".
% I don't find any better thing to delete it.

-module(ring).
-export[start/3].

start(_, N, _) when N < 2 -> io:fwrite("Actor number must be > 1~n");
start(Rep, N, Msg) -> Lst = start_processes(N, []),
                    spawn(fun() -> start_last(Rep, Msg, Lst) end).

start_processes(1, Lst) -> Lst++[spawn(fun() -> loop(1) end)];
start_processes(N, Lst) -> start_processes(N-1, Lst++[spawn(fun() -> loop(N) end)]).

loop(Num) -> 
    receive
        {stop, []}                                 -> io:fwrite("Sono: ~p termino~n", [Num]);
        {stop, [Next|T]}                           -> io:fwrite("Sono: ~p termino~n", [Num]),
                                                    Next!{stop, T};

        {Msg, [Next|T]}                            -> io:fwrite("Sono: ~p messaggio: ~p~n", [Num, Msg]),
                                                   Next!{Msg, T++[Next]},
                                                   loop(Num)
    end.


start_last(Rep, Msg, [H|T]) -> register(last, self()),
                            H!{Msg, T++[last]++[H]},
                            loop_last(Rep).

loop_last(Rep) ->

    receive
        {stop, _}                            -> io:fwrite("anche io lo ricevo, faccio l'unregister ~n"),
                                                unregister(last);
        {Msg, [Next|T]} when Rep == 0        -> io:fwrite("Sono: 0 messaggio: ~p~n~n", [Msg]),
                                                Next!{stop, T},
                                                loop_last(Rep); 
        {Msg, [Next|T]}                      -> io:fwrite("Sono: 0 messaggio: ~p~n~n", [Msg]),
                                                Next!{Msg, T++[Next]},
                                                loop_last(Rep-1)
    end.