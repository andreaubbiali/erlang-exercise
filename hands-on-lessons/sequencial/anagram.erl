% is_an_anagram : string → string list → boolean that given a dictionary of strings, checks if the input string is an anagram of one
%   or more of the strings in the dictionary;

-module(anagram).
-export([check_anagram/3]).
-import(string,[length/1]).
-compile({no_auto_import,[length/1]}).%non so cosa sia ma senza mi dice di aggiungerlo

% return the remaining of the string index where there is the letter L in the word. if 0 not exist
% 
exist_letter(L, Word)       -> string:find(Word, L).


% return the Word without the letter in the position Position
% 
cut_out_letter(_, _, nomatch)           -> {"", false};
cut_out_letter(Char, Word, _)           -> [H|T] = string:split(Word, Char),
                                            {H++T, true}.


% return true if Str is an anagram of Word false otherwise
% 
check(_, _, _, _, false)        -> false;

check(0, _, _, _, _)               -> true;

check(_, _, 0, _, _)               -> false;

check(1, Str, _, Word, _)          -> 
    Exist = exist_letter(string:left(Str, 1), Word),
    {W, Continue} = cut_out_letter(string:left(Str, 1), Word, Exist),
    check(length(Str)-1, Str, length(W), W, Continue);

check(Lstr, Str, _, Word, _)          -> 
    Exist = exist_letter(string:left(Str, 1), Word),
    {W, Continue} = cut_out_letter(string:left(Str, 1), Word, Exist),
    S = string:sub_string(Str, 2, Lstr),
    check(length(S), S, length(W), W, Continue).


% check the length before to check if the Str is an anagram
%
check_length(L1, _, L2, _) when L2 < L1         -> false;
check_length(L1, Str, L2, Word)                 -> check(L1, Str, L2, Word, true).


% check if there is an anagram in the list
%
check_anagram(Str, [H|Tl], false)   -> check_anagram(Str, Tl, check_length(length(Str), Str, length(H), H));
check_anagram(_, _, true)           -> true;
check_anagram(_, [], _)             -> false.    