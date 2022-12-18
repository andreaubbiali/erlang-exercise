-module(server).
-export[start/1].

start(Name) -> group_leader(whereis(user), self()),
                register(Name, self()),
                loop(Name, maps:new()).


loop(Name, Map) ->
    receive
        stopit                                              -> io:fwrite("[~p] termino~n", [Name]),
                                                                unregister(Name),
                                                                exit(normal);

        {put, Key, Value}                                   -> io:fwrite("[~p] salvo key: ~p value: ~p~n", [Name, Key, Value]),
                                                                loop(Name, maps:put(Key, Value, Map));

        {get, Key, ResponseTo}                                    -> io:fwrite("[~p] richiesta get key: ~p ~n", [Name, Key]),
                                                                respond_get(maps:is_key(Key, Map), Map, Key, ResponseTo);
        
        Msg                                                 -> io:fwrite("[~p] ricevuto: ~p~n", [Name, Msg])

    end,
    loop(Name, Map).

respond_get(true, Map, Key, Resp)  -> Resp ! maps:get(Key, Map);
respond_get(false,_, _, Resp)      -> Resp ! {no_existing_key}.