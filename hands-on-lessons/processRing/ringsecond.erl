% second manner: new process spawning the next process in the ring. With this strategy, you have to find 
% a method to connect the first process to the second process.

-module(ringsecond).
-export([start/3]).

start(M, N, Message) -> io:fwrite("i'm the spawner: ~p ~n", [self()]),
                        Pid = create_processes(N),
                        io:fwrite("Processes created ~n"),
                        send_messages(M, Message, Pid),
                        io:fwrite("Send end ~n"),
                        send_messages(1, ended, Pid).


% link is used only because if a linked process crash also the other crash
create_processes(N)    -> spawn(fun()->receiver(N-1, new)end).

send_messages(0, _, _)          -> io:fwrite("end send messages ~n");
send_messages(M, Msg, Pid)        -> Pid!{Msg},
                                send_messages(M-1, Msg, Pid).


receiver(N, new)->
    Pid = spawn(fun()->receiver(N-1, new)end),
    receive
        {ended}     -> io:fwrite("i'm: ~p ended ~n", [self()]);
        {Msg}       -> io:fwrite("i'm: ~p i've received: ~s ~n", [self(), Msg]),
                        Pid!{Msg},
                        receiver(0, Pid)
    end;
receiver(0, new)->
    receive
        {ended}     -> io:fwrite("i'm: ~p ended ~n", [self()]);
        {Msg}       -> io:fwrite("i'm: ~p i've received: ~s ~n", [self(), Msg]),
                        receiver(0, new)
    end;
receiver(0, Pid)->
    receive
        {ended}     -> io:fwrite("i'm: ~p ended ~n", [self()]);
        {Msg}       -> io:fwrite("i'm: ~p i've received: ~s ~n", [self(), Msg]),
                        Pid!{Msg},
                        receiver(0, Pid)
    end.
