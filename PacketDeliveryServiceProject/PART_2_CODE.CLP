;THIS RULE UPDATES THE CURRENT TIME
(defrule update-time-1                                                                       ;this rule updates the current time to the next
 ?cur-time <- (current-time ?time) 
		(package (order_arrival_time ?new-time&:(neq ?time ?new-time))(status "arrived")) 
   (not (package (order_arrival_time ?x&:(< ?x ?new-time))(status "arrived"))) 
   
   (not (truck (event_time ?r_time&:(< ?r_time ?time))
	     (action "going to pick a package"|"in-transit-for-delivery-of-package")))
 => 
 (retract ?cur-time) 	;retract the existing time and asserting the new one
 (assert (current-time ?new-time)) )


;THIS RULE UPDATES THE CURRENT TIME
;(defrule update-time-2                                                                           ;this rule updates the current time to the next
;?cur-time <- (current-time ?time)
;(package (location ~destination)(event-time ?new-time&:(neq ?time ?new-time)))
;(not (package (location ~destination)(event-time ?x&:(< ?x ?new-time))))
;(truck (event-time ?new-time1&~0&:(neq ?time ?new-time1)))
;(not (truck (event-time ?x1&~0&:(< ?x1 ?new-time1) )))
;=>
;(retract ?cur-time)
;(assert (current-time (min ?new-time ?new-time1)) ))


