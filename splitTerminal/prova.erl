-module(prova).
-export([start/0, sendMessage/0, printa/0]).

start() ->  spawn('second@aubbiali', prova, printa, []).

sendMessage()-> {'second@aubbiali',second}!{hello, self()}.


printa() -> 
    fun()->
        io:fwrite("parte"),
        register(second, self()),
        receive

            {hello, OtherShell}       -> OtherShell!io:fwrite("arrivato ~n")

        end
end.