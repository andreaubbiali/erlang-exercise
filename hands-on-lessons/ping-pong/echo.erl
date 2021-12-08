-module(echo).
-export([start/0, print/1, stop/0]).
-import(pingpong,[loop/0]).

start() -> 
    Pid = spawn(fun() -> loop() end),
    erlang:register(process, Pid).


print("stop")   ->  process!{ok,"stop"};
print(Msg)      ->  process!{ok,Msg}.

stop()  ->
    process!{stop,stop}.