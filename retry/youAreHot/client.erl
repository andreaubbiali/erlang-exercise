-module(client).
-export[convert/5].

convert(from, From, to, To, Value) -> 
    From ! {From, To, Value, self()},
    receive

        {res, F, T, V} -> io:fwrite("~p°~p are equivalent to ~p°~p~n", [Value, F, V, T])

    end.