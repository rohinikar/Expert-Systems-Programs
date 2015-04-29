(defrule update-time-1                                                                        ;this rule updates the current time to the next
(declare (salience -1))
?cur-time <- (current-time ?time)
(package (location ~destination)(event-time ?new-time&:(neq ?time ?new-time)))
(not (package (location ~destination)(event-time ?x&:(< ?x ?new-time))))
=>
(retract ?cur-time)
(assert (current-time ?new-time)) )



(defrule update-time-2                                                                           ;this rule updates the current time to the next
?cur-time <- (current-time ?time)
(package (location ~destination)(event-time ?new-time&:(neq ?time ?new-time)))
(not (package (location ~destination)(event-time ?x&:(< ?x ?new-time))))
(truck (event-time ?new-time1&~0&:(neq ?time ?new-time1)))
(not (truck (event-time ?x1&~0&:(< ?x1 ?new-time1) )))
=>
(retract ?cur-time)
(assert (current-time (min ?new-time ?new-time1)) ))



(defrule update-time-3
?cur-time <- (current-time ?time)
(Number-of-Packages-Delivered (Packages-Delivered 20))
(truck (event-time ?new-time1&~0&:(neq ?time ?new-time1)))
(not (truck (event-time ?x1&~0&:(< ?x1 ?new-time1) )))
=>
(retract ?cur-time)
(assert (current-time ?new-time1)))




(defrule find-shortest-path
(current-time ?time)
(package (depart-city ?depart-city) (delivery-city ?delivery-city) (location arrival) (event-time ?time))
=>
(assert (cheapest_paths (start "Orlando" ) (stop ?depart-city))) 
(assert (cheapest_paths (start ?depart-city) (stop ?delivery-city)))
(assert (cheapest_paths (start ?delivery-city) (stop "Orlando"))))


(defrule initial_path
(declare (salience 5))
(cheapest_paths (start ?x))
=>
(assert (path (nodes ?x) (cost 0))))


(defrule extended_path
(path (nodes $?n ?y) (cost ?w))
(edge (from ?y) (to ?z & ~?y & :(not (member ?z $?n))) (cost ?we))
=>
(assert (path (nodes $?n ?y ?z) (cost (+ ?w ?we)))))


(defrule result
(declare (salience -10))
(cheapest_paths (start ?a) (stop ?x))
(path (nodes ?a $? ?x) (cost ?w))
(not(path (nodes ?a $? ?x) (cost ?w1&:(< ?w1 ?w))))
=>
(assert (cost-from ?a ?x ?w)))


(defrule result1
(declare (salience -10))
(cheapest_paths (start ?a) (stop ?a))
=>
(assert (cost-from ?a ?a 0)))



(defrule situation-1-arriving-order-has-required-truck-in-Orlando                                  
(current-time ?time)                                                                                 
?package <- (package (number ?package-n) 
            (depart-city ?depart-city)
            (delivery-city ?delivery-city)
            (size ?size)
            (location arrival)
            (order-arrival-time ?time))   ;finds an arriving package fact at the current time
?truck <- (truck (number ?truck-n) 
          (current-location "Orlando")
          (available-space ?space&:(>= ?space ?size)) 
          (action idle)
          (package-number NIL)
          (event-time ?a) 
          (wait-time ?b)
          (busy-time ?b-time)
          (non-del-time ?ndeltime)
          (return-time ?return-time) 
          (total-travel-time ?total-travel-time ) )                
(not (truck (number ?n&:(< ?n ?truck-n)) (current-location "Orlando") (available-space ?avail&:(>= ?avail ?size)) (action idle) (package-number NIL)))       
(cost-from "Orlando" ?depart-city ?cost)       
?t <- (Number-of-Trucks-at-Orlando (Trucks-at-Orlando ?tc))
?c <- (total-no-packages ?total-no-packages)
=>
(retract ?c)
(assert (total-no-packages (+ ?total-no-packages 1)))
(modify ?t (Trucks-at-Orlando =(- ?tc 1)))
(assert (start-truck ?truck-n ?package-n ?time))
(modify ?package (event-time =(+ ?time ?cost)) (location not-assigned))
(modify ?truck (package-number ?package-n)(action going-to-pick-up-a-package) (destination ?depart-city) 
(busy-time =(+ ?cost ?b-time))
(total-travel-time =(+ ?total-travel-time ?cost)) 
(non-del-time =(+ ?ndeltime ?cost)) 
(wait-time =(+ ?b (- ?time ?return-time))) 
(event-time =(+ ?time ?cost)))
(printout t "TRUCK   " ?truck-n  " has been DISPATCHED to pick PACKAGE  " ?package-n " at TIME =  " ?time crlf))



