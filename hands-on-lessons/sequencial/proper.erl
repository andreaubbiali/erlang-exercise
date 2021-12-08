% is_proper: int → boolean that given a number calculates if it is a perfect number or not, where a perfect number is a positive 
% integer equal to the sum of its proper positive divisors (excluding itself), e.g., 6 is a perfect number since 1, 2 and 3 
% are the proper divisors of 6 and 6 is equal to 1+2+3;

-module(proper).
-export([check_proper/1]).

check_proper(Num) -> calc(Num, 0, 1).

calc(Num, Sum, _) when Num == Sum       -> true;
calc(Num, Sum, _) when Sum > Num        -> false;
calc(Num, Sum, Count)                   -> calc(Num, Sum+Count, Count+1).