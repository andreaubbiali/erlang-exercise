-module(oddsevens).
-export([odds_and_evens2/1, odds_and_evens_without_case/1, isOdds/1]).


odds_and_evens2(L) -> odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;

odds_and_evens_acc([], Odds, Evens) ->{Odds, Evens}.

odds_and_evens_without_case(List) -> {[X || X <- List, isOdds(X rem 2)], [X || X <- List, isOdds(X rem 2)]}.
% [X || X <- T, X < Pivot]

% ritorna true se 
% isOdds(Num) -> 0 = Num rem 2.
isOdds(0) -> true;
isOdds(1) -> false.

% esercizio non finito