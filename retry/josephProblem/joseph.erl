-module(joseph).
-export[joseph/2].

joseph(NumHebrew, Hop) -> 
    [H|T] = create_ring(NumHebrew, []),
    io:fwrite("In a circle of ~p people, killing number ~p~n", [NumHebrew, Hop]),
    H ! {kill, T++[H], Hop-1, Hop-1}.


create_ring(1, Lst) ->
   lists:reverse(Lst++[spawn(hebrew, loop, [1])]);
create_ring(NumHebrew, Lst) ->
    create_ring(NumHebrew-1, Lst++[spawn(hebrew, loop, [NumHebrew])]).