;THIS RULE UPDATES THE CURRENT TIME WHEN ALL PACKAGES HAVE BEEN DELIVERED TO DESTINATIONS
(defrule update-time-3
?cur-time <- (current-time ?time)
(#packages_delivered ?counter&:(eq ?counter ?*packages*))
(truck (truck_number ?truck_number) (action "idle")(event_time ?new-time1&~0&:(neq ?time ?new-time1)))
(not (truck (action "idle")(event_time ?x1&~0&:(> ?x1 ?new-time1) )))
=>
 (printout t "Execution End" crlf)
 (retract ?cur-time)
(assert (current-time ?new-time1)))

 
;THIS RULE UPDATES THE CURRENT TIME 
;(defrule update-time-4
;?cur-time <- (current-time ?time)
;?route <- (route (nodes ?a ?b $? ?x) (cost ?w))
;(edge (from ?a) (to ?b) (cost ?w1))
;(not (route (nodes ?a1 ?b1 $?) (cost ?w2))
     ;(edge (from ?a1) (to ?b1) (cost ?w3&:(< ?w3 ?w1)))
;?truck <- (truck (number ?truck-n)
          ;(current-location ?a)
          ;(destination ?x))
;=>
;(modify ?truck (current-location ?b))
;(retract ?route)
;(assert (route (nodes ?b $?) (cost ?w)
;(retract ?cur-time)
;(assert (current-time =(+ ?time ?w1))))
 
 
 



;THIS RULE CALCULATES THE SHORTEST PATH BETWEEN TWO CITIES WHEN THERE IS NO HOP BETWEEN THEM
(defrule find-shortest-path 
	(declare (salience 2))
	(cheapest_paths (start_city ?start_city)(neighboring_cities $?))
=>
	(assert (route (start_node ?start_city)(end_node ?start_city)(time 0))))
	

;THIS RULE GIVES THE FINAL SHORTEST DISTANCE BETWEEN SOURCE AND DESTINATION CITIES ALONG WITH THE SHORTEST ROUTE
(defrule find-shortest-path-2
	(declare (salience 1))
	(cheapest_paths (start_city ?end_city)(neighboring_cities $?))
	(cheapest_paths (start_city ?start_city)(neighboring_cities $?))
	(route (start_node ?start_city)(end_node ?start_node&:(neq ?start_node ?end_city))(time ?t1)(intermediate_cities $?v))
	(route (start_node ?start_node)(end_node ?end_node&:(eq ?end_node ?end_city))(time ?t2))
	(not (route (start_node ?start_city)(end_node ?end_city)))
=>
	(assert (route (start_node ?start_city)(end_node ?end_node)(time (+ ?t2 ?t1))(intermediate_cities $?v ?start_node))))
	

;THIS RULE CALCULATES THE SHORTEST PATH BETWEEN TWO CITIES WHEN THERE ARE HOPS BETWEEN THEM
(defrule find-shortest-path-1 
	(declare (salience 2))
	(cheapest_paths (start_city ?start_city)(neighboring_cities $? ?end_city ?time $?))
	(cheapest_paths (start_city ?end_city)(neighboring_cities $?))
	(not (route (start_node ?start_city)(end_node ?end_city)))
=>
	(assert (route (start_node ?start_city)(end_node ?end_city)(time ?time))))
	

;THIS RULE GIVES THE FINAL SHORTEST DISTANCE BETWEEN SOURCE AND DESTINATION CITIES ALONG WITH THE SHORTEST ROUTE
(defrule find-shortest-path-3
	(declare (salience 1))
	(cheapest_paths (start_city ?end_city)(neighboring_cities $?))
	(cheapest_paths (start_city ?start_city)(neighboring_cities $?))
	(route (start_node ?start_city)(end_node ?start_node&:(neq ?start_node ?end_city))(time ?t1)(intermediate_cities $?v))
	(route (start_node ?start_node)(end_node ?end_node&:(eq ?end_node ?end_city))(time ?t2))
	(route (start_node ?start_city)(end_node ?end_city))
	
	?new <- (route (start_node ?start_city)
						   (end_node ?end_node&:(eq ?end_node ?end_city))
							(time ?t3&:(> ?t3 (+ ?t2 ?t1)))
							(intermediate_cities $?v1))
=>
	(modify ?new (start_node ?start_city)(end_node ?end_node)(time (+ ?t2 ?t1))(intermediate_cities $?v ?start_node)))




 
 ;THIS RULE ASSIGNS AN ARRIVING PACKAGE TO AN EMPTY TRUCK WHICH IS SITTING AT THE DEPART CITY OF THE PACKAGE AT THAT TIME( WITH AT LEAST ONE HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-1-empty-truck-at-location-and-time-of-arriving-package
(declare (salience -2))
(current-time ?time) 
?package <- (package (package_number ?package-n) 
            (depart_city ?depart-city)
            (delivery_city ?delivery-city)
            (package_size ?size)
            (status "arrived")
            (order_arrival_time ?time)
            ;(event-time ?time)
            (pick_up_time 0))
?truck <- (truck (truck_number ?truck-n) 
          (current_city ?depart-city)
          (available-space ?space&:(>= ?space ?size)) 
          (action idle)
          ;(number-of-packages-carrying 0)
          (current_package 0)
          (packages-being-carried 0)
          (destination_city 0)
          (event_time ?a)
          (wait_time ?b)
          (busy_time ?b-time))
          ;(return-time ?return-time) 
          ;(total-travel-time ?total-travel-time ) 
          ;(total-delivery-time ?total-delivery-time))
(not (truck (truck_number ?n&:(< ?n ?truck-n)) (current_city ?depart-city) (available-space ?avail&:(>= ?avail ?size)) (packages-being-carried nil) (action idle) (current_package 0) ))  
?route <-(route (start_node ?depart-city) (end_node ?end_city)(time ?between_path) (intermediate_cities ?through_city $?))
?c <- (total-no-packages ?total-no-packages)
=>
(retract ?route)
(retract ?c)
(assert (total-no-packages (+ ?total-no-packages 1)))
;(assert (have-to-deliver ?truck-n ?package-n ?delivery-city ?cost))
(modify ?package  (status "in transit") (pick_up_time ?time))
(modify ?truck (action going-to-deliver-packages) (destination_city ?delivery-city) (current_package ?package-n) 
(packages-being-carried ?package-n)
;(current_city ?next-city)
(available-space =(- ?space ?size)))
;(busy_time =(+ ?between_path ?b-time))
;(wait-time =(+ ?b (- ?time ?return-time))) 
;(event_time =(+ ?time ?between_path)))
;(printout t "TRUCK   " ?truck-n  " next city " ?next-city "    at time " (+ ?w1 ?time) crlf)
(printout t "TRUCK   " ?truck-n  " Picked PACKAGE " ?package-n " for DELIVERY at TIME =  " ?time crlf))



;THIS RULE ASSIGNS AN ARRIVING PACKAGE TO AN EMPTY TRUCK WHICH IS SITTING AT THE DEPART CITY OF THE PACKAGE AT THAT TIME( WITH NO HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-1a-empty-truck-at-location-and-time-of-arriving-package
(declare (salience -2))
(current-time ?time) 
?package <- (package (package_number ?package-n) 
            (depart_city ?depart-city)
            (delivery_city ?delivery-city)
            (package_size ?size)
            (status "arrived")
            (order_arrival_time ?time)
            ;(event-time ?time)
            (pick_up_time 0))
?truck <- (truck (truck_number ?truck-n) 
          (current_city ?depart-city)
          (available-space ?space&:(>= ?space ?size)) 
          (action idle)
          ;(number-of-packages-carrying 0)
          (current_package 0)
          (packages-being-carried 0)
          (destination_city 0)
          (event_time ?a)
          (wait_time ?b)
          (busy_time ?b-time))
          ;(return-time ?return-time) 
          ;(total-travel-time ?total-travel-time ) 
          ;(total-delivery-time ?total-delivery-time))
(not (truck (truck_number ?n&:(< ?n ?truck-n)) (current_city ?depart-city) (available-space ?avail&:(>= ?avail ?size)) (packages-being-carried nil) (action idle) (current_package 0) ))  
?route <-(route (start_node ?depart-city) (end_node ?end_city)(time ?between_path))
?c <- (total-no-packages ?total-no-packages)
=>
(retract ?route)
;(assert (route (start_node ?depart-city) (end_node ?end_city)(time ?between_path) (intermediate_cities ?through_city $?))
(retract ?c)
(assert (total-no-packages (+ ?total-no-packages 1)))
;(assert (have-to-deliver ?truck-n ?package-n ?delivery-city ?cost))
(modify ?package  (status "in transit") (pick_up_time ?time))
(modify ?truck (action going-to-deliver-packages) (destination_city ?delivery-city) (current_package ?package-n) 
(packages-being-carried ?package-n)
;(current_city ?next-city)
(available-space =(- ?space ?size)))
;(busy_time =(+ ?w1 ?b-time))
;(wait-time =(+ ?b (- ?time ?return-time))) 
;(event_time =(+ ?time ?w1)))
;(printout t "TRUCK   " ?truck-n  " next city " ?next-city "    at time " (+ ?w1 ?time) crlf)
(printout t "TRUCK   " ?truck-n  " Picked PACKAGE " ?package-n " for DELIVERY at TIME =  " ?time crlf))


;THIS RULE ASSIGNS A NON-EMPTY TRUCK TO AN ARRIVING PACKAGE WHEN THE TRUCK IS PRESENT IN THE DEPART CITY OF THE TRUCK AT THAT INSTANT( WITH NO HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-2-nonempty-truck-at-location-of-arriving-package        
(current-time ?time)
?package <- (package (package_number ?package-n) 
            (depart_city ?depart-city)
            (delivery_city ?delivery-city)
            (package_size ?size)
            (status "arrived")
            (order_arrival_time ?time)
            (pick_up_time nil))
?truck <- (truck (truck_number ?truck-n) 
          (current_city ?depart-city)
          (space_occupied ?space&:(>= ?space ?size)) 
          (action going-to-deliver-packages)
          ;(number-of-packages-carrying ?num&~0)
          (current_package ?package-num)
          (packages-being-carried $?p-num)
          (destination_city ~NIL)
          (event_time ?a)
          (busy_time ?b-time))
          ?package1 <- (package (package_number ?package-num) (delivery_city ?city) (order_arrival_time ?time))
;(have-to-deliver ?truck-n ?package-num ?city ?cost)
?route <-(route (start_node ?depart-city) (end_node ?end_city)(time ?between_path))
?c <- (total-no-packages ?total-no-packages)
=>
(retract ?c)
(retract ?route)
(assert (total-no-packages (+ ?total-no-packages 1)))
;(assert (have-to-deliver ?truck-n ?package-n ?delivery-city ?cost))
;(modify ?package1 (event-time =(+ ?time ?w1)))
(modify ?package (status "in transit") (pick_up_time ?time))
(modify ?truck (action going-to-deliver-packages)  
(packages-being-carried $?p-num ?package-n)
(space_occupied =(- ?space ?size))
(destination_city ?city)
(current_city ?city))
;(busy_time =(+ ?w1 ?b-time))
;(event-time =(+ ?time ?w1)))
(printout t "TRUCK   " ?truck-n  " Picked PACKAGE for DELIVERY  " ?package-n " at TIME =  " ?time crlf))
;(modify ?package (event-time =(+ ?time ?cost)) (location truck) (pick-up-time ?time))
;(printout t "TRUCK   " ?truck-n  " Picked PACKAGE for DELIVERY  " ?package-n " at TIME =  " ?time crlf))


