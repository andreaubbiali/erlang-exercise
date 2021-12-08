% Write a server that will wait in a receive loop until a message is sent to it. Depending on the message, it should either print its contents 
% and loop again, or terminate. You want to hide the fact that you are dealing with a process, and access its services through a functional interface,
% which you can call from the shell.

% This functional interface, exported in the echo.erl module, will spawn the process and send messages to it. The function interfaces are shown here:

%     echo:start() ⇒ ok
%     echo:print(Term) ⇒ ok
%     echo:stop() ⇒ ok

% Hint: use the register/2 built-in function, and test your echo server using the process manager.

% Warning: use an internal message protocol to avoid stopping the process when you, for example, call the function echo:print(stop).

% Then write a client to be connected to such a server and link these two processes each other. When the stop function is called, instead of sending
%  the stop message, make the first process terminate abnormally. This should result in the EXIT signal propagating to the other process, causing it to terminate as well.

-module(pingpong).
-export([loop/0]).

loop() ->
    receive 
        {stop, stop}      -> exit("EXIIIIT");
        {_, Msg}          -> io:fwrite("ricevuto il messaggio ~s ~n", [Msg]),
                        loop()
    end.

% regs(). -> ti ritorna tutti i processi di erl attivi
% il programma è un pò una rivisitazione perchè non si capisce.
% se fai partire echo crea un processo col nome process
% usando echo possiamo fare diverse cose tipo inviare a process messaggi/stopparlo
% con client creiamo un'ultereiore processo col nome client
% usando client!something inviamo al process something e se something == "stop" allora il process si stoppa ed essendo linkato anche il client si stoppa