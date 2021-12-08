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