;THIS RULE ASSIGNS A NON-EMPTY TRUCK TO AN ARRIVING PACKAGE WHEN THE TRUCK IS PRESENT IN THE DEPART CITY OF THE TRUCK AT THAT INSTANT( WITH AT LEAST ONE HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-2a-nonempty-truck-at-location-of-arriving-package        
(current-time ?time)
?package <- (package (package_number ?package-n) 
            (depart_city ?depart-city)
            (delivery_city ?delivery-city)
            (package_size ?size)
            (status "arrived")
            (order_arrival_time ?time)
            (pick_up_time nil))
?truck <- (truck (truck_number ?truck-n) 
          (current_city ?depart-city)
          (space_occupied ?space&:(>= ?space ?size)) 
          (action going-to-deliver-packages)
          ;(number-of-packages-carrying ?num&~0)
          (current_package ?package-num)
          (packages-being-carried $?p-num)
          (destination_city ~NIL)
          (event_time ?a)
          (busy_time ?b-time))
          ?package1 <- (package (package_number ?package-num) (delivery_city ?city) (order_arrival_time ?time))
;(have-to-deliver ?truck-n ?package-num ?city ?cost)
?route <-(route (start_node ?depart-city) (end_node ?end_city)(time ?between_path) (intermediate_cities ?through_city $?))
?c <- (total-no-packages ?total-no-packages)
=>
(retract ?c)
(retract ?route)
(assert (total-no-packages (+ ?total-no-packages 1)))
;(assert (have-to-deliver ?truck-n ?package-n ?delivery-city ?cost))
;(modify ?package1 (event-time =(+ ?time ?w1)))
(modify ?package (status "in transit") (pick_up_time ?time))
(modify ?truck (action going-to-deliver-packages)  
(packages-being-carried $?p-num ?package-n)
(space_occupied =(- ?space ?size))
(destination_city ?city)
(current_city ?city))
;(busy_time =(+ ?w1 ?b-time))
;(event-time =(+ ?time ?w1)))
(printout t "TRUCK   " ?truck-n  " Picked PACKAGE for DELIVERY  " ?package-n " at TIME =  " ?time crlf))
;(modify ?package (event-time =(+ ?time ?cost)) (location truck) (pick-up-time ?time))



;THIS RULE DISPATCHES THE TRUCK AT MINIMUM DISTANCE FROM DEPART CITY OF ARRIVING PACKAGE FOR PACKAGE PICK_UP
;TRUCK TAKES DIRECT SHORTEST ROUTE FROM ITS CURRENT LOCATION TO THE DEPART CITY OF PACKAGE
(defrule situation-3a-no-truck-at-location-of-arriving-package				
	(current-time ?time) 
	?packet <- (package	(package_number ?pnum)	
	           (order_arrival_time ?time)	
			   (package_size ?package_size)	
			   (depart_city ?start_city)
			   (delivery_city ?end_city)
			   (status "arrived")
			   (expackage_delivery_time ?package_delivery_time)) 
						
			
	(not 	(package (package_number ?pnum1&:(< ?pnum1 ?pnum))(order_arrival_time ?atime&:(< ?atime ?time))(package_size ?package_size1)(depart_city ?start_city)(delivery_city ?end_city1)(status "arrived")(expackage_delivery_time ?package_delivery_time1)) )

	?truck <- (truck (truck_number ?truck_number)	
	          (destination_city $?d) 
			  (current_city ?truck_city) 
			  (action "idle") 
			  (busy_time ?b_time) 
			  (wait_time ?w_time)
			  (event_time ?r_time) 
			  (non_del_time ?ndeltime)
			  (packages-being-carried $?nop)
			  (available-space ?truck_space&:(>= ?truck_space ?package_size)))		
	
	(route (start_node ?truck_city)(end_node ?start_city)(time ?s_path))	
	
	(not (and 		(truck (truck_number ?truck_num1&:(< ?truck_num1 ?truck_number)) (current_city ?truck_city)(action "idle")(available-space ?truck_space1&:(>= ?truck_space1 ?package_size)))(route (start_node ?truck_city)(end_node ?start_city)(time ?s_path1&:(eq ?s_path1 ?s_path)))
		  )		
	)	
	(not (and (truck (truck_number ?truck_num)(current_city ?truck_city1)(action "idle")(available-space ?truck_space2&:(>= ?truck_space2 ?package_size)))(route (start_node ?truck_city1)(end_node ?start_city)(time ?s_path2&:(< ?s_path2 ?s_path)))
		 )
	)						   
		
=>
	
	(printout t "TRUCK   "  ?truck_number "    ASSIGNED for PACKAGE     "   ?pnum   "   at time     " ?time crlf )
	(modify ?truck 	(destination_city $?d ?start_city)
					(action "going to pick a package")
					(wait_time =(+ ?w_time (- ?time ?r_time)))
					(busy_time =(+ ?s_path ?b_time))
					(non_del_time =(+ ?ndeltime ?s_path))
					(event_time =(+ ?time ?s_path))
					(packages-being-carried $?nop ?pnum))
		
	(modify ?packet 	(status "waiting to pick up") (picked-up-by ?truck_number)
					(wait_time ?s_path)))






