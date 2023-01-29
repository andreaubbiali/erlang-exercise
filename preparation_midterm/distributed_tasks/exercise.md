One of the basics of distributed computation consists of splitting the task to do in several subtasks that
can be distributed among several computational units and then the partial results will be composed
together to form the expected result. This has several advantages; the most evident are:
1. The whole process can be sped up and
2. The subtasks are easier than the original task
Neglecting the first point, mathematics can help a lot on the second point. If the original task can be
expressed as a function ψ this can decomposed in several functions φ¹, ..., φⁿ such that holds
ψ ≡ φ¹ ○ ... ○ φⁿ
This means that each subtask is implemented by an easier function and the final result depends on the
mathematical composition of such functions in the right order.
Given this, the whole approach is realized by an actors ring where the number of actors in the ring
depends on the number of functions the original function is decomposed into . Each actor runs the
function corresponding to its position in the sequence—i.e.,the actor position in the ring corresponds to
the function position in the original function decomposition. The first actor applies its function to an
external input; all the other actors will apply their function to the result of the computation of the actor
that precedes them and the last actor will print out the final result.
Basically, all the actors have the same behavior but the last one. All data are exchanged through
message passing. You interact with the first actor in the ring through three functions:
send_message/1, send_message/2 and stop/0. The stop function has to nicely shut down the
actors ring; the send_message/1 function passes the initial value to the first actor and initiates the
whole computations that ends when the message reaches the last actor in the ring; whereas the
send_message/2 function does the same as the send_message/1 but the second argument
represents the number of times the message should run through the whole ring—i.e., the number of
times the whole algorithm should be applied. The actors ring is started by the start/2 functions
whose arguments are the number of actors in the ring and a list of functions (the φ in the above
formula).
This exercise consists in implementing the module ring that implements the described situation, To
simplify the exercise the only admissible functions are unary on integers—i.e., from int to int.
The following is an example of the expected behavior:

```
1> L1 = [fun(X)-> X*N end||N<-lists:seq(1,7)].
[#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>]
2> ring:start(7,L1).
3> ring:send_message(1). % this is 7!
5040
4> ring:send_message(2). % this is 2×7!
10080
5> ring:send_message(1,10). % this is 7!^10
10575608481180064985917685760000000000
6> ring:stop().
7> L2 = [fun(X)-> X+1 end||N<-lists:seq(1,1000)].
[#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>,#Fun<erl_eval.6.80484245>,
#Fun<erl_eval.6.80484245>|...]
8> ring:start(1000,L2).
9> ring:send_message(969). % this is 1000+969
1969
10> ring:send_message(0,1000). % this is 1000^2
1000000
10> ring:send_message(1000,1000). % this is 1000+1000^2
1001000

```