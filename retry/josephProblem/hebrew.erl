-module(hebrew).
-export[loop/1].

loop(MyNum) ->
    receive

        {kill, [_|[]], _, _} -> io:fwrite("Joseph is the Hebrew in position ~p~n", [MyNum]);
        
        {kill, [H|T], 0, TotHop} -> H ! {kill, lists:droplast(T)++[H], TotHop, TotHop},
                                    exit(normal);

        {kill, [H|T], Hop, TotHop} -> H ! {kill, T++[H], Hop-1, TotHop}

    end,
    loop(MyNum).