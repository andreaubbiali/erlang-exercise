F1 = #{ a => 1, b => 2 }.

Facts = #{ {wife,fred} => "Sue", {age, fred} => 45, {daughter,fred} => "Mary" }

F3 = F1#{ c => xx }.
% #{ a => xx, b => 2 , c => xx}


% pattern matching
Henry8 = #{ class => king, born => 1491, died => 1547 }.
#{ born => B } = Henry8.
B. %-->1491