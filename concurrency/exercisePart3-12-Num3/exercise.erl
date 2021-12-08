% Write a ring benchmark. Create N processes in a ring. Send a message
% round the ring M times so that a total of N * M messages get sent. Time
% how long this takes for different values of N and M .
% Write a similar program in some other programming language you are
% familiar with. Compare the results. Write a blog, and publish the results
% on the Internet!

-module(exercise).
-export([start/1, createProcess/2, inviaMessaggi/2, send/2, receiver/0]).

start(Num) -> 
    List = createProcess(Num, []),
    inviaMessaggi(List, List).


% funzione che crea n processi receiver e ritorna la lista con i loro PID
createProcess(0, List) -> List;
createProcess(NumProcessi, List) -> 
    Pid = spawn(fun()->receiver()end),
    L = [Pid | List],
    createProcess(NumProcessi-1, L).


% scandisce la lista per far si che ogni processo invii un messaggio ad ognuno degli altri processi
inviaMessaggi([], _PidList) -> io:format("Tutti i processi della lista hanno finito di inviare");
inviaMessaggi(RemainSender, PidList) ->
    [H|T] = RemainSender,
    send(H, PidList),
    inviaMessaggi(T, PidList).


% invia effettivamente i messaggi da un processo agli altri della lista
send(Pid, []) -> io:format("Il processo ~p ha finito di inviare ~n", [Pid]);
send(Pid, PidList) -> 
    [H|T] = PidList,
    H!{Pid, "inviato"},
    send(Pid, T).


receiver() ->
    receive
        {From, Msg} ->
            io:format("Arrivato il msg ~p dal PID: ~p~n", [Msg , From]),
            receiver()
    end.
