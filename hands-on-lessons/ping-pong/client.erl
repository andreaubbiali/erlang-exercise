-module(client).
-export([start/0]).

start()    ->
    Pid = spawn(fun()->create()end),
    erlang:register(client, Pid).

create()    ->
    Pid = whereis(process),
    erlang:link(Pid),
    loop().

loop() ->
    receive 
        "stop"            -> io:fwrite("Block spawned and also me"), 
            process!{stop, stop};
        Msg             -> process!{ok,Msg},
                                loop()
    end.