-module(storage).
-export([loop/1]).

loop(Lst) ->
    receive
        {getValue, Tag}       -> find(Lst, Tag);
        {Email, Tag}          -> loop(Lst++[{Email, Tag}]);
        _                     -> io:fwrite("NOT ACCEPTED"),
                                    loop(Lst)
    end.

find([], _)                                             -> io:fwrite("There is no tag associated~n");
find([{Email, Tag}|_], TagToFind) when Tag == TagToFind -> io:fwrite("Email: ~p Tag: ~p~n", [Email, Tag]);
find([_|T], TagToFind)                                  -> find(T, TagToFind).

% si potevano usare per lo storage delle direttive di erlang come get/put. 
% vedi l'esercizio in distributed/firstNameServer/kvs.erl