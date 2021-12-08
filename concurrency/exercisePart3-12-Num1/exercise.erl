% Write a function start(AnAtom, Fun) to register AnAtom as spawn(Fun) . Make sure
% your program works correctly in the case when two parallel processes
% simultaneously evaluate start/2 . In this case, you must guarantee that one
% of these processes succeeds and the other fails.

-module(exercise).
-export([start/2, isNotRegistered/1]).

start(A, Fun) -> 
    IsNotRegistered = isNotRegistered(A),
    if IsNotRegistered ->
            Pid = spawn(fun() -> timer(10000, Fun) end),
            register(A, Pid);
        true->
            io:format("~nL'atomo è già registrato~n~n")
    end.    


isNotRegistered(AnAtom) ->
    Where = whereis(AnAtom),
    if Where == undefined ->
            true;
        true->
            false
    end.


timer(Time, Fun) ->
    receive
    after Time ->
        Fun()
    end.


% 20> c(exercise).                                                        
%   {ok,exercise}
% 21> Pid = exercise:start(prova, fun() -> io:format("~nCIAO FRA~n") end).
%       true
% 22> exercise:isNotRegistered(prova).
%   false
     
%   CIAO FRA
% 23> Pid = exercise:start(prova, fun() -> io:format("~nCIaaaA~n") end).  
%   true
% 24> Pid = exercise:start(prova, fun() -> io:format("~nCIdsadaA~n") end).

%   L'atomo è già registrato

%   ** exception error: no match of right hand side value ok
    
%   CIaaaA
