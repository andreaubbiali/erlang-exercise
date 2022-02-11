-module(ring).
-export([start/2, send_message/1, send_message/2, stop/0]).

start(NumActor, Funct) ->
            First = spawn_link(fun() -> spawna_and_start(1, NumActor, Funct) end),
            register(firstProcess, First),
            register(ringProcess, spawn(fun() -> ring() end)).

send_message(Num) -> firstProcess!{Num}.

send_message(Num, Repeat) -> firstProcess!{loop, Repeat-1, Num}.

stop() -> firstProcess!{killActor}.


ring() ->
    receive

        {killRing}                              -> unregister(ringProcess);

        {loop, NumLoop, Res} when NumLoop == 0  ->  io:fwrite("Result: ~p~n", [Res]),
                                                    ring();

        {loop, NumLoop, Res}                    ->  firstProcess!{loop, NumLoop-1, Res},
                                                    ring();

        {Res}                                   -> io:fwrite("Result: ~p~n", [Res]),
                                                    ring()
    end.

spawna_and_start(MyNum, NumActor, [F|_]) when MyNum == NumActor -> 
                    actor:loop(MyNum, F, 0);
spawna_and_start(MyNum, NumActor, [F|T]) when MyNum < NumActor -> 
                    NextPid = spawn_link(fun() -> spawna_and_start(MyNum+1, NumActor, T) end),
                    actor:loop(MyNum, F, NextPid).