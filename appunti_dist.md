# Distributed erlang

sappiamo che due nodi erlang possono dialogare tra di loro, ma come?

un semplice programma

```erlang
-module(server).
-export[start/1].

% spawn(Node, Module, Function, Args)

start(Name) ->
    register(Name, spawn(fun() -> loop(Name) end)).

loop(Name) -> 
    receive

        stopit          -> io:fwrite("STOPPING~n"),
                            unregister(Name);

        Msg             -> io:fwrite("MESSAGGIO ricevuto ~p~n", [Msg]),
                            loop(Name)

    end.
```

`TERMINAL UNO`

erl -sname uno -setcookie abc

```bash
server:start(prova).
```

`TERMINAL DUE`

erl -sname due -setcookie abc

```bash
{prova, 'uno@aubbiali'}!ciaobelo.
```

in **terminal uno** arriva il messaggio ciaobelo e viene stampato

**********************Attenzione:**********************

I cookie nei due terminali devono essere uguali altrimenti non funziona. La comunicazione può avvenire tra nodi che abbiano gli stessi cookie