% Define the following functions in Erlang:

% is_palindrome: string → bool that checks if the string given as input is palindrome, a string is palindrome
%   when the represented sentence can be read the same way in either directions in spite of spaces, punctual and letter cases, e.g.,
%   detartrated, "Do geese see God?", "Rise to vote, sir.", ...;
% is_an_anagram : string → string list → boolean that given a dictionary of strings, checks if the input string is an anagram of one
%   or more of the strings in the dictionary;
% factors: int → int list that given a number calculates all its prime factors;
% is_proper: int → boolean that given a number calculates if it is a perfect number or not, where a perfect number is a positive integer equal to the sum of its proper positive divisors (excluding itself), e.g., 6 is a perfect number since 1, 2 and 3 are the proper divisors of 6 and 6 is equal to 1+2+3;


-module(sequencial).
-export([is_palindrome/1, is_an_anagram/1, factors/1,is_proper/1]).
-import(palindrome,[check_palindrome/1]).
-import(anagram,[check_anagram/3]).
-import(factor, [prime_factors/2]).
-import(proper, [check_proper/1]).

is_palindrome(Str) -> io:fwrite("~s ~n", [check_palindrome(Str)]).

is_an_anagram(Str) ->
    Lst = ["parvo", "vapor", "ciao", "ok", "va"],
    io:fwrite("~s ~n", [check_anagram(Str, Lst, false)]).

factors(Num) -> io:fwrite("~p ~n", [prime_factors(Num, [])]).

is_proper(Num)  -> io:fwrite("~s ~n", [check_proper(Num)]).

% prova è un anagramma. anche "ia" lo è grazie a c'ia'o