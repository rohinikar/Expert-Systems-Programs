(defrule rule-1
 (initial-fact)
=>
 (printout t "Enter the value of n:" crlf)
 (bind ?input1 (read))
 (printout t "Enter the value of m:" crlf)
 (bind ?input2 (read))
 (assert (user1 ?input1))
 (assert (user2 ?input2))
 (assert (data 2))
 (assert (data zero 1))
 (bind ?result1 (* 2 ?input2))
 (assert (data one ?result1))
 (bind ?result2 (* 2 ?input2))
 (assert (result2 ?result2))
 (assert (result 0)))

(defrule rule-2
 (user1 ?value1)
 (user2 ?value2)
 ?value3 <- (data ?input&:(<= ?input ?value1))
 ?value4 <- (data zero ?zero-value)
 ?value5 <- (data one ?one-value)
 ?value6 <- (result2 ?result-sum)
 ?value7 <- (result ?result-sum1)
=>
 (retract ?value3 ?value4 ?value5 ?value7)
 (bind ?result1 (* ?result-sum ?one-value))
 (bind ?input (- ?input 1))
 (bind ?result3 (* 2 ?input))
 (bind ?result4 (* ?result3 ?zero-value))
 (bind ?result5 (- ?result1 ?result4))
 (assert (result ?result5))
 (assert (data zero ?one-value))
 (assert (data one ?result5))
 (bind ?input (+ ?input 2))
 (assert (data ?input)))

(defrule rule-3
 (user1 ?value1&~0&~1)
 (data ?input&:(> ?input ?value1))
 (result ?value)
=>
 (printout t "The Result is: " ?value crlf))

(defrule rule-4
 (user1 0)
 =>
 (printout t "The Result is: " 1 crlf))

(defrule rule-5
 (user1 1)
 (result2 ?value)
 =>
 (printout t "The Result is: " ?value crlf))

