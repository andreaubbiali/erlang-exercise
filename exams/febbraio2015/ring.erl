-module(ring).
-export([start/2, send_message/1, send_message/2, stop/0]).

start(NumActor, F) -> register(first, spawn(fun()-> start_processes(NumActor, F) end)),
                        register(master, spawn(fun()-> loop_master() end)).

send_message(Value) -> whereis(first)!{Value}.

send_message(Value, NumRep) -> whereis(first)!{Value, NumRep}.

stop()  -> whereis(first)!killEnd.

start_processes(1, [H|[]]) -> loop(H, whereis(master));
start_processes(N, [H|T])  -> loop(H, spawn(fun()-> start_processes(N-1, T) end)).


loop(F, Next) -> 
    receive

        killEnd -> Next!killEnd;

        {Input}       -> Next!{F(Input)},
                         loop(F, Next);
        
        {Input, NumRep}     -> Next!{F(Input), NumRep},
                            loop(F, Next)

    end.


loop_master()   ->
    receive

        killEnd   -> io:fwrite("killed~n");

        {Result}    -> io:fwrite("result: ~p~n", [Result]),
                    loop_master();

        {Result, 2}    -> whereis(first)!{Result},
                            loop_master();

        {Result, NumRep}    -> whereis(first)!{Result, NumRep-1},
                            loop_master()

    end.