-module(client).
-export[is_prime/1, close/0].

is_prime(Num) -> {controller, sif@aubbiali}!{new, Num, self()},
    receive

        tooBigValue -> io:fwrite("~p is uncheckable, too big value.~n", [Num]);

        Res -> io:fwrite("is ~p prime? ~p~n", [Num, Res])
    end.

close() -> {controller, sif@aubbiali}!close.