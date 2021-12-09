% Write a module counting which provides the functionality for interacting with a server that counts how many times its services has been requested.

% It has to implement several services dummy1, ... dummyn (doesn't matter what they do or their real interface) and a service tot that returns a list 
% of records indexed on each service (tot included) containing also how many times such a service has been requested. Test it from the shell.

-module(counting).
-export([loop/1]).

loop(Lst)  ->
    receive
        {"tot"}         -> io:fwrite("~p ~n", [Lst]),
                            loop(Lst);
        {NewRecord}     -> io:fwrite("qua pure~n"),
                        loop(create_list(Lst, {NewRecord, 1}, []))
    end.


create_list([], {New, Num}, [])                                          -> [{New, Num}];
create_list([], {New, 1}, EndLst)                                        -> EndLst++[{New, 1}];
create_list([], {_, 0}, EndLst)                                          -> EndLst;
create_list([{H, Numb}|T], {New, _}, EndLst) when H == New               -> create_list(T, {New, 0}, EndLst++[{New, Numb+1}]);
create_list([H|T], {New, Num}, EndLst)                                   -> create_list(T, {New, Num}, EndLst++[H]).