-module(controller).
-export[start/1].

start(Num) -> 
    register(controller, self()),
    Lst = calc_primes(Num, is_prime(Num), []),
    First = start_sieves(Lst),
    loop(round(math:pow(lists:last(Lst), 2)), First).

calc_primes(1, _, Lst) -> Lst;
calc_primes(Num, true, Lst) -> calc_primes(Num-1, is_prime(Num-1), [Num]++Lst);
calc_primes(Num, false, Lst) -> calc_primes(Num-1, is_prime(Num-1), Lst).

start_sieves([H|T]) ->
    spawn(sieve, loop, [H, whereis(controller), start_sieves(T, self())]).

start_sieves([H|[]], First) -> spawn(sieve, loop, [H, First, First]);
start_sieves([H|T], First) -> spawn(sieve, loop, [H, First, start_sieves(T, self())]).


is_prime(Num) -> 
    DivNum = round(Num/2),
    is_prime(Num, DivNum, round(math:fmod(Num, DivNum))).


is_prime(Num, _, _) when (Num == 2) or (Num == 3) -> true;
is_prime(_, 1, false) -> true;
is_prime(_, _, true) -> false;
is_prime(Num, Count, _) -> is_prime(Num, Count-1, round(math:fmod(Num, Count)) == 0).

loop(Limit, First) ->
    receive

        quit    -> unregister(controller),
                    First!quit,
                    exit(normal);

        {new, N, Client} when N >= Limit  -> Client!tooBigValue;

        {new, N, Client} -> io:fwrite("invio a firs ~p   ~p~n", [First, N]),
                            First!{new, N, Client};

        {resp, Res, Client} -> Client!Res 

    end,
    loop(Limit, First).