-module(sequencial).
-export[is_palindrome/1, is_an_anagram/2].
-import(string, [join/2, replace/4]).
-import(palindrome, [check_palindrome/2]).
-import(anagram, [check_anagram/3]).


is_palindrome(W) -> WW = repl(string:to_lower(W), [".", "?", " ", ","]),
                    check_palindrome(WW, lists:reverse(WW)).

is_an_anagram(_, []) -> false;
is_an_anagram(W, D) -> is_an_anagram(W, D, true).

is_an_anagram(_, _, false) -> false;
is_an_anagram(W, [H|[]], true) -> check_anagram(W, H, true);
is_an_anagram(W, [H|T], true) -> is_an_anagram(W, T, check_anagram(W, H, true)).



repl(W, [Fst|[]]) -> join(replace(W, Fst, "", all), "");
repl(W, [Fst|T]) -> repl(join(replace(W, Fst, "", all), ""), T).

