% REMEMBER the two nodes must have same cookies

-module(server).
-export[start/2, start_process/1].

start(NodeName, Name) -> process_flag(trap_exit, true),
                        spawn_link(NodeName, server, start_process, [Name]).


start_process(Name) -> group_leader(whereis(user), self()),
                        io:fwrite("STO PARTENDO~n"),
                        register(Name, self()),
                        loop(Name).

loop(Name) -> 
    receive

        stopit          -> io:fwrite("STOPPING~n"),
                            unregister(Name),
                            exit(normal);

        Msg             -> io:fwrite("MESSAGGIO ricevuto ~p~n", [Msg]),
                            loop(Name)

    end.