% to compile: 
% c(hello)
% hello:start().

% oppure:
% erlc hello.erl
% erl -noshell -s hello start -s init stop

-module(hello).
-export([start/0]).

start() -> io:format("Hello world ~n").