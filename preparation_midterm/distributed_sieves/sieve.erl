-module(sieve).
-export[loop/3].

loop(Num, ResTo, Next) ->
    io:fwrite("Num: ~p, mypid: ~p~n", [Num, self()]),
    receive

        quit    -> Next!quit,
                    exit(normal);

        %i'm the last
        {new, N, Client} when ResTo == Next -> io:fwrite("ARRIVA A LAST~n"),
                                                ResTo!{resp, check_last(N, Num), Client};

        {new, N, Client} when Num >= N -> io:fwrite("ARRIVA A Minore~n"), 
                                        ResTo!{resp, true, Client};
        
        {new, N, Client} -> io:fwrite("ARRIVAw  qe~n"),
                            check(N, Client, round(math:fmod(N, Num)) == 0, {ResTo, Next});

        {resp, Resp, Client} -> io:fwrite("ARRIVA A RISULTATO~n"),
                                ResTo!{resp, Resp, Client}
        
    end,
    loop(Num, ResTo, Next).

check_last(N, Num) -> round(math:fmod(N, Num)) == 0.


check(_, Client, true, {ResTo, _}) -> ResTo!{resp, false, Client};
check(N, Client, false, {_, Next}) -> Next!{new, N, Client}.