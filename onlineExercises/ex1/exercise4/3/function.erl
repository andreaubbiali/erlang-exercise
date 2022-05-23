-module(function).
-export([start/2]).

start(NumProcess, NumLoop) -> Lst = start_processes(NumProcess, []),
                                PidMaster = spawn(fun()-> loopMaster(NumProcess, 1, Lst, NumLoop-1) end),
                                sendMsg(PidMaster, Lst).

start_processes(0, Lst) -> Lst;
start_processes(Num, Lst) -> start_processes(Num-1, Lst++[spawn(fun()-> loop() end)]).

loop() ->
    receive

        {Sender, Msg, last}     -> io:fwrite("Messaggio con last arrivato ~s~n", [Msg]),
                                    Sender!{received, last};

        {Sender, Msg}           -> io:fwrite("Messaggio arrivato ~s~n", [Msg]),
                                    Sender!{received},
                                    loop()

    end.


loopMaster(NumTot, NumReceived, Lst, NumLoop) ->
    receive


        {received, last} when NumLoop == 0, NumReceived == NumTot -> io:fwrite("master last dei last received: ~p~n", [NumReceived]);

        {received, last}        -> io:fwrite("master last received: ~p~n", [NumReceived]),
                                    loopMaster(NumTot, NumReceived+1, Lst, NumLoop);

        {received} when NumReceived == NumTot, NumLoop==1   -> io:fwrite("master received: ~p~n", [NumReceived]),
                                                            sendLastMsg(self(),Lst),
                                                            loopMaster(NumTot, 1, Lst, NumLoop-1);

        {received} when NumReceived == NumTot   -> io:fwrite("master received: ~p~n", [NumReceived]),
                                                    sendMsg(self(),Lst),
                                                    loopMaster(NumTot, 1, Lst, NumLoop-1);

        {received}                              -> io:fwrite("master received: ~p~n", [NumReceived]),
                                                    loopMaster(NumTot, NumReceived+1, Lst, NumLoop)


    end.


sendMsg(Pid, [Fst|[]]) -> Fst!{Pid, ciao};
sendMsg(Pid, [Fst|Rst]) -> Fst!{Pid, ciao},
                            sendMsg(Pid, Rst).

sendLastMsg(Pid, [Fst|[]]) -> Fst!{Pid, ciao, last};
sendLastMsg(Pid, [Fst|Rst]) -> Fst!{Pid, ciao, last},
                            sendLastMsg(Pid, Rst).
