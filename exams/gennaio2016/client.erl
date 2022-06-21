-module(client).
-export([convert/5]).


convert(from, Source, to, Target, Num) -> Source ! {Target, Num, self()},
    receive
        Res     -> io:fwrite("~p°~p are equivalent to ~p°~p~n", [Num, Source, Res, Target])
    end.
