-module(palindrome).
-export([check_palindrome/1]).
-import(string,[to_lower/1]).

% cut out punteggiatura, cut out spaces
prepare_string(Str) -> string:replace(string:join(string:split(to_lower(Str), " ", all), ""), "?.,", "").

last_c(Str) -> string:right(Str, 1).

first_c(Str) -> string:left(Str, 1).

% check if the first letter is the same as the last one
check_equal(Str) -> string:equal(first_c(Str), last_c(Str)).

% cut out from the Str the first and the last letter
cut_string(Str) -> aa(string:length(Str), Str).

aa(1, _)        -> "";
aa(_, Str)      -> string:sub_string(Str, 2, (string:length(Str)-1)).

% check if the Str is a palindrome or not
check("", true)      -> true;
check("", false)     -> false;
check(Str, true)     -> check(cut_string(Str),check_equal(Str));
check(_, false)      -> false.

check_palindrome(Str) -> check(prepare_string(Str), true).