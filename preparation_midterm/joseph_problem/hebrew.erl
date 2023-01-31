-module(hebrew).
-export[loop/1].

loop(Pos) -> 
    receive

        {_, _, [], MasterPid}        -> MasterPid!Pos;
        
        {Hop, RemHop, [H|T], MasterPid} when RemHop == 0   -> H!{Hop, Hop-1, T, MasterPid},
                                                        exit(normal);

        {Hop, RemHop, [H|T], MasterPid} -> H!{Hop, RemHop-1, T++[self()], MasterPid},
                                loop(Pos)

    end.


%-module(hebrew).
%-export[loop/1].
%
%loop(Pos) -> 
%    receive
%
%        {_, _, [], MasterPid}        -> io:fwrite("LAST~n"),MasterPid!Pos;
%        
%        {Hop, RemHop, [H|T], MasterPid} when RemHop == 0   -> io:fwrite("ELIMINA me:~p ~n", [Pos]), H!{Hop, Hop-1, T, MasterPid},
%                                                        exit(normal);
%
%        {Hop, RemHop, [H|T], MasterPid} -> io:fwrite("ARRIVA me:~p ~n", [Pos]), H!{Hop, RemHop-1, T++[self()], MasterPid},
%                                loop(Pos)
%
%    end.