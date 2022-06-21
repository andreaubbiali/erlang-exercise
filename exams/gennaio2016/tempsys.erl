-module(tempsys).
-export([startsys/0]).

%['C','De', 'F', 'K', 'N', 'R', 'Re', 'Ro']

startsys() -> startToCelsius(), startToScale().

startToCelsius() ->
    register('C', spawn(fun()-> loop(fun(X) -> X end) end)),
    register('De', spawn(fun()-> loop(fun(X) -> (100 - (2/3 * X)) end) end)),
    register('F', spawn(fun()-> loop(fun(X) -> ((X - 32) * 5/9) end) end)),
    register('K', spawn(fun()-> loop(fun(X) -> (X - 273.15)end) end)),
    register('N', spawn(fun()-> loop(fun(X) -> (X * 100/33) end) end)),
    register('R', spawn(fun()-> loop(fun(X) -> ((X * 5/9) - 273.15) end) end)),
    register('Re', spawn(fun()-> loop(fun(X) -> (X * 5/4) end) end)),
    register('Ro', spawn(fun()-> loop(fun(X) -> ((X - 7.5) * 40/21) end) end)).


loop(F) ->
    receive
        {return, RequesterPid, Res}         -> RequesterPid!Res;

        {ToScale, Num, RequesterPid}       ->  findToScalePid(ToScale)! {convertToScale, RequesterPid, F(Num), self()},
                                                loop(F)

    end.

findToScalePid('C') -> whereis('toC');
findToScalePid('De') -> whereis('toDe');
findToScalePid('F') -> whereis('toF');
findToScalePid('K') -> whereis('toK');
findToScalePid('N') -> whereis('toN');
findToScalePid('R') -> whereis('toR');
findToScalePid('Re') -> whereis('toRe');
findToScalePid('Ro') -> whereis('toRo').

startToScale() ->
    register('toC', spawn(fun()-> loopToScale(fun(X) -> X end) end)),
    register('toDe', spawn(fun()-> loopToScale(fun(X) -> ((100 - X) * 3/2) end) end)),
    register('toF', spawn(fun()-> loopToScale(fun(X) -> (X * 9/5 + 32) end) end)),
    register('toK', spawn(fun()-> loopToScale(fun(X) -> (X + 273.15)end) end)),
    register('toN', spawn(fun()-> loopToScale(fun(X) -> (X * 33/100) end) end)),
    register('toR', spawn(fun()-> loopToScale(fun(X) -> ((X + 273.15) * 9/5) end) end)),
    register('toRe', spawn(fun()-> loopToScale(fun(X) -> (X * 4/5) end) end)),
    register('toRo', spawn(fun()-> loopToScale(fun(X) -> (X * 21/40 + 7.5) end) end)).

loopToScale(F) ->
    receive
        {convertToScale, RequesterPid, Num, ReturnPid} ->  ReturnPid!{return, RequesterPid, F(Num)}
    end.


