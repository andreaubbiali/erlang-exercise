-module(generator).
-export[loop/4].

loop(RespTo, MyNum, M, Tot) -> 
    RespTo ! {MyNum, create_lst([X || X <- lists:seq(1, M)], trunc(math:pow(M, MyNum-1)), Tot, [])}.

create_lst(_, _, 0, Lst) -> 
    Lst;
create_lst([H|T], Rep, Tot, Lst) -> 
    New = [H || _ <- lists:seq(1, Rep)],
    create_lst(T++[H], Rep, Tot-length(New), Lst++New). 
    
    