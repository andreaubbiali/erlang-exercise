### compilazione

to compile: 
    c(hello).
    hello:start().

oppure:
    erlc hello.erl
    erl -noshell -s hello start -s init stop

Attenzione:
    se ho due moduli (vedi shopping directory) seppur un modulo utilizzi una funzione di un altro modulo, puoi comunque compilarli non in sequenza ed il compilatore non ti da alcun errore. L'errore te lo da se non compili uno dei due moduli e ti dice quindi, giustamente, che non trova la definizione di tale funzione.

### Other
regs().         -> ritorna tutti i processi attivi in erlang

### Errors
when you monitor a process and it crash it send an error message to the monitor. The message is of type:
    {'DOWN', _, process, Pid, _} 

## Good examples

For a good example take a look to examRitirato.

Rircorda di utilizzare la libreria erlang standard per fare register in modo tale da poter fare l'unregister.
Vedi l'esempio che ho fatto bene in examRitirato.

- vedi esempio in preparation_midterm/distributed_associative_store

# FROM FLOAT TO INT

round(3.0).
trunc(3.0)

### WORK WITH INTEGER NUMBER
- remainder of integer number
```
5 rem 4
```
- division of integer number
```
5 div 4
```

### isprime using case

is_prime(_, 1) -> true;
is_prime(Num, Div) ->
    case (Num rem Div) =:= 0 of
        true -> false;
        _ -> isPrime(Num, Div-1)
    end.