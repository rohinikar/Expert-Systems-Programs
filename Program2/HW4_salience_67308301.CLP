(deffacts sets
      "list of common elements"
	  (set x 1 2 3) 
      (set y 4 2 1) 
      (find-intersection x y) 
      (set intersection))


 
 (defrule intersection 
 (find-intersection ?set-1 ?set-2) 
 ?s1 <- (element ?set-1 ?value) 
 ?s2 <- (element ?set-2 ?value) 
 => 
 (retract ?s1 ?s2) 
 (assert (element intersection ?value)) ) 
 
(defrule disassemble 
 (declare (salience 1)) 
 ?set <- (set ?name&~intersection  ?value $?elements) 
 => 
 (retract ?set) 
 (assert (set ?name $?elements)) 
 (assert (element ?name ?value)) ) 
 
(defrule reassemble 
 (declare (salience 1)) 
 ?s1 <- (element intersection ?value) 
 ?s2 <- (set intersection $?elements) 
 => 
 (retract ?s1 ?s2) 
 (assert (set intersection ?value $?elements)) ) 
