-module(combinator).
-export[start/2].

start(M, N) -> 
    register(master, self()),
    Pids = start_processes(N, M, M-1, []),
    printComb(round(math:pow(N, M)), M-1, Pids).

start_processes(M, N, 0, Lst) -> lists:reverse(Lst++[spawn(generator, generate, [M, N, 0])]);
start_processes(M, N, Pos, Lst) -> NewLst = Lst++[spawn(generator, generate, [M, N, Pos])],
                                start_processes(M, N, Pos-1, NewLst).


printComb(1, Pos, LstPid) -> 
    request(LstPid),
    receivePos(Pos),
    unregister(master);
printComb(RepTot, Pos, LstPid) ->
    request(LstPid),
    receivePos(Pos),
    printComb(RepTot-1, Pos, LstPid).

receivePos(0) ->
    receive
        {Num, _} -> io:fwrite("~p~n", [Num])
    end;

receivePos(Pos) ->
    receive
        {Num, P} when Pos == P -> io:fwrite("~p ", [Num])
    end,
    receivePos(Pos-1).


request([H|[]]) -> H!get;
request([H|T]) -> H!get,
                    request(T).



% 3^1(ripeti ogni 3^1 volte numeri 1-3)-3^0(ripeti ogni 3^0 volte numeri 1-3) --> tutto per arrivare ad una lista lunga 3^2
% 5> combinator:start(2,3).
% 1, 1
% 1, 2
% 1, 3
% 2, 1
% 2, 2
% 2, 3
% 3, 1
% 3, 2
% 3, 3

% generate(2, 2)
% 4> combinator:start(3,2).
% 1, 1, 1
% 1, 1, 2
% 1, 2, 1
% 1, 2, 2
% 2, 1, 1
% 2, 1, 2
% 2, 2, 1
% 2, 2, 2