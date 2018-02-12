* Problem
http://www.watrophy.com/posts/24-Run-Length-Encoding.html

x = [1, 1, 1, 2, 2, 3, 4, 4]
run-length-encoding(x) => [(1, 3), (2, 2), (3, 1), (4, 2)]

Write the type of the run length encoding function.
Implement using only fold/reduce

* Solution

run-length-encoding: [a] -> [(a, Integer)]

Implementation in rle.lisp
