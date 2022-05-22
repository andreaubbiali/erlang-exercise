-module(function).
-export([start/1]).

start(Num) -> [Fst|Rst] = start_processes(Num-1, []),
                Fst!{ciao, Fst, Rst++[Fst], Num+1}.


start_processes(0, Lst)          -> Lst;
start_processes(Num, Lst)        -> start_processes(Num-1, Lst++[spawn(fun()-> loop() end)]).


loop() -> 
    receive

    {Msg, Fst, [Next|Rst], 0}                                  -> io:fwrite("Arrivato msg: ~s ~n", [Msg]),
                                                                Next!{Msg, Fst, Rst++[Next], 0};

    {Msg, Fst, [Next|Rst], Num} when Fst == self()               -> io:fwrite("Arrivato msg: ~s ~n", [Msg]),
                                                                Next!{Msg, Fst, Rst++[Next], Num-1},
                                                                loop();

    {Msg, Fst, [Next|Rst], Num}                                -> io:fwrite("Arrivato msg: ~s ~n", [Msg]),
                                                                Next!{Msg, Fst, Rst++[Next], Num},
                                                                loop()

    end.
