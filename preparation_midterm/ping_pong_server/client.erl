-module(client).
-export[start_client/0].

start_client() -> 
    receive
    
    Msg         -> io:fwrite("message received by CLIENT~n")

    end.
    