(defrule situation-2-arriving-package-assigned-to-truck       
(current-time ?time)
?truck <- 	(truck (number ?truck-n) 
			(current-location "Orlando") 
			(action going-to-pick-up-a-package) 
			(available-space ?truck-space)
			(package-number ?package-n) 
			(destination ?depart-city) 
			(event-time ?time) 
			(busy-time ?b-time) 
			(wait-time ?w-time) 
			(packages-carrying ?no-of-packs) 
			(del-time ?deltime) 
			(space-occupied ?space-occupied)
			(total-travel-time ?total-travel-time ) 
			(total-time-of-delivery ?total-time-of-delivery))
?package <- (package (number ?package-n) 
			(size ?package-size) 
			(depart-city ?depart-city) 
			(delivery-city ?delivery-city) 
			(location not-assigned) 
			(time-of-pick-up 0)
			(event-time ?time) )
(cost-from ?depart-city ?delivery-city ?cost)
=>
(modify ?truck (current-location ?depart-city) 
			   (action in-route-to-deliver-package) 
			   (package-number ?package-n) 
			   (total-travel-time =(+ ?total-travel-time ?cost)) 
			   (destination ?delivery-city) 
			   (total-time-of-delivery =(+ ?total-time-of-delivery ?cost))
			   (packages-carrying =(+ ?no-of-packs 1)) 
			   (del-time =(+ ?deltime ?cost)) 
			   (space-occupied =(+ ?space-occupied (/ ?package-size ?truck-space)))
			   (busy-time =(+ ?cost ?b-time))
			   (event-time =(+ ?time ?cost)) )
(modify ?package (location truck) 
				(time-of-pick-up ?time)
				(event-time =(+ ?time ?cost))) 

(printout t "PACKAGE  " ?package-n " has been ASSIGNED to TRUCK  " ?truck-n " at TIME = " ?time crlf))




(defrule situation-3-package-delivered-to-destination        
(current-time ?time)
?truck <- (truck (number ?truck-n) 
		  (current-location ?depart-city) 
		  (action in-route-to-deliver-package) 
		  (package-number ?package-n) 
		  (destination ?delivery-city) 
		  (event-time ?time) 
		  (total-travel-time ?total-travel-time )
		  (non-del-time ?ndeltime) 
		  (busy-time ?b-time) )
?package <- (package (number ?package-n) 
			(depart-city ?depart-city) 
			(delivery-city ?delivery-city) 
			(location truck) 
			(event-time ?time) 
			(order-arrival-time ?a-time)
			(size ?p_size)
			(expect-time-of-delivery ?package-time-of-delivery)
			(time-of-delivery 0)
			(delivery-delayed-by 0)
			(wait-time ?pwtime))
(cost-from ?delivery-city "Orlando" ?cost)
(cost-from ?depart-city ?delivery-city ?cost1)
(cost-from "Orlando" ?depart-city ?cost2)
?p <-(Number-of-Packages-Delivered (Packages-Delivered ?Packages-delivered))					
=>
(assert (parcel ?package-n delivered))
(modify ?p (Packages-Delivered =(+ ?Packages-delivered 1)))
(modify ?truck (current-location ?delivery-city) (action returning-to-base) (package-number NIL) (destination "Orlando")
(non-del-time =(+ ?ndeltime ?cost)) (total-travel-time =(+ ?total-travel-time ?cost))(busy-time =(+ ?cost ?b-time)) (event-time =(+ ?time ?cost)) )
(modify ?package (location destination) (time-of-delivery ?time) (event-time ?time) )
(printout t "PACKAGE " ?package-n " has been DELIVERED at DESTINATION by TRUCK " ?truck-n " at TIME = " ?time crlf) )




