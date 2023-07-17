-module(node).
-export[create_node/1].

create_node(MyName) ->
    io:fwrite("The process labeled ~p just started~n", [MyName]),
    receive
        {neighbour, Neighbour} -> 
            loop(Neighbour);
        Other -> io:fwrite("ERROR ~p~n", [Other])
    end.

loop(Neighbour) ->
    receive

        {src, Num, msg, Msg, [], RespTo} ->
            RespTo!{src, Num, msg, Msg};
        
        {src, Num, msg, Msg, [H|T], RespTo} ->
            find_next(H, Neighbour) ! {src, H, msg, {src, Num, msg, Msg}, T, RespTo}

    end.

find_next(Next, [{N,Pid}|_]) when Next == N -> Pid; 
find_next(Next, [_|T]) -> find_next(Next, T).