-module(ring).
-export([start/2, send_message/1, send_message/2, stop/0]).

start(Num, Fun) -> register(first, spawn(fun() -> start_actors(Num, Fun) end)).

send_message(Num) -> first!{Num}.

send_message(Num, Rep) -> first!{Num, Rep-1}.

stop() -> first!{stop_signal}.

start_actors(1, [F|_]) -> last_actor(F);
start_actors(Num, [F|T]) -> loop(F, spawn(fun() -> start_actors(Num-1, T) end)).

last_actor(Fun) ->
    receive

        {stop_signal} -> io:fwrite("Stopped actor ~n"),
                        exit(normal);

        {Num} -> io:fwrite("Result: ~p~n", [Fun(Num)]);
        {Num, 0} -> io:fwrite("Result: ~p~n", [Fun(Num)]);
        {Num, Rep} -> first ! {Fun(Num), Rep-1}
    end,
    last_actor(Fun).

loop(Fun, Next) ->
    receive

        {stop_signal} -> io:fwrite("Stopped actor ~n"),
                            Next!{stop_signal},
                            exit(normal);

        {Num} -> Next ! {Fun(Num)};
        {Num, Rep} -> Next ! {Fun(Num), Rep}

    end,
    loop(Fun, Next).