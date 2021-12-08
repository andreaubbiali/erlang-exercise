% Write a function that creates a registered process that writes out "I'm still
% running" every five seconds. Write a function that monitors this process
% and restarts it if it dies. Start the global process and the monitor process.
% Kill the global process and check that it has been restarted by the monitor
% process.
-module(exercise).
-export([createProcess/1, timer/3, createProcessMonitor/1, killProcess/1]).

% create a process that print every 5 seconds "im still running"
createProcess(AnAtom) ->
    Pid = spawn(fun() -> timer(5000, "I'm still running", self()) end),
    register(AnAtom, Pid).


timer(Time, Str, Who) ->
    receive
        cancel ->
            void
    after Time ->
        io:format("Pid: ~p scrive: ~p~n", [Who, Str]),
        timer(Time, Str, Who)
    end.


% create a process that monitor the process AnAtomToMonitor
createProcessMonitor(AnAtomToMonitor)->
    spawn(fun() -> 
                Ref = monitor(process, AnAtomToMonitor),
                receive
                    {'DOWN', Ref, process, Pid, Why} ->
                        io:format("Il processo ~p è morto con la why: ~p~n", [Pid, Why]),
                        createProcess(AnAtomToMonitor),
                        createProcessMonitor(AnAtomToMonitor)
                end
            end
        ).


% kill process registered with AnAtom
killProcess(AnAtom) ->
    Pid = whereis(AnAtom),
    exit(Pid, "CIAO FRA SONO USCITO").


% esempio di esecuzione
1> c(exercise).
    {ok,exercise}
2> exercise:createProcess(prova).
    true
    Pid: <0.87.0> scrive: "I'm still running"
    Pid: <0.87.0> scrive: "I'm still running"
3> exercise:createProcessMonitor(prova).
    <0.89.0>
    Pid: <0.87.0> scrive: "I'm still running"
    Pid: <0.87.0> scrive: "I'm still running"
4> exercise:killProcess(prova).
    Il processo {prova,nonode@nohost} è morto con la why: "CIAO FRA SONO USCITO"
    true                    %MUORE MA SI RICREA
    Pid: <0.91.0> scrive: "I'm still running"
5> exercise:killProcess(prova).
    Il processo {prova,nonode@nohost} è morto con la why: "CIAO FRA SONO USCITO"
    true                    %MUORE MA SI RICREA
    Pid: <0.94.0> scrive: "I'm still running"
