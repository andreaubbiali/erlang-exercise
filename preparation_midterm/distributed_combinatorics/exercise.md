With the expression permutation of m possible values took n by n with repetitions we refer to
a tuple of n elements extracted from the m available (considering that the extracted value is not
removed from the extractable set of values). Particularly interesting is the problem of generating all the
possible permutations where the generated tuple set contains all and only the possible permutations.
With a sequential language it is a pretty easy exercises even if it can get slow on the increasing of n
and m.
This exercise consists in implementing a distributed version of the permutations generator whose
master/slave architecture is composed of one master and n slaves. We have a slave (module
generator) for each element of the tuple and if you consider the permutation set as a table each
slave is in charge of generating a column of the table. All slaves are identical. The master (module
combinator) will spawn the slaves, collects the data and coalesce the collected data in the
permutations tuple. The only function the master exports is start that receives the n and m
information and then starts the whole computation.
Note that
the values are the numbers from 1 to m,
the total number of permutations is mⁿ and
the output should be lexicographically ordered
The following is an example of the expected behavior:


3> combinator:start(3,3).
true
1, 1, 1
1, 1, 2
1, 1, 3
1, 2, 1
1, 2, 2
1, 2, 3
1, 3, 1
1, 3, 2
1, 3, 3
2, 1, 1
2, 1, 2
2, 1, 3
2, 2, 1
2, 2, 2
2, 2, 3
2, 3, 1
2, 3, 2
2, 3, 3
3, 1, 1
3, 1, 2
3, 1, 3
3, 2, 1
3, 2, 2
3, 2, 3
3, 3, 1
3, 3, 2
3, 3, 3
4> combinator:start(3,2).
1, 1, 1
1, 1, 2
1, 2, 1
1, 2, 2
2, 1, 1
2, 1, 2
2, 2, 1
2, 2, 2
5> combinator:start(2,3).
1, 1
1, 2
1, 3
2, 1
2, 2
2, 3
3, 1
3, 2
3, 3
6> combinator:start(2,2)
1, 1
1, 2
2, 1
2, 2