-module(generator).
-export[generate/3].

generate(M, N, Pos) -> 
    Numbers = createNumbers(M ,[]),
    Repetitions = round(math:pow(M, Pos)),
    RepTot = round(math:pow(M, N)),
    Lst = generateLst(Numbers, Repetitions, RepTot, []),
    loop(Lst, Pos).

createNumbers(0, Lst) -> Lst; 
createNumbers(N, Lst) -> createNumbers(N-1, [N] ++ Lst). 


generateLst(_, _, 0, Lst) -> Lst;
generateLst([H|T], Rep, RepTot, Lst) -> N = lists:append(Lst, createLst(H, Rep, [])),
                                        generateLst(lists:append(T, [H]), Rep, RepTot-Rep, N).


createLst(_, 0, Lst) -> Lst; 
createLst(Num, Rep, Lst) -> createLst(Num, Rep-1, [Num] ++Lst).


loop([H|[]], Pos) ->
    receive
        get -> master!{H, Pos}
    end;
loop([H|T], Pos) ->
    receive
        get -> master!{H, Pos}
    end,
    loop(T, Pos).


% generate(1, 3)
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
