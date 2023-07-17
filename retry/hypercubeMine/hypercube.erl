-module(hypercube).
-export[create/0, hamilton/2, gray/1].

gray(1) -> ["0", "1"];
gray(Num) -> 
    Tmp = gray(Num-1),
    ["0"++X || X <- Tmp] ++ ["1"++X || X <- lists:reverse(Tmp)].

create() -> 
    Lst = [{X, spawn(node, create_node, [X])} || X <- gray(4)],
    Neigh = create_neight_list(Lst, Lst, []),
    [from_num_to_pid(Nu, Lst) ! {neighbour, Ne} || {Nu, Ne} <- Neigh],
    {_, FirstPid} = lists:nth(1, Lst),
    register(first, FirstPid).

hamilton(Msg, [H|T]) -> 
    first!{src, H, msg, Msg, T, self()},
    receive
        Resp -> io:fwrite("~p~n", [Resp])
    end.

create_neight_list([], _, Lst) -> Lst;
create_neight_list([{H,_}|T], Pids, Lst) -> 
    create_neight_list(T, Pids, Lst++[create_neighbour(H, Pids)]).

create_neighbour(Num, Pids) ->
    Lst = [strxor(Num, X) || X <- ["0001", "0010", "0100", "1000"]],
    {Num, [{X, from_num_to_pid(X, Pids)} || X <- Lst]}.

strxor([],[]) -> [];
strxor([H1|T1],[H2|T2]) ->
    [(H1 bxor H2)+$0 |strxor(T1,T2)].

from_num_to_pid(Num, [{N, Pid}|_]) when Num == N ->  Pid;
from_num_to_pid(Num, [_|T]) -> from_num_to_pid(Num, T).