;THIS RULE ASSIGNS A PACKAGE TO A TRUCK FOR TRAVEL TO DESTINATION( WITH AT LEAST ONE HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-3b-truck-arrived-to-pick-package				
									
	?packet <- (package (package_number ?pnum)
	           (depart_city ?start_city)
			   (delivery_city ?end_city)
			  (package_size ?package_size)
			  (status "waiting to pick up")) 
					  
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried $? ?pnum $?)
			  (destination_city ?start_city $?d)
			  (busy_time ?s_path)(wait_time ?w_time)(event_time ?r_time)(del_time ?deltime)
			  (action "going to pick a package")(available-space ?space_available)(space_occupied ?occupied)
			  (tot_space_occupied ?tot_occupied)(current_package ?packs))	
					
	(route (start_node ?start_city) (end_node ?end_city)(time ?between_path)	(intermediate_cities ?through_city $?))
			
	(route (start_node ?start_city) (end_node ?through_city)(time ?between_via_path))

	
=>	
	
	(printout t "TRUCK   " ?truck_number  "   GOING for DELIVERY of PACKAGE   "   ?pnum crlf) 
	(modify ?truck 	(destination_city $?d ?end_city)
					(current_city ?through_city)
					(action "in-transit-for-delivery-of-package")
					(busy_time =(+ ?s_path ?between_via_path))
					(event_time =(+ ?r_time ?between_via_path))
					(del_time =(+ ?deltime ?between_via_path))
					(available-space =(- ?space_available ?package_size))
					(space_occupied =(+ ?occupied ?package_size))
					(tot_space_occupied =(+ ?tot_occupied ?package_size))
					(current_package =(+ ?packs 1)))
	(modify ?packet (status "in-transit") 
	(package_delivery_time =(+ ?r_time ?between_via_path))
					(pick_up_time ?r_time)))


					
;THIS RULE ASSIGNS A PACKAGE TO A TRUCK FOR TRAVEL TO DESTINATION( WITH NO HOP BETWEEN DEPART AND DESTINATION CITIES)
(defrule situation-3c-truck-arrived-to-pick-package			
													
	?packet <- (package (package_number ?pnum)
	           (depart_city ?start_city)
			   (delivery_city ?end_city)
			   (package_size ?package_size)
			   (status "waiting to pick up")) 
			 
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried $? ?pnum $?)
			  (destination_city ?start_city $?d)
			  (busy_time ?s_path)
			  (wait_time ?w_time)
			  (event_time ?r_time)
			  (del_time ?deltime)
			(action "going to pick a package")
			(available-space ?space_available)
			(space_occupied ?occupied)
			(tot_space_occupied ?tot_occupied)(current_package ?packs))
	
	(not (package (package_number ?package_number&:(> ?package_number ?pnum))(order_arrival_time ?a_time&:(<= ?a_time ?r_time))(status "arrived")))
	
	(route (start_node ?start_city) (end_node ?end_city)(time ?between_path))
			

	
=>
	
	(printout t "TRUCK   " ?truck_number  "   GOING for DELIVERY of PACKAGE   "   ?pnum crlf) 
	(modify ?truck 	(destination_city $?d ?end_city)
					(current_city ?start_city)
					(action "in-transit-for-delivery-of-package")
					(busy_time =(+ ?s_path ?between_path))
					(event_time =(+ ?r_time ?between_path))
					(del_time =(+ ?deltime ?between_path))
					(available-space =(- ?space_available ?package_size))
					(space_occupied =(+ ?occupied ?package_size))
					(tot_space_occupied =(+ ?tot_occupied ?package_size))
					(current_package =(+ ?packs 1)))
					
	(modify ?packet (status "in-transit")(pick_up_time ?r_time)))


 
;THIS RULE UPDATES THE ROUTE AS TRUCK MOVES THROUGH EACH CITY BETWEEN SOURCE AND DESTINATION
(defrule update-route
	(declare (salience -2))								
	(current-time ?time)	
	(package (package_number ?pno)
	        (depart_city ?start_city)
			(delivery_city ?d_city)
			(package_size ?psize)
			(status "in-transit"|"waiting to pick up"))
	
	?packet <- (package (package_number ?pnum)
            	(depart_city ?through_city)
				(delivery_city ?end_city)
			    (package_size ?package_size)
				(status "arrived")
				(order_arrival_time ?time)
				(expackage_delivery_time ?package_delivery_time))
	
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried $?nop ?pno)
			  (current_city ?through_city)
			  (destination_city ?d_city $?dest_city)
			  (busy_time ?s_path)
			  (wait_time ?w_time)
			  (event_time ?r_time)
			  (del_time ?deltime)
			  (action "in-transit-for-delivery-of-package")
			  (available-space ?space_available&:(>= ?space_available ?package_size))
			  (space_occupied ?occupied)
			  (tot_space_occupied ?tot_occupied)
			  (current_package ?packs))
	
	(route (start_node ?through_city) (end_node ?end_city)(time ?between_path)(intermediate_cities $?))
	
	(route (start_node ?through_city)(end_node ?d_city)(time ?between_path1&:(< ?between_path1 ?between_path))(intermediate_cities $?))
	
	(route (start_node ?start_city)(end_node ?d_city)(time ?between_path2)(intermediate_cities ?through_city $?))
