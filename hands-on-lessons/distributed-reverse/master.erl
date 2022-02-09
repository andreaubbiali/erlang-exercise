-module(master).
-export().

long_reverse_string()   -> 
    Str = "Supercalifragilistichespiralidoso",
    long_reversed_string(Str).

long_reversed_string(Str)   ->
    split(Str, length(Str), 10).

split(_, Len, NumToSplit) when Len < NumToSplit -> 
    spawn();
split(Str, Len, NumToSplit)           ->
    N = math:fmod(Len, NumToSplit),
    create_processes(NumToSplit, Str, N).

create_processes(0, _, _)   ->
    created;
create_processes(1, _, _)   ->

create_processes(NumToSplit, Str, N)   ->
    {Pid,_} = spawn_monitor(func() -> slave:calc_reverse(string:left(Str, N)) end),
    create_processes(NumToSplit-1, string:chr(Str, N))
