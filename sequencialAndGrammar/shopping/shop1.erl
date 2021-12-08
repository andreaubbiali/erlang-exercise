%  in terminale:
% shop1:total([{milk,3},{pears,6}]).  == 75

-module(shop1).
-export([total/1]).

total([{What, Number}|T]) -> shop:cost(What) * Number + total(T);
total([]) -> 0.