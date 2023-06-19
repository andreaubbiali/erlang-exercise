-module(combinator).
-export[start/2].

start(N, M) -> spawn_slaves(N, M, trunc(math:pow(M, N))), loop_wait_resp(N, []).

loop_wait_resp(0, Lst) -> printa(Lst);
loop_wait_resp(N, Lst) ->
    receive

        {NumCol, NewLst} when NumCol == N -> loop_wait_resp(N-1, Lst++[{NumCol, NewLst}])

    end.


spawn_slaves(1, M, Tot) -> spawn_link(generator, loop, [self(), 1, M, Tot]);
spawn_slaves(Num, M, Tot) -> spawn_link(generator, loop, [self(), Num, M, Tot]),
                    spawn_slaves(Num-1,M, Tot).


printa([{_,[]}|_]) -> 
    ok;

printa([{1,[H|TT]}|T]) -> 
    io:fwrite("~p ~n", [H]),
    printa(T++[{1, TT}]);

printa([{Num,[H|TT]}|T]) -> 
    io:fwrite("~p,", [H]),
    printa(T++[{Num, TT}]).