-module(server).
-export([start/0,dummy1/0, dummy2/0, dummy3/0, tot/0]).

start() -> Pid = spawn(fun()->counting:loop([]) end),
        register(server, Pid).

dummy1() -> server!{"dummy1"}.

dummy2() -> server!{"dummy2"}.

dummy3() -> server!{"dummy3"}.

tot()   -> server!{"tot"}.