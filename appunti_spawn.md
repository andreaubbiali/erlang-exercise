# Spawn process

In generale (esistono anche altri metodi) puoi spawnare i processi in diversi modi:

1. I don't care if my child process dies:
    
    ```erlang
    spawn(...).
    ```
    
    spawni il nuovo processo ma te ne freghi di tutto quello che può succedere, anche se dovesse crashare non ce ne frega nulla.
    
2. I want to crash if my child process crashes:
    
    ```erlang
    spawn_link(...).
    ```
    
    spawni il processo e nel caso in cui dovesse crashare crasho anche io automaticamente.
    
3. I want to receive a message if my child process terminates (normally or not):
    
    ```erlang
    process_flag(trap_exit, true),
    spawn_link(...).
    ```
    
    spawno processo e in qualsiasi modo finisca, mi viene inviato un messaggio

# ESEMPIO 1


```erlang
-module(prova).
-export[start/0].

start() ->
    spawn(fun()-> start_system() end).

start_system() ->
    spawn(fun()->inverse(NUMBER) end),
    loop().

loop() ->
    receive
        Msg -> io:format("MESSAGGIO arrivato: ~p~n", [Msg])
    
    after
        2500 -> io:fwrite("ERO ANCORA ATTIVO, termino~n")
    end.

inverse(N) -> _ = 1/N, 
                exit(normal).
```

OUTPUT:

IF `NUMBER == 0` 

    viene stampato a terminale che il processo figlio è crashato, tuttavia il processo padre è ancora attivo e dopo 2500 ms si chiuderà con il messaggio “ero ancora attivo…”

ELSE

    niente, dopo 2500 ms stampato messaggio “ero ancora attivo…”

# ESEMPIO 2

```erlang
-module(prova).
-export[start/0].

start() ->
    spawn(fun()-> start_system() end).

start_system() ->
    spawn_link(fun()->inverse(NUMBER) end),
    loop().

loop() ->
    receive
        Msg -> io:format("MESSAGGIO arrivato: ~p~n", [Msg])
    
    after
        2500 -> io:fwrite("ERO ANCORA ATTIVO, termino~n") 
    end.

inverse(N) -> _ = 1/N, 
                exit(normal).
```

OUTPUT:

IF `NUMBER == 0` THEN

    sia processo padre che figlio crashano

ELSE

    niente, dopo 2500ms stampato “era ancora attivo…”

# ESEMPIO 3

```erlang
-module(prova).
-export[start/0].

start() ->
    spawn(fun()-> start_system() end).

start_system() ->
    process_flag(trap_exit, true),
    spawn_link(fun()->inverse(NUMBER) end),
    loop().

loop() ->
    receive
        Msg -> io:format("MESSAGGIO arrivato: ~p~n", [Msg])
    
    after
        3000 -> io:fwrite("ERO ANCORA ATTIVO, termino~n") 
    end.

inverse(N) -> _ = 1/N, 
                exit(normal).
```

OUTPUT:

IF `NUMBER == 0` THEN

    stampato messaggio “MESSAGGIO arrivato : tutte le informazioni riguardo l’errore

ELSE

    stampato messaggio “MESSAGGIO arrivato: exit, uscita normale