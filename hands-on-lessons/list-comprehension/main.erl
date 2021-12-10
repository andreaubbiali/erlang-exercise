% Write the following functions by using list comprehensions:

% - squared_int that removes all non-integers from a polymorphic list and returns the resulting list of integers squared, e.g., squared_int([1, hello, 100, boo, “boo”, 9])
%       should return [1, 10000, 81].
% - intersect that given two lists, returns a new list that is the intersection of the two lists (e.g., intersect([1,2,3,4,5], [4,5,6,7,8]) should return [4,5]).
% - symmetric_difference that given two lists, returns a new list that is the symmetric difference of the two lists. For example symmetric_difference([1,2,3,4,5], [4,5,6,7,8])
%       should return [1,2,3,6,7,8].
-module(main).
-export([squared_int/0, intersect/0, symmetric_difference/0]).

squared_int()  ->
    Lst = [1, hello, 100, boo, "boo", 9],
    EndLst = lists:map(
        fun(X)-> X*X end,
        lists:filter(fun(X) -> is_integer(X) end, Lst)
    ),
    io:fwrite("~p ~n", [EndLst]).


intersect() ->
    Lst1 = [1,2,3,4,5],
    Lst2 = [4,5,6,7,8],
    EndLst = lists:filter(
        fun(X)-> lists:member(X, Lst1) end,
        Lst2
    ),
    io:fwrite("~p ~n", [EndLst]).

symmetric_difference()  ->
    Lst1 = [1,2,3,4,5],
    Lst2 = [4,5,6,7,8],
    EndLst = lists:filter(
        fun(X)-> lists:member(X, Lst1) == false end,
        Lst2
    ) ++ lists:filter(
        fun(X)-> lists:member(X, Lst2) == false end,
        Lst1
    ),
    io:fwrite("~p ~n", [EndLst]).