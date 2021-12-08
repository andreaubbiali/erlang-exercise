% 1> c(afile_server).
%     {ok,afile_server}
% 2> FileServer = afile_server:start(".").
%      PID OF THE FILE SERVER
%     <0.47.0>
% 3> FileServer ! {self(), list_dir}.
%      SEND A MESSAGE TO FILESERVER
%     {<0.31.0>,list_dir}
% 4> receive X -> X end.
%     {<0.47.0>,
%     {ok,["afile_server.beam","processes.erl","attrs.erl","lib_find.erl",
%     "dist_demo.erl","data1.dat","scavenge_urls.erl","test1.erl",
%     ...]}}

-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    %wait a command
    receive
        {Client, list_dir} ->
            % reply with a list of file
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            % reply with the file
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)}
    end,
    %recall loop (infinite)
    loop(Dir).

% All the received messages contained the variable Client so we can reply to it.
% The reply sent by the server contains the argument self() is the process identifier of the server so the client will be able to reply.
