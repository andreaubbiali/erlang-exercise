-module(dist_demo).
-export([rpc/4, start/1]).

start(Node) ->
    spawn(Node, fun() -> loop() end).

rpc(Pid, M, F, A) ->
    Pid ! {rpc, self(), M, F, A},
    receive
        {Pid, Response} ->
            Response
    end.

loop() ->
    receive
        {rpc, Pid, M, F, A} ->
            Pid ! {self(), (catch apply(M, F, A))},
            loop()
    end.


% start two nodes
erl -sname nodeOne -setcookie abc
erl -sname nodeTwo -setcookie abc

% spawn a process in nodeTwo
(nodeOne@aubbiali)1> Pid = dist_demo:start(nodeTwo@aubbiali).
    <8758.91.0>
% return the name of the node where the Pid is working
(nodeOne@aubbiali)2> dist_demo:rpc(Pid, erlang, node, []).
    nodeTwo@aubbiali