(defrule situation-4-Truck-back-to-Orlando
(current-time ?time)
(cost-from ?delivery-city "Orlando" ?cost)
?truck <- (truck (number ?truck-n) 
          (action returning-to-base) 
          (package-number NIL)
          (event-time ?time)
          (total-travel-time ?total-travel-time))
?t <- (Number-of-Trucks-at-Orlando (Trucks-at-Orlando ?truck-counter))
=>
(modify ?t (Trucks-at-Orlando =(+ ?truck-counter 1)))
(assert (return-truck ?truck-n ?time))
(modify ?truck (current-location "Orlando") (action idle) (event-time 0) (package-number NIL) (destination NIL) (return-time ?time))
(printout t "TRUCK    " ?truck-n " RETURNS back to base ORLANDO at TIME = " ?time crlf) )


(defrule Truck_Report_Header
(declare(salience 2))
(Number-of-Packages-Delivered (Packages-Delivered 20))
(Number-of-Trucks-at-Orlando(Trucks-at-Orlando 6))
=>
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t " +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+ " crlf)
(printout t " |                                                 INDIVIDUAL TRUCK REPORT                                                                                        | " crlf)
(printout t " +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+ " crlf)
(printout t " Truck#  |	Wait Time | Total time busy |   Time Busy (%)  |   #Package-at-end  | Occupancy | Non Delivery Travel Time	 | Busy time delivering(%)	| " crlf)						
(printout t " +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+ " crlf))






