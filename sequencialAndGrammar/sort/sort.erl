-module(sort).
-export([qsort/1]).

qsort([]) -> [];
qsort([Pivot|T]) -> qsort([X || X <- T, X < Pivot]) 
                    ++ [Pivot] ++
                    qsort([X || X <- T, X > Pivot]). 

% L = [23,6,2,9,27,400,78,45,61,82,14].
% sort:qsort(L).
