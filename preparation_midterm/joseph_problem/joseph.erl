%creates the ring according to the n and k passed as arguments and coordinates the initial and final messages
-module(joseph).
-export[joseph/2].

joseph(Men, Hop) -> 
    io:fwrite("In a circle of ~p people, killing number ~p~n", [Men, Hop]),
    [H|T] = start_processes(Men, []),
    %io:fwrite("~p~n", [[H]++T]),
    %H!{Hop, Hop-1, T++[H], self()},
    H!{Hop, Hop-1, T, self()},
    loop().


start_processes(0, Lst)      -> lists:reverse(Lst);
start_processes(Men, Lst)    -> start_processes(Men-1, Lst++[spawn(hebrew, loop, [Men])]).

loop() ->
    receive

        LastAlive -> io:fwrite("Joseph is the Hebrew in position ~p~n", [LastAlive])

    end.