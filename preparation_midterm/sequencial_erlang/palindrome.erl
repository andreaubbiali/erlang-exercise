-module(palindrome).
-export[check_palindrome/2].

check_palindrome([], _) -> true;
check_palindrome([W], _) when length(W) == 1 -> true;
check_palindrome([FstW|[]], [FstRevW|[]]) when FstW == FstRevW -> true;
check_palindrome([FstW|Tw], [FstRevW|TRevW]) when FstW == FstRevW -> check_palindrome(Tw, TRevW);
check_palindrome(_, _) -> false.


%detartrated, "Do geese see God?", "Rise to vote, sir."