-module(echo).
-export[start/0, print/1, stop/0].
-import(server, [startserver/0]).

start() -> starts(isAlreadyStarted(registered())).

print(Term) -> s!Term.

stop() -> s!{stopServer}.

starts(false) -> spawn(fun() -> server:startserver() end);
starts(true) -> io:fwrite("A server instance is already in use~n").

isAlreadyStarted([]) -> false;
isAlreadyStarted([H|_]) when H == s -> true;
isAlreadyStarted([_|T]) -> isAlreadyStarted(T).
