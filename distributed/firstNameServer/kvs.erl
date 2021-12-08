-module(kvs).
-export([start/0, store/2, lookup/1]).

% start the server with the registered name 'kvs'
start() -> register(kvs, spawn(fun() -> loop() end)).

% associate the key to the value
store(Key, Value) -> rpc({store, Key, Value}).

% look for a key and return the value or undefined
lookup(Key) -> rpc({lookup, Key}).

rpc(Q) ->
    kvs ! {self(), Q},
    receive
        {kvs, Reply} ->
            Reply
    end.

% put and get are primitives
loop() ->
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, true},
            loop();
        {From, {lookup, Key}} ->
            From ! {kvs, get(Key)},
            loop()
    end.


% % faccio partire i due nodi di erl
% erl -sname terminalOne
% erl -sname terminalTwo
% % si aprono così i terminali. terminalOne/Two e aubbiali sono degli atomi che ci servono
% (terminalOne@aubbiali)1>
% (terminalTwo@aubbiali)1>

% % ho messo in comunicazione due nodi erl
% % store [weather, fine] in terminalTwo@aubbiali
% (terminalOne@aubbiali)1> rpc:call(terminalTwo@aubbiali, kvs, store, [weather, fine]).
%     true
% % lookup [weather] in terminalTwo@aubbiali
% (terminalOne@aubbiali)2> rpc:call(terminalTwo@aubbiali, kvs, lookup, [weather]).
%     {ok,fine}

% % start the server
% (terminalTwo@aubbiali)1> kvs:start().
%     true
% % lookup the weather stored by terminalOne
% (terminalTwo@aubbiali)2> kvs:lookup(weather).
%     {ok,fine}



