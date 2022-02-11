### Exam text

una funzione grossa solitamente la si divide in tante sotto funzioni. Con lo start viene settato il numero di attori e gli viene passata una lista di funzioni. Ogni attore applica una funzione al numero che riceve. L'ultimo attore ritorna a `ring` il numero dopo che sono state applicate tutte le funzioni.
Ring invia solo messaggi al primo attore poi sarà questo attore ad inviare il messaggio a quello dopo e così via.


ring:
start/2 (NumberActor, FunctLst) -> fa partire gli actors e gli passa la lista delle funzioni
send_message/1 (Num) -> invia messaggio al primo attore con un numero al quale applicare le varie funzioni
send_message/2 (NUm, Loop) -> nvia messaggio al primo attore e ripete Loop volte
stop/0 -> stop di tutti gli attori 

allo stop -> attori stampano che sono stati killati ("io numero sono stato killato")


problema avuto? mi sono ingarbugliato nel farlo.

L1 = [fun(X)-> X*N end||N<-lists:seq(1,7)].
ring:start(7,L1).

Un esempio di come deve funzionare è nell'esame Febbraio 2015


3 attori a b c

io spawno a che spawna b che spawna c
io ho il pid di a... a ha il pid di b... b ha il pid di c... c con whereis risponde a me