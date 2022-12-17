% prove per capire come spawnare i processi e mantenere o meno un legame nel crashing

-module(prova).
-export[start/0].

start() ->
    spawn(fun()-> start_system() end).

start_system() ->
    %process_flag(trap_exit, true),
    %spawn(fun()->inverse(4) end),
    spawn_link(fun()->inverse(2) end),
    loop().

loop() ->
    receive
        Msg -> io:format("MESSAGGIO arrivato: ~p~n", [Msg])
    
    after
        3000 -> io:fwrite("ERO ANCORA ATTIVO, termino~n") 
    end.

inverse(N) -> _ = 1/N, 
                exit(normal).