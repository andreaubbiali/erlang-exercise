TempConvert = fun({c,C}) -> {f, 32 + C*9/5};
                ({f,F}) -> {c, (F-32)*5/9} end.

% TempConvert({c,100}). --->{f,212.0}
% TempConvert({f,212}). --->{c,100.0}

%funzioni che tornano altre funzioni
Fruit = [apple,pear,orange].
% quello che c'è all'interno delle parentesi è ciò che ritorna (fun...end)
MakeTest = fun(L) -> (fun(X) -> lists:member(X, L) end) end.
IsFruit = MakeTest(Fruit).

% IsFruit(pear).  -> true
% IsFruit(apple). -> true
% IsFruit(dog).   -> false

% In questo modo abbiamo la possibilità di crearci noi i for loops/ while ecc.
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1, Max, F)].
    %lib_misc sarebbe il nome del modulo
lib_misc:for(1,10,fun(I) -> I end). %-->[1,2,3,4,5,6,7,8,9,10]
lib_misc:for(1,10,fun(I) -> I*I end). %-->[1,4,9,16,25,36,49,64,81,100]