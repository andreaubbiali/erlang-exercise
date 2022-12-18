-module(anagram).
-export[check_anagram/3].

check_anagram(_, _, false) -> false;
check_anagram([H|[]], D, true) -> exist_char(string:find(D, string:chars(H, 1)));
check_anagram([H|T], D, true) -> check_anagram(T, remove_char(D, string:chars(H, 1)), exist_char(string:find(D, string:chars(H, 1)))).

exist_char(nomatch) -> false;
exist_char(_) -> true.

remove_char(W, C) -> string:join(string:split(D, string:chars(H, 1)), "")

% sequencial:is_an_anagram("levirato", ["ciao", "prova", "rilevato"]).
% sequencial:is_an_anagram("levirato", ["rilevato", "prova", "ciao"]).
% sequencial:is_an_anagram("levirato", ["prova", "rilevato", "ciao"]).
% sequencial:is_an_anagram("levirato", ["prova", "oppla", "ciao"]).