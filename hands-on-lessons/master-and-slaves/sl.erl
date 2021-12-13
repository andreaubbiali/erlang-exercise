% module slave
-module(sl).
-export([loop/0]).

loop()  ->
    receive
        {die, _}                 -> exit(master, prova);
        {Message, N}             -> io:fwrite("Slave ~p got message: ~p~n", [N, Message]),
                                    loop()
    end.
