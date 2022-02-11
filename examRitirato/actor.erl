-module(actor).
-export([loop/3]).

loop(MyNum, MyFunct, NextPid) ->

    receive

        {killActor} when NextPid == 0    -> io:fwrite("# ~p Sono stato killato~n", [MyNum]),
                                            ringProcess!{killRing};
        {killActor}                      -> io:fwrite("# ~p Sono stato killato~n", [MyNum]),
                                            NextPid!{killActor};

        {loop, NumLoop, Num} when NextPid == 0    -> % io:fwrite("io ~p numero ~p ho ricevuto ~p funct ~p ~n", [self(), MyNum, Num, MyFunct(Num)]),
                                                    ringProcess!{loop, NumLoop, MyFunct(Num)},
                                                    loop(MyNum, MyFunct, NextPid);
        {loop, NumLoop, Num}                      ->  % io:fwrite("io ~p numero ~p ho ricevuto ~p funct ~p~n", [self(), MyNum, Num, MyFunct(Num)]),
                                                    NextPid!{loop, NumLoop, MyFunct(Num)},
                                                    loop(MyNum, MyFunct, NextPid);

        {Num} when NextPid == 0    -> % io:fwrite("io ~p numero ~p ho ricevuto ~p funct ~p ~n", [self(), MyNum, Num, MyFunct(Num)]),
                                        ringProcess!{MyFunct(Num)},
                                        loop(MyNum, MyFunct, NextPid);
        {Num}                      ->  % io:fwrite("io ~p numero ~p ho ricevuto ~p funct ~p~n", [self(), MyNum, Num, MyFunct(Num)]),
                                        NextPid!{MyFunct(Num)},
                                        loop(MyNum, MyFunct, NextPid)

    end.