=>

	
	(printout t "TRUCK   " ?truck_number  "  PICKS up PACKAGE   "   ?pnum  "while on way for DELIVERY" crlf) 
	(modify ?truck 	(destination_city $?dest_city ?d_city ?end_city)
			(packages-being-carried $?nop ?pno ?pnum)
			(current_city ?through_city)
			(action "in-transit-for-delivery-of-package")
			(busy_time =(+ ?s_path ?between_path1))
			(event_time =(+ ?r_time ?between_path1))
			(del_time =(+ ?deltime ?between_path1))
			(available-space =(- ?space_available ?package_size))
			(space_occupied =(+ ?package_size ?occupied))
			(tot_space_occupied =(+ ?tot_occupied ?package_size))
			(current_package =(+ ?packs 1)))
	(modify ?packet (status "in-transit")
		      (pick_up_time ?r_time)))
			  
			  
;THIS RULE UPDATES THE ROUTE AS TRUCK MOVES THROUGH EACH CITY BETWEEN SOURCE AND DESTINATION(ALONG WITH ASSIGNMENT FROM QUEUE)			  
	(defrule update-route-queue						
	(current-time ?time) 					
	(package (package_number ?pnum)(status "arrived")(order_arrival_time ?time)) 
	
	?packet <- (package (package_number ?package)
	           (status "waiting in queue")
			   (order_arrival_time ?time1&:(< ?time1 ?time))
			   (package_size ?package_size1)
			   (depart_city ?start_city1)
			   (delivery_city ?end_city1)
			   (expackage_delivery_time ?package_delivery_time1)
			   (wait_time ?p_w_time))
	
	(not (package (package_number ?package1)(status "waiting in queue")(order_arrival_time ?time2&:(< ?time2 ?time1))
		 (expackage_delivery_time ?package_delivery_time2&:(< ?package_delivery_time2 ?package_delivery_time1))))
	
	?queue <- (queue $?d ?package $?p)
	
	?truck <- (truck (truck_number ?truck_number)(current_city ?curr_city)(action "idle")(available-space ?truck_space&:(>= ?truck_space ?package_size1))
			 (event_time ?rea_time)(busy_time ?ttime)(wait_time ?t_w_time)(non_del_time ?ndeltime))
	
	(route (start_node ?curr_city)(end_node ?start_city1)(time ?s_path))
	
	(not (and (truck (truck_number ?truck_num)(current_city ?truck_city)(action "idle")
	          (available-space ?truck_space&:(>= ?truck_space ?package_size1))(event_time ?r_time))
	
	(route (start_node ?truck_city)(end_node ?start_city1)(time ?s_path1&:(< ?s_path1 ?s_path)))))
				
	
=>
	
	(printout t "TRUCK   " ?truck_number  "   PICKS PACKAGE from QUEUE   " ?pnum  "  at time   " ?time    crlf) 
	(retract ?queue)
	(assert (queue $?d $?p))
	(modify ?truck 	(destination_city ?start_city1)
			(packages-being-carried ?package)
			(action "going to pick a package")
			(event_time (+ ?time ?s_path))
			(busy_time =(+ ?s_path ?ttime))
			(wait_time =(+ ?t_w_time (- ?time ?rea_time)))
			(non_del_time =(+ ?ndeltime ?s_path)))
	(modify ?packet (status "waiting to pick up")
			(pick_up_time =(+ ?rea_time ?s_path))
			(wait_time =(- (+ ?rea_time ?s_path) ?time1))))

			
			

;THIS RULE UPDATES THE ROUTE AS TRUCK MOVES THROUGH EACH CITY BETWEEN SOURCE AND DESTINATION(ALONG WITH ASSIGNMENT FROM QUEUE)	
(defrule update-route-1-queue				
	(current-time ?time) 					
	
	?packet <- (package (package_number ?package)
	                    (status "waiting in queue")
						(order_arrival_time ?atime&:(<= ?atime ?time))
						(package_size ?package_size1)
			            (depart_city ?start_city1)
						(delivery_city ?end_city1)
						(expackage_delivery_time ?package_delivery_time1)
						(wait_time ?p_w_time))
	
	(not (package (package_number ?package1)(status "waiting in queue")(expackage_delivery_time ?package_delivery_time2&:(< ?package_delivery_time2 ?package_delivery_time1))))
	
	?queue <- (queue $?d ?package $?p)
			
	?truck <- (truck (truck_number ?truck_number)(current_city ?curr_city)(action "idle")
			  (available-space ?truck_space&:(>= ?truck_space ?package_size1))
			  (event_time ?rea_time&:(<= ?rea_time ?time))
			  (busy_time ?ttime)(wait_time ?t_w_time)
			 (non_del_time ?ndeltime))
	
	(route (start_node ?curr_city)(end_node ?start_city1)(time ?s_path))
	
	(not (and (truck (truck_number ?truck_num)(current_city ?truck_city)(action "idle")(available-space ?truck_space&:(>= ?truck_space ?package_size1))(event_time ?r_time))
	
	(route (start_node ?truck_city)(end_node ?start_city1)(time ?s_path1&:(< ?s_path1 ?s_path)))))
				
	
=>
	
	(printout t "TRUCK   " ?truck_number  "   PICKS PACKAGE from QUEUE   " ?package  "  at time   " ?time    crlf)
	(retract ?queue)
	(assert (queue $?d $?p))
	(modify ?truck 	(destination_city ?start_city1)
			(packages-being-carried ?package)
			(action "going to pick a package")
			(busy_time =(+ ?s_path ?ttime))
			(event_time (+ ?time ?s_path))
			(wait_time =(+ ?t_w_time (- ?time ?rea_time)))
			(non_del_time =(+ ?ndeltime ?s_path)))
	(modify ?packet (status "waiting to pick up")
			(pick_up_time =(+ ?rea_time ?s_path))
			(wait_time =(- (+ ?rea_time ?s_path) ?atime))))




;THIS RULE DELIVERS THE LAST PACKAGE BEING CARRIED BY A TRUCK AT ITS DESTINATION
(defrule situation-4-last-package-delivered-at-destination-1								
			(current-time ?curr)
	?packet <- (package (package_number ?pnum)
	           (depart_city ?start_city)
			   (delivery_city ?ecity)
			   (order_arrival_time ?atime)
		 	   (status "in-transit")
			   (wait_time ?pwtime) 
			   (pick_up_time ?pick_up_time)
			   (package_size ?package_size)
			   (expackage_delivery_time ?package_delivery_time))
			
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried ?pnum)
			  (current_city ?scity)
			  (destination_city ?ecity)
			  (busy_time ?s_path)
			  (wait_time ?w_time)
			  (event_time ?r_time&:(<= ?r_time ?curr))
			  (del_time ?deltime)
			  (action "in-transit-for-delivery-of-package")
			  (available-space ?a_space))
	
	(route (start_node ?scity)(end_node ?ecity)(time ?btime))
	
	(route (start_node ?start_city)(end_node ?ecity)(time ?time_of_travel))
	
	?counter <- (#packages_delivered ?pack_delivered)
	
	?avg <- (AVG_PACKAGE_REPORT (tot_wait_time ?avgwtime)
					(packs_delivered_ontime ?ontime)
					(late-package-counter ?late)
					(late_time ?latetime))
	
=> 
	(printout t "TRUCK   " ?truck_number  "  DELIVERS PACKAGE   "   ?pnum crlf)
	(retract ?counter)
	(modify ?truck 	(current_city ?ecity)(packages-being-carried)
			(destination_city ?ecity)
			(action "delivered package")
			(busy_time (+ ?btime ?s_path))
			(event_time ?r_time)
			(del_time (+ ?btime ?deltime))
			(available-space =(+ ?a_space ?package_size))
			(space_occupied 0))
	(assert (#packages_delivered =(+ ?pack_delivered 1)))
	(modify ?packet (status "delivered")
		      (package_delivery_time =(+ ?pick_up_time ?time_of_travel))
			  ;(package_delivery_time ?r_time)
	)		  
	(modify ?avg (tot_wait_time =(+ ?avgwtime ?pwtime))))



	
;THIS RULE DELIVERS ONE OF THE MANY PACKAGES(NOT LAST) BEING CARRIED BY A TRUCK AT ITS DESTINATION	
(defrule situation-4a-non-last-package-delivered-at-destination					
															
	(current-time ?curr)
	?packet <- (package (package_number ?pnum)
	           (depart_city ?scity)
			   (delivery_city ?ecity)
			   (order_arrival_time ?atime)
			   (status "in-transit")
			   (wait_time ?pwtime)
			   (package_size ?package_size)
			   (expackage_delivery_time ?package_delivery_time))
			
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried ?pnum $?nop)
			  (current_city ?start_city)
	       	  (destination_city ?ecity ?d $?del)
			  (busy_time ?s_path)(wait_time ?w_time)
			  (event_time ?r_time)
			  (del_time ?deltime)
			  (action "in-transit-for-delivery-of-package")
			  (available-space ?a_space))
	
	(not (package (package_number ?package_number&:(> ?package_number ?pnum))(order_arrival_time ?a_time&:(<= ?a_time ?r_time))(status "waiting to pick up"|"arrived")))
	
	(route (start_node ?start_city)(end_node ?ecity)(time ?btime))
	
	(route (start_node ?ecity)(end_node ?d)(time ?b1time))
	
	?counter <- (#packages_delivered ?pack_delivered)
	?avg <- (AVG_PACKAGE_REPORT   (tot_wait_time ?avgwtime)
					(packs_delivered_ontime ?ontime)
					(late-package-counter ?late)
					(late_time ?latetime))
					
=>  
	
	(printout t "TRUCK   " ?truck_number  "   DELIVERS PACKAGE   "   ?pnum crlf) 
	(retract ?counter)
	(modify ?truck 	(current_city ?ecity)
			(packages-being-carried $?nop)
			(destination_city ?d $?del)
			(action "in-transit-for-delivery-of-package")
			(busy_time =(+ ?s_path ?b1time))
			(event_time =(+ ?r_time ?b1time))
			(del_time =(+ ?deltime ?b1time))
			(available-space =(+ ?a_space ?package_size))
			(space_occupied =(- ?a_space ?package_size)))
	(assert (#packages_delivered =(+ ?pack_delivered 1)))
	(modify ?packet (status "delivered")
		      (package_delivery_time ?r_time))
	(modify ?avg (tot_wait_time =(+ ?avgwtime ?pwtime))))




 
;THIS RULE UPDATES THE DELIVERY OF REMAINING PACKAGES
(defrule situation-4-remaining-packages-delivered-at-destination									 
	(current-time ?curr)
	?packet <- (package (package_number ?pnum)
	           (depart_city ?start_city)
			   (delivery_city ?ecity)
			   (order_arrival_time ?atime)
		 	   (status "in-transit")
			   (wait_time ?pwtime)
			   (package_size ?package_size)
			   (expackage_delivery_time ?package_delivery_time))
	
	(not (package (status "arrived"|"waiting to pick up")))
	
	?truck <- (truck (truck_number ?truck_number)
	          (packages-being-carried ?pnum)
			  (current_city ?scity)
			  (destination_city ?ecity)
			  (busy_time ?s_path)
			  (wait_time ?w_time)
			  (event_time ?r_time)(del_time ?deltime)
			  (action "in-transit-for-delivery-of-package")
			  (available-space ?a_space))
	
	(route (start_node ?scity)(end_node ?ecity)(time ?btime))
	
	?counter <- (#packages_delivered ?pack_delivered)
	?avg <- (AVG_PACKAGE_REPORT   (tot_wait_time ?avgwtime)
					(packs_delivered_ontime ?ontime)
					(late-package-counter ?late)
					(late_time ?latetime))
	
=>
	(printout t "TRUCK   " ?truck_number  "   DELIVERS PACKAGE   "   ?pnum crlf) 
	(assert (waitingtime (- (+ ?btime ?r_time) ?curr)))
	(retract ?counter)
	(modify ?truck 	(current_city ?ecity)
			(packages-being-carried)
			(destination_city ?ecity)
			(action "delivered package")
			(busy_time =(+ ?s_path ?btime))
			(event_time =(+ ?r_time ?btime))
			(del_time =(+ ?deltime ?btime))
			(available-space =(+ ?a_space ?package_size))
			(space_occupied 0))
	(assert (#packages_delivered =(+ ?pack_delivered 1)))
	(assert (all))
	(modify ?packet (status "delivered")
		      (package_delivery_time ?r_time))
	(modify ?avg (tot_wait_time =(+ ?avgwtime ?pwtime))))



;THIS RULE MODIFIES THE INFORMATION FOR TRUCK WHEN IT HAS NO WORK
(defrule Modification-Of-Truck-To-Make-It-Idle-When-No-Package
	
?truck <- (truck (truck_number ?truck_number)	
          (current_city ?curr)
		  (busy_time ?b_time)
		  (wait_time ?w_time)
		  (event_time ?r_time)
		  (action "delivered package")
		  (current_package ?no_of_packs)
		  (non_del_time ?ndeltime)
		  (available-space ?space)(del_time ?deltime))
					 
		(not (package 	(order_arrival_time ?a_time&:(< ?a_time ?r_time))(status "arrived")))
		
		(not (truck (event_time ?r_time1&:(< ?r_time1 ?r_time))(action "going to pick a package"|"in-transit-for-delivery-of-package"|"delivered package")))
=>	
	
	
		(modify ?truck  (destination_city)
			(packages-being-carried)
			(busy_time ?b_time)
			(wait_time ?w_time)
			(current_city ?curr)
			(action "idle")
			(event_time ?r_time)
			(available-space ?space)
			(non_del_time ?ndeltime)
			(del_time ?deltime))
			
		
			)

;THIS RULE ASSIGNS AN ARRIVING PACKAGE TO QUEUE
(defrule assignment-to-queue-of-an-arriving-package				
											
	(declare (salience -2))												
	(current-time ?time) 

	?packet <- (package (package_number ?num)
	           (order_arrival_time ?time)
			   (depart_city ?dcity)
			   (status "arrived")
			   (package_size ?psize))
	
			 (not (truck (truck_number ?tno)
			 (action "idle")
			 (available-space ?space&:(>= ?space ?psize))))
	
	?queue <- (queue $?packages) 
=>
	
	(printout t "PACKAGE    "  ?num "   ASSIGNED to QUEUE at time   "  ?time  crlf)
	(modify ?packet (status "waiting in queue"))
 	(retract ?queue) 
 	(assert (queue ?num $?packages)))




			

(defrule Truck_Report_Header
	
	(not (truck (truck_number ?tnum)
		(action "delivered package"|"in-transit-for-delivery-of-package"|"going to pick a package")))
	(not (package (package_number ?packet)
			(status "arrived"|"waiting to pick up"|"in-transit")))
	(all)
=>
	(printout t crlf)
	(printout t crlf)
	(printout t crlf)
	(printout t crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "                                                                         INDIVIDUAL  TRUCK REPORT                                                                                                       " crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t " TRUCK#  |	Wait Time | Total Time Busy |  Busy Time(%)  | #Packages Carrying | Avg % Occupancy | Non Delivery Travel Time | Non Del Time(%)	| Delivery Travel Time | Delivery Time (%)	| "  crlf)						
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
	(assert (truck-header done))
	(assert (trucks 0)))



(defrule Information-Statistics																		
	(#packages_delivered ?counter&:(eq ?counter ?*packages*))
	(current-time ?time)
	(truck-header done)
	?t <- (trucks ?trucks_done)
	?truck <- (truck (truck_number ?t_no)
		(current_city ?truck_city)
		(action "idle")
		(wait_time ?w_time&:(neq ?w_time 0))
		(busy_time ?b_time&:(neq ?b_time 0))
		(current_package ?packs)
		(non_del_time ?ndeltime)
		(space_occupied ?occupied_space)	
		(available-space ?avail_space)
		(tot_space_occupied ?tot_occupied)
		(del_time ?deltime))
	(not (truck (truck_number ?tnum&:(< ?tnum ?t_no))
		(action ?action&:(eq ?action "idle"))))
		(waitingtime ?tw)
=>
	(retract ?truck)
	(printout t "    ")
	(format t "%-08d" ?t_no)
	(format t "%-015d" (+ ?tw ?w_time))
	(format t "%-015d" ?b_time)
	(format t "%-20.2f" (/ (* ?b_time 100) ?time))
	(format t "%-022d" ?packs)
	(format t "%-20.2f" (* (/ ?tot_occupied (* ?avail_space ?packs)) 100))
	(format t "%-020d" ?ndeltime)
	(format t "%-20.2f" (* (/ ?ndeltime (+ ?w_time ?b_time)) 100))
	(format t "%-022d" ?deltime)
	(format t "%-20.2f" (* (/ ?deltime (+ ?w_time ?b_time)) 100))
	(printout t crlf)
	(assert (trucks (+ 1 ?trucks_done))))




(defrule Package_Report_Header
	(truck-header done)
	(#packages_delivered ?counter&:(eq ?counter ?*packages*))
	(trucks ?truck_counter&:(eq ?truck_counter ?*trucks*))
=>
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "                                                  INDIVIDUAL PACKAGE REPORT                                                       " crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "  PACKAGE#  |  Arrival Time  |  Pick Up Time  |  Total Wait Time | Picked By |  Delivery Time  | Status At Delivery  | Delivery Delayed By |" crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(assert (package-header done))
(assert (packages 0)))


	
	
(defrule Package_updates
(declare(salience 3))
(#packages_delivered ?counter&:(eq ?counter ?*packages*))
(truck-header done)
	(package-header done)
?p <-(package (package_number ?package)
		 (package_delivery_time ?dtime)
		 (delivery-status ON-TIME)
		 (delivery-delayed-by 0)
		 (expackage_delivery_time ?exptime&: (< ?exptime ?dtime)))
	 
?l <- (late-counter-package ?late-counter)


=>
(retract ?l)
(assert (late-counter-package =(+ ?late-counter 1)))
(modify ?p (package_number ?package) (package_delivery_time ?dtime) (delivery-status LATE) (delivery-delayed-by =(- ?dtime ?exptime))) )



	
	

(defrule Package_Report					
	(truck-header done)
	(package-header done)
	(#packages_delivered ?counter&:(eq ?counter ?*packages*))
	(trucks ?truck_counter&:(eq ?truck_counter ?*trucks*))
	?p1 <- (packages ?packages_done)
	?p <- (package (package_number ?package)
		 (depart_city ?start_city)
		 (delivery_city ?end_city)
		 (wait_time ?w_time)
		 (pick_up_time ?ptime)
		 (order_arrival_time ?atime)
		 (package_delivery_time ?dtime)
		 (expackage_delivery_time ?exptime)
		 (delivery-status ?status)
		 (delivery-delayed-by ?delivery-delayed-by)
		 (status "delivered")
		 (picked-up-by ?truck_number))
	(route (start_node "Orlando")
			(end_node ?start_city)
			(time ?time1))
	(route (start_node ?start_city)
			(end_node ?end_city)
			(time ?time2))
	(not (package (package_number ?packet&:(< ?packet ?package))
			(status ?stat&:(eq ?stat "delivered"))))
	?a <- (All-Package-WaitTime-Counter (Package-Total-Wait-time ?wait-time-counter))
	?d <-(total-late-delivery-time ?total-late-delivery-time)
?c <- (total-no-packages ?total-no-packages)

=>
(retract ?c)
(assert (total-no-packages (+ ?total-no-packages 1)))
	(modify ?a (Package-Total-Wait-time =(+ ?wait-time-counter (- ?ptime ?atime))))
	(retract ?p1)
	(retract ?d)
	(assert (total-late-delivery-time (+ ?total-late-delivery-time ?delivery-delayed-by)))
	(modify ?p (status "done"))
	(printout t "    ")
	(format t "%-018d" ?package)
	(format t "%-018d" ?atime)
	(format t "%-019d" ?ptime)
	(format t "%-015d" (- ?ptime ?atime))
	(format t "%-015d" ?truck_number)
	(format t "%-018d" ?dtime)
	(bind ?res (<= (+ ?time1 ?time2) (- ?exptime ?atime)))
	(format t "%-022s" ?status)
	(bind ?delay 0)
	(if (neq ?res TRUE) 
	 then (bind ?delay (- (+ ?time1 ?time2) (- ?exptime ?atime))))
	(format t "%-012d		" ?delivery-delayed-by)
	(printout t crlf)
	(assert (packages (+ ?packages_done 1))))






(defrule PACKAGE-AVERAGE-REPORT		
	(truck-header done)
	(#packages_delivered ?counter&:(eq ?counter ?*packages*))
	(trucks ?truck_counter&:(eq ?truck_counter ?*trucks*))
	(package-header done)
	(packages ?pdone_counter&:(eq ?pdone_counter ?*packages*))			
	(All-Package-WaitTime-Counter (Package-Total-Wait-time ?wait-time-counter))	
	(late-counter-package ?late-counter)
	(total-late-delivery-time ?total-late-delivery-time)
	(total-no-packages ?total-no-packages)

=>
(printout t crlf)
	(printout t crlf)
	(printout t crlf)
	(printout t crlf)

(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
(printout t "         AVERAGE-PACKAGE-REPORT    "        crlf)
(printout t "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" crlf)
	
	
	(format t " 1. AVERAGE WAIT TIME FOR PACKAGES 			:		%-20.2f" (/ ?wait-time-counter ?total-no-packages))
	(printout t crlf)
	(format t " 2. # Packages which have been delivered ON-TIME 	:		%-20d "   (- ?total-no-packages ?late-counter))
	(printout t crlf)
	(format t " 3. # Packages which have been delivered LATE 		:		%-20d	"    ?late-counter)
	(printout t crlf)
	(format t " 4. AVERAGE lateness for LATE packages		:		%-20.2f	"     (/ ?total-late-delivery-time ?late-counter)      )
	(printout t crlf)
	(format t " 5. AVERAGE lateness for ALL packages 		:		%-20.2f	"      (/ ?total-late-delivery-time ?total-no-packages)    )
	(printout t crlf)
	(printout t crlf) 
	(halt)
	
	)
	



