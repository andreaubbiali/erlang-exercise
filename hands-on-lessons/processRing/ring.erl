% Write a program that will create N processes connected in a ring. Once started, these 
% processes will send M number of messages around the ring and then terminate gracefully when they 
% receive a quit message. You can start the ring with the call ring:start(M, N, Message).

% There are two basic strategies to tackling this exercise. The first one is to have a central 
% process that sets up the ring and initiates sending the message. The second strategy consists 
% of the new process spawning the next process in the ring. With this strategy, you have to find 
% a method to connect the first process to the second process.

% Try to solve the exercise in both manners. Note, when writing your program, make sure your code 
% has many io:format statements in every loop iteration; this will give you a complete overview of 
% what is happening (or not happening) and should help you solve the exercise.

-module(ring).
-export([start/3]).

start(M, N, Message) -> io:fwrite("i'm the spawner: ~p ~n", [self()]),
                        Lst = create_processes(N, []),
                        io:fwrite("List of spawned: ~p ~n", [Lst]),
                        send_messages(M, Message, Lst),
                        io:fwrite("Send end to: ~p ~n", [Lst]),
                        send_messages_to_list(ended, Lst).


create_processes(0, Lst)    -> Lst;
create_processes(N, Lst)    -> Pid = spawn(fun()->receiver()end),
                            create_processes(N-1, Lst++[Pid]).

send_messages(0, _, _)          -> io:fwrite("end send messages ~n");
send_messages(M, Msg, Lst)      -> send_messages_to_list(Msg, Lst),
                                    send_messages(M-1, Msg, Lst).

send_messages_to_list(_, [])            -> io:fwrite("sended ~n");
send_messages_to_list(Msg, [H|T])       -> H!{Msg},
                                        send_messages_to_list(Msg, T).

receiver()->
    receive
        {ended}     -> io:fwrite("i'm: ~p ended ~n", [self()]);
        {Msg}       -> io:fwrite("i'm: ~p i've received: ~s ~n", [self(), Msg]),
                        receiver()
    end.


