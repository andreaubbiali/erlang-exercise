-module(main).
-export[start_system/0, start_new_server/2, stop_system/0, get/1, put/2].

start_system() -> register(master, spawn(fun()-> loop([]) end)).

stop_system() -> master!stopit.

start_new_server(Node, Name) -> master!{add_server, Node, Name}.

get(Key) -> master!{get, Key}.

put(Key, Value) -> master!{put, Key, Value}.

loop([])        -> 
    receive
        {add_server, Node, Name}                    -> spawn(Node, server, start, [Name]),
                                                    loop([{Name, Node}])
    end;
loop([Next|T]) ->
    receive

        {add_server, Node, Name}                    -> spawn(Node, server, start, [Name]),
                                                    loop(Next++T++[{Name, Node}]);
                                                    
        {get, Key}                                  -> Next!{get, Key, {master, node()}};

        {put, Key, Value}                           -> put_each_server(Key, Value, [Next]++T);

        stopit                                      -> send_each_server(stopit, [Next]++T);

        Msg                                         -> io:fwrite("[main] ~p~n", [Msg])

    end,
    loop(T++[Next]).


put_each_server(Key, Value, [Next|[]])    -> Next ! {put, Key, Value};
put_each_server(Key, Value, [Next|T])     -> Next ! {put, Key, Value},
                                            put_each_server(Key, Value, T).

send_each_server(Msg, [Next|[]])  -> Next ! Msg,
                                    unregister(master);
send_each_server(Msg, [Next|T])   -> Next ! Msg,
                                    send_each_server(Msg, T).
