-module(server).
-export[start/1].

start(Node) -> spawn(Node, fun() -> start_other_node() end).

start_other_node() -> register(prova, self()),
                        group_leader(whereis(user),self()),
                        loop().

loop() ->
    receive

        Msg -> io:fwrite("~p~n", [Msg])

    end.