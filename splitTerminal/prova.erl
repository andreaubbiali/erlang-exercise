-module(prova).
-export([start/0, sendMessage/0]).

start() -> io:fwrite("cookies: ~p~n", [net_kernel:connect_node('node2@aubbiali')]),
    % {second, 'node2@aubbiali'}!{hello}.
    spawn(node(), fun() -> start_second() end).
    % io:fwrite("dove è: ~p ~p~n", [PidSecond, self()]),
    % io:fwrite("dove è: ~p~n", [whereis(second)]).
    %{PidSecond, 'node2@aubbiali'}!{hello}.
    %register(aaa, PidSecond).

sendMessage()-> io:fwrite("dove è: ~p~n", [whereis(secondProcess)]).


% start_second() -> Pid = spawn(fun()-> start() end),
%                 register(second, Pid),
%                     io:fwrite("AAAAAAAAAAAA   ~p ~n",[Pid]).

start_second() -> 
    io:fwrite("AAAAAAAAAAAA   ~p ~n",[self()]),
    receive

        {hello}       -> io:fwrite("arrivato ~n")
    end.

% 
% erl -sname node2 -setcookie 'abc'
% erl -sname node1 -setcookie 'abc'

% In each of terminal to make the code work you have to compile the code.
% this is because the two nodes must have the code loaded to use it (you can compile the modules in each terminal or use a erl instruction idk which is). 

% fai partire un nodo e mandagli messagi, quando gli arriva qualcosa deve stampare ciò che gli arriva nel suo terminale
% quello che vorrei quindi fare è:
% start node1
% start node2

% node1 manda un messaggio a node2
% node2 stampa sul suo terminale quello che è arrivato

% problema che non riesco a far stampare node2 nel suo termnale, probabilmente non si può.