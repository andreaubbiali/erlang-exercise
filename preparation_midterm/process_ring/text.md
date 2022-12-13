Write a program that will create N processes connected in a ring. Once started, these processes will send M number of messages around the ring and then terminate gracefully when they receive a quit message. You can start the ring with the call ring:start(M, N, Message).


There are two basic strategies to tackling this exercise. The first one is to have a central process that sets up the ring and initiates sending the message. The second strategy consists of the new process spawning the next process in the ring. With this strategy, you have to find a method to connect the first process to the second process.



Try to solve the exercise in both manners. Note, when writing your program, make sure your code has many io:format statements in every loop iteration; this will give you a complete overview of what is happening (or not happening) and should help you solve the exercise.



0 register as first
0 spawna tutti e quindi si crea la lista [pid4, pid3, pid2, pid1]
io invio a pid4 inviando la lista [pid3, pid2, pid1]
quindi questo scrive a pid3 ...
l'ultimo riceverà lista vuota e scriverà a first


0 register as first

(0, [pid4]) -> (4, [pid3] ) -> (3, [pid2]) -> (2, [pid1]) -> (1, [first])