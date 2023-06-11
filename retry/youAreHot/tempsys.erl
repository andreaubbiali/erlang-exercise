-module(tempsys).
-export[startsys/0].

startsys() -> 
    FirstRowPids = create_first_row(['C','De', 'F', 'K', 'N', 'R', 'Re', 'Ro'], []),
    create_second_row(['C','De', 'F', 'K', 'N', 'R', 'Re', 'Ro'], FirstRowPids).

create_second_row([H|[]], FirstRowPids) -> 
    register(H, spawn(fun() -> loop_scale_to_celsius(H, FirstRowPids) end));
create_second_row([H|T], FirstRowPids) -> 
    register(H, spawn(fun() -> loop_scale_to_celsius(H, FirstRowPids) end)),
    create_second_row(T, FirstRowPids).

create_first_row([H|[]], Lst) -> 
    Lst ++ [{H, spawn(fun() -> loop_celsius_to_scale(H) end)}];
create_first_row([H|T], Lst) -> 
    create_first_row(T, Lst ++ [{H, spawn(fun() -> loop_celsius_to_scale(H) end)}]).

loop_scale_to_celsius(Scale, FirstRowPids) ->
    receive

        {From, To, Value, Client} -> 
            find_pid(To, FirstRowPids) ! {From, To, fromScaleToCelsius(Scale, Value), Client, self()};
        
        {res, From, To, Value, Client} -> 
            Client ! {res, From, To, Value}

    end,
    loop_scale_to_celsius(Scale, FirstRowPids).

loop_celsius_to_scale(Scale) ->
    receive

        {From, To, Value, Client, RespTo} -> 
            RespTo ! {res, From, To, fromCelsiusToScale(Scale, Value), Client}
        
    end,
    loop_celsius_to_scale(Scale).


find_pid(Name, [{N, Pid}|_]) when Name == N -> Pid; 
find_pid(Name, [_|T]) -> find_pid(Name, T).

fromScaleToCelsius('C', Value) -> Value;
fromScaleToCelsius('De', Value) -> -(Value * (2/3)) +100;
fromScaleToCelsius('F', Value) -> (Value - 32)/ (9/5);
fromScaleToCelsius('K', Value) -> Value-273.15;
fromScaleToCelsius('N', Value) -> Value/(33/100);
fromScaleToCelsius('R', Value) -> (Value / (9/5))-273.15;
fromScaleToCelsius('Re', Value) -> Value * 5/4;
fromScaleToCelsius('Ro', Value) -> (Value -7.5) * 40/21.


fromCelsiusToScale('C', Value) -> Value;
fromCelsiusToScale('De', Value) -> (100 - Value) * (3/2);
fromCelsiusToScale('F', Value) -> Value * (9/5) + 32;
fromCelsiusToScale('K', Value) -> Value + 273.15;
fromCelsiusToScale('N', Value) -> Value * 33/100;
fromCelsiusToScale('R', Value) -> (Value + 273.15) * 9/5;
fromCelsiusToScale('Re', Value) -> Value * 4/5;
fromCelsiusToScale('Ro', Value) -> Value * 21/40 +7.5.