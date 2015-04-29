(defrule rule-1
 (initial-fact)
=>
 (printout t "Enter the value of n:" crlf)
 (bind ?input (read))
 (assert (data ?input))
 (assert (result 1)))

(defrule rule-2
 ?value <- (data ?input&~0)
 ?value1 <- (result ?result-sum)
=>
 (retract ?value ?value1)
 (assert (result = (* ?input ?result-sum)))
 (bind ?input (- ?input 1))
 (assert (data ?input)))

(defrule rule-3
 (data 0)
 (result ?value)
=>
 (printout t "The factorial is: " ?value crlf))