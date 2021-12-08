% factors: int → int list that given a number calculates all its prime factors;
% 315 --> 315/3=105     105/3 =35   35/5=7  7/7=1

-module(factor).
-export([prime_factors/2]).


prime_factors(1, [])          -> [1];
prime_factors(1.0, Lst)         -> Lst;
prime_factors(Num, Lst)         -> Fac = 2,
                                calc_factor(Num, Fac, math:fmod(Num, Fac), is_prime(Fac), Lst).

% When a N is factor? when Number/N has rest = 0
calc_factor(Num, Fac, 0.0, true, Lst)         -> prime_factors((Num/Fac), (Lst++[Fac]));
calc_factor(Num, Fac, _, _, Lst)              -> calc_factor(Num, Fac+1, math:fmod(Num, Fac+1), is_prime(Fac+1), Lst).

% When a number is prime? when is divisible by itself and 1 and no other
is_prime(1)     -> true;
is_prime(2)     -> true;
is_prime(Num)   -> check_is_prime(math:ceil(Num/2), Num, math:fmod(Num, math:ceil(Num/2))).
    

check_is_prime(1.0, _, _)           -> true;
check_is_prime(_, _, 0.0)           -> false;
check_is_prime(N, Num, _)           -> check_is_prime(N-1, Num, math:fmod(Num, N-1)).

