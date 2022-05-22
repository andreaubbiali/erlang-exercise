-module(function).
-export([start/1]).

start(Num) -> PidFst = spawn(fun() -> loop(first, second) end),
            PidSnd = spawn(fun() -> loop(second, first) end),
            register(first, PidFst),
            register(second, PidSnd),
            PidFst!{ciao, Num}.

loop(Me, Friend) ->
    receive
        {_, 0}                          -> io:fwrite("fine~n"),
                                            unregister(Me),
                                            unregister(Friend);
        {Msg, Num} when Me == first     -> whereis(Friend)!{Msg, Num},
                                            io:fwrite("processo  ~s arrivato msg ~s ~n", [Me, Msg]),
                                            loop(Me, Friend);
        {Msg, Num}                      -> whereis(Friend)!{Msg, Num-1},
                                            io:fwrite("processo  ~s arrivato msg ~s ~n", [Me, Msg]),
                                            loop(Me, Friend)
    end.