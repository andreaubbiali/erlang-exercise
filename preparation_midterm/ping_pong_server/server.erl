-module(server).
-export[startserver/0].
-import(client, [start_client/0]).

startserver() -> register(s, self()),
            spawn(fun() -> client:start_client() end),
            loop().

loop() -> 
    receive
        {stopServer}        -> io:fwrite("Server stopped~n"),
                                unregister(s);
        Msg                 -> io:fwrite("Msg to server: ~p~n", [Msg]),
                                loop()
    end.