(defrule Individual-Truck-Statistics-1
;(declare(salience 20))
(current-time ?time)
	(Number-of-Packages-Delivered (Packages-Delivered 20))
	(Number-of-Trucks-at-Orlando(Trucks-at-Orlando 6))
	(not (package (location arrival|truck)))
	?t <-(truck (number ?t-no)
		(current-location "Orlando")
		(destination NIL)
		(action idle)
		(package-number NIL)
		(event-time 0)
		(wait-time ?w-time)
		(busy-time ?b-time)
		(return-time ?return-time)
		(packages-carrying ?packs&~0)
		(space-occupied ?space-occupied)
		(total-travel-time ?total-travel-time)
		(total-time-of-delivery ?total-time-of-delivery)
		(non-del-time ?ndeltime))
	(not (truck (number ?n&:(< ?n ?t-no))))	
=>
(retract ?t)
;(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
;(printout t "         Statistics for Truck #    " ?t-no        crlf)
;(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "    ")
	(format t "%-08d" ?t-no)
	(format t "%-015d" (+ ?w-time (- ?time ?return-time)))
	(format t "%-018d" ?total-travel-time)
	(format t "%-20.2f" (*(/ ?total-travel-time  ?time) 100))
	(format t "%-022d" 0)
	(format t "%-20.2f" (* (/ 1 100) 100))
	(format t "%-028d" ?ndeltime)
	(format t "%-20.2f" (*(/ ?total-time-of-delivery ?total-travel-time) 100))
	(printout t crlf))


(defrule Individual-Truck-Statistics-2
(current-time ?time)
	(Number-of-Packages-Delivered (Packages-Delivered 20))
	(Number-of-Trucks-at-Orlando(Trucks-at-Orlando 6))
	(not (package (location arrival|truck)))
	?t <-(truck (number ?t-no)
		(current-location "Orlando")
		(destination NIL)
		(action idle)
		(package-number NIL)
		(event-time 0)
		(wait-time ?w-time)
		(busy-time ?b-time)
		(packages-carrying 0)
		(space-occupied ?space-occupied)
		(total-travel-time ?total-travel-time)
		(total-time-of-delivery ?total-time-of-delivery)
		(non-del-time ?ndeltime)
		(del-time ?deltime))
	(not (truck (number ?n&:(< ?n ?t-no))))	
=>
(retract ?t)
	(printout t "    ")
	(format t "%-08d" ?t-no)
	(format t "%-015d" ?time)
	(format t "%-018d" ?total-travel-time)
	(format t "%-20.2f" (/ (* ?b-time 100) ?time))
        (format t "%-022d" 0)
	(format t "%-20.2f" 0)
	(format t "%-028d" 0)
	(format t "%-20.2f" 0)
	(printout t crlf))




(defrule Report-Header-for-Package
(Number-of-Packages-Delivered (Packages-Delivered 20))
(Number-of-Trucks-at-Orlando(Trucks-at-Orlando 6))
=>
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " crlf)
(printout t " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " crlf)
(printout t " |                                         REPORT OF INDIVIDUAL PACKAGES                                                                       | " crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ " crlf)
(printout t "   Package#  | Total-Wait-Time | 		Pick-Up-Time		 | 		Delivery-Time 		| 		 Status-at-Delivery   | Delivery Delayed By |" crlf)
(printout t " ---------------------------------------------------------------------------------------------------------------------------------------------- " crlf))	
	
(defrule Package_updates
(declare(salience 3))
(Number-of-Packages-Delivered (Packages-Delivered 20))
?p <-(package (number ?package)
		 (time-of-delivery ?time-of-delivery)
		 (status-at-delivery ON-TIME)
		 (delivery-delayed-by 0)
		 (expect-time-of-delivery ?exptime&: (< ?exptime ?time-of-delivery)))
		 
?l <-(Packages-Delivered-Late ?Packages-Delivered-Late)		 
=>
(retract ?l)
(assert (Packages-Delivered-Late =(+ ?Packages-Delivered-Late 1)))
(modify ?p (number ?package) (time-of-delivery ?time-of-delivery) (status-at-delivery LATE) (delivery-delayed-by =(- ?time-of-delivery ?exptime))) )


	
(defrule Report-for-Package
    (Number-of-Packages-Delivered (Packages-Delivered 20))
	?p <-(package (number ?package)
		 (location destination)
		 (depart-city ?start-city)
		 (delivery-city ?end-city)
		 (wait-time ?w-time)
		 (event-time ?ptime)
		 (order-arrival-time ?order-arrival-time)
		 (time-of-pick-up ?time-of-pick-up)
		 (time-of-delivery ?time-of-delivery)
		 (delivery-delayed-by ?delivery-delayed-by)
		 (status-at-delivery ?status-at-delivery)
		 (expect-time-of-delivery ?exptime))
	(not (package (number ?package1&: (< ?package1 ?package))))	 
	
	(cost-from "Orlando" ?start_city ?time1)
	(cost-from ?start-city ?end-city ?time2)
	
	?a <- (Total-Wait-Time (Package-Total-Wait-time ?counter))
	
	?d <-(total-late-time-of-delivery ?total-late-time-of-delivery)
	
	
	
=>
	(modify ?a (Package-Total-Wait-time =(+ ?counter (- ?time-of-pick-up ?order-arrival-time))))
    (retract ?p)
	(retract ?d)
	(assert (total-late-time-of-delivery (+ ?total-late-time-of-delivery ?delivery-delayed-by)))
	(printout t "    ")
	(format t "%-015d" ?package)
	(format t "%-018d		" (- ?time-of-pick-up ?order-arrival-time))
	(format t "%-020d		" ?time-of-pick-up)
	(format t "%-020d		" ?time-of-delivery)
	(format t "%-20s		" ?status-at-delivery)
	(format t "%-012d		" ?delivery-delayed-by) 
	(printout t crlf))



(defrule Average-Report-for-All-Packages
(declare(salience -1))
(initial-fact)
(current-time ?time)
	(Number-of-Packages-Delivered (Packages-Delivered 20))
	(Number-of-Trucks-at-Orlando(Trucks-at-Orlando 6))
	(Total-Wait-Time (Package-Total-Wait-time ?counter))
	(Packages-Delivered-Late ?Packages-Delivered-Late)
	(total-late-time-of-delivery ?total-late-time-of-delivery)
	(total-no-packages ?total-no-packages)
=>
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "         Average-Report-for-Packages    "        crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)

(format t " 2. # Packages which have been delivered ON-TIME 	:		%-20d "     (- ?total-no-packages ?Packages-Delivered-Late))
(printout t crlf)
(format t " 3. # Packages which have been delivered LATE 		:		%-20d	"    ?Packages-Delivered-Late)
(printout t crlf)
(format t " 1. AVERAGE WAIT TIME FOR PACKAGES 			:		%-20.2f" (/ ?counter ?total-no-packages ))
(printout t crlf)
(format t " 4. AVERAGE lateness for LATE packages		:		%-20.2f	"     (/ ?total-late-time-of-delivery ?Packages-Delivered-Late)      )
(printout t crlf)
(format t " 5. AVERAGE lateness for ALL packages 		:		%-20.2f	"      (/ ?total-late-time-of-delivery ?total-no-packages)     )
(printout t crlf)

)




