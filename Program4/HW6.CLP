(defrule rule-1
 (initial-fact)
=>
 (printout t "Enter the value of n:" crlf)
 (bind ?input (read))
 (assert (user ?input))
 (assert (data 2))
 (assert (data one 0))
 (assert (data two 1))
 (assert (result 0)))

(defrule rule-2
 (user ?value)
 ?value1 <- (data ?input&:(< ?input ?value))
 ?value2 <- (data one ?first_value)
 ?value3 <- (data two ?second_value)
 ?value4 <- (result ?result-sum)
=>
 (retract ?value1 ?value2 ?value3 ?value4)
 (bind ?result1 (+ ?first_value ?second_value))
 (assert (result ?result1))
 (assert (data one ?second_value))
 (assert (data two ?result1))
 (bind ?input (+ ?input 1))
 (assert (data ?input)))

(defrule rule-3
 (user ?value1&~1&~2)
 (data ?input&:(= ?input ?value1))
 (result ?value)
=>
 (printout t "The Fibonacci number is: " ?value crlf))

(defrule rule-4
 (user 1)
 =>
 (printout t "The Fibonacci number is: " 0 crlf))

(defrule rule-5
 (user 2)
 =>
 (printout t "The Fibonacci number is: " 1 crlf))

