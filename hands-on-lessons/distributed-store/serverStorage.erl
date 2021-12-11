% Design a distributed version of an associative store in which values are associated with tags. It is possible to store a tag/value pair, and to look up the 
% value(s) associated with a tag. One example for this is an address book for email, in which email addresses (values) are associated with nicknames (tags).

% Replicate the store across two nodes on the same host, send lookups to one of the nodes (chosen either at random or alternately), and send updates to both.

% Reimplement your system with the store nodes on other hosts (from each other and from the frontend). What do you have to be careful about when you do this?

% How could you reimplement the system to include three or four store nodes?

% Design a system to test your answer to this exercise. This should generate random store and lookup requests.

-module(serverStorage).
-export([start_and_register/1, store/2, get/1]).

% PUBLIC FUNCTIONS

% start a server and register the name
start_and_register(RegName) ->
    Pid = spawn(fun() -> storage:loop([]) end ),
    global:register_name(RegName, Pid).

% store a message
store(Email, Tag)   -> 
    store_in_servers(get_servers(), {Email, Tag}).

% return the value associated to the tag
get(Tag)    -> 
    SelectedServer = select_server(get_servers()),
    Pid = global:whereis_name(SelectedServer),
    Pid!{getValue, Tag}.

% PRIVATE FUNCTIONS

% return all the servers, if not exit with error
get_servers()  -> 
    Servers = global:registered_names(),
    check_existence(length(Servers)),
    Servers.

check_existence(0)  -> 
    io:fwrite("NO SERVER STARTED"),
    exit(prova);
check_existence(_)  -> 
    ok.

% store message into each servers
store_in_servers([], _)                 -> 
    stored;
store_in_servers([H|T], {Email, Tag})   ->
    Pid = global:whereis_name(H),
    Pid!{Email, Tag},
    store_in_servers(T, {Email, Tag}).


%  select a random server
select_server(Servers) ->
    Num = length(Servers),
    RandNum = rand:uniform(Num),
    lists:nth(RandNum, Servers).

