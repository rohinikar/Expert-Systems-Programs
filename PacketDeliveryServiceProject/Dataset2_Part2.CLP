(deftemplate truck
	(slot truck_number)
	(slot current_city)
	(multislot destination_city)
	(slot action)
	(slot wait_time)
	(slot busy_time)
	(slot event_time)
	(slot available-space)
	(slot space_occupied)
	(slot current_package)
	(slot tot_space_occupied)
	(slot non_del_time)
	(slot del_time)
	(multislot packages-being-carried))
	


(deftemplate package
	(slot package_number)
	(slot depart_city)
	(slot delivery_city)
	(slot package_size)
	(slot order_arrival_time)
	(slot expackage_delivery_time)
	(slot pick_up_time)
	(slot package_delivery_time)
	(slot delivery-delayed-by)
	(slot delivery-status)
	(slot wait_time)
	(slot status)
	(slot picked-up-by)	)
	




(deftemplate cheapest_paths 
	(slot start_city)
	(multislot neighboring_cities))

	
	
(deftemplate route
	(slot start_node)
	(slot end_node)
	(slot time)
	(multislot intermediate_cities))



(deftemplate AVG_PACKAGE_REPORT
	(slot tot_wait_time)
	(slot packs_delivered_ontime)
	(slot late-package-counter)
	(slot late_time))
	


(deftemplate All-Package-WaitTime-Counter
(slot Package-Total-Wait-time))	



(deftemplate Late-Package-Counter
(slot late-counter))	

(defglobal ?*packages* = 50)
(defglobal ?*trucks* = 10)

(deffacts P-A-U-Delivery-Service 	
	(truck (truck_number 1)(current_city "Orlando") (action "idle")(available-space 5)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 2)(current_city "Orlando") (action "idle")(available-space 5)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 3)(current_city "Ocala") (action "idle")(available-space 10)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 4)(current_city "Tallahassee") (action "idle")(available-space 10)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 5)(current_city "Key West") (action "idle")(available-space 10)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 6)(current_city "Ft. Myers") (action "idle")(available-space 15)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 7)(current_city "Gainesville") (action "idle")(available-space 15)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 8)(current_city "West Palm") (action "idle")(available-space 15)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 9)(current_city "Key West") (action "idle")(available-space 20)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	(truck (truck_number 10)(current_city "Jacksonville") (action "idle")(available-space 20)(wait_time 0)(busy_time 0)(space_occupied 0)(tot_space_occupied 0)(event_time 0)(current_package 0)(non_del_time 0)(del_time 0))
	


	(package (package_number 1)(status "arrived")(depart_city "Orlando")(delivery_city "Jacksonville")(package_size 4)(order_arrival_time 1)(expackage_delivery_time 10)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 2)(status "arrived")(depart_city "Gainesville")(delivery_city "Jacksonville")(package_size 9)(order_arrival_time 1)(expackage_delivery_time 10)(wait_time 0)(package_delivery_time 0)(pick_up_time 0)(delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 3)(status "arrived")(depart_city "St. Augustine")(delivery_city "Ft. Myers")(package_size 9)(order_arrival_time 3)(expackage_delivery_time 15)(wait_time 0)(package_delivery_time 0)(pick_up_time 0)(delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 4)(status "arrived")(depart_city "Jacksonville")(delivery_city "Key West")(package_size 4)(order_arrival_time 3)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0)(delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 5)(status "arrived")(depart_city "West Palm")(delivery_city "St. Augustine")(package_size 13)(order_arrival_time 4)(expackage_delivery_time 10)(wait_time 0)(package_delivery_time 0)(pick_up_time 0)(delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 6)(status "arrived")(depart_city "West Palm")(delivery_city "St. Augustine")(package_size 4)(order_arrival_time 4)(expackage_delivery_time 15)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 7)(status "arrived")(depart_city "Key West")(delivery_city "St. Augustine")(package_size 9)(order_arrival_time 5)(expackage_delivery_time 12)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 8)(status "arrived")(depart_city "Gainesville")(delivery_city "Gainesville")(package_size 5)(order_arrival_time 7)(expackage_delivery_time 30)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 9)(status "arrived")(depart_city "Miami")(delivery_city "Gainesville")(package_size 5)(order_arrival_time 8)(expackage_delivery_time 25)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 10)(status "arrived")(depart_city "Miami")(delivery_city "Tallahassee")(package_size 10)(order_arrival_time 8)(expackage_delivery_time 15)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 11)(status "arrived")(depart_city "Jacksonville")(delivery_city "Miami")(package_size 5)(order_arrival_time 8)(expackage_delivery_time 15)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 12)(status "arrived")(depart_city "Ft. Myers")(delivery_city "Key West")(package_size 4)(order_arrival_time 9)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 13)(status "arrived")(depart_city "Orlando")(delivery_city "Key West")(package_size 14)(order_arrival_time 9)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 14)(status "arrived")(depart_city "West Palm")(delivery_city "Miami")(package_size 2)(order_arrival_time 9)(expackage_delivery_time 14)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 15)(status "arrived")(depart_city "Miami")(delivery_city "Ocala")(package_size 4)(order_arrival_time 10)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 16)(status "arrived")(depart_city "Gainesville")(delivery_city "Orlando")(package_size 7)(order_arrival_time 11)(expackage_delivery_time 15)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 17)(status "arrived")(depart_city "Tampa")(delivery_city "Tallahassee")(package_size 12)(order_arrival_time 12)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 18)(status "arrived")(depart_city "St. Augustine")(delivery_city "Ft. Myers")(package_size 8)(order_arrival_time 13)(expackage_delivery_time 30)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 19)(status "arrived")(depart_city "Gainesville")(delivery_city "Tallahassee")(package_size 6)(order_arrival_time 13)(expackage_delivery_time 21)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 20)(status "arrived")(depart_city "West Palm")(delivery_city "St. Augustine")(package_size 15)(order_arrival_time 14)(expackage_delivery_time 20)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 21)(status "arrived")(depart_city "Key West")(delivery_city "St. Augustine")(package_size 14)(order_arrival_time 14)(expackage_delivery_time 25)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 22)(status "arrived")(depart_city "Jacksonville")(delivery_city "Key West")(package_size 10)(order_arrival_time 15)(expackage_delivery_time 33)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 23)(status "arrived")(depart_city "Jacksonville")(delivery_city "Tallahassee")(package_size 7)(order_arrival_time 20)(expackage_delivery_time 25)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 24)(status "arrived")(depart_city "Tallahassee")(delivery_city "Gainesville")(package_size 10)(order_arrival_time 22)(expackage_delivery_time 32)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 25)(status "arrived")(depart_city "St. Augustine")(delivery_city "Ft. Myers")(package_size 15)(order_arrival_time 23)(expackage_delivery_time 34)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 26)(status "arrived")(depart_city "Jacksonville")(delivery_city "Key West")(package_size 12)(order_arrival_time 25)(expackage_delivery_time 40)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 27)(status "arrived")(depart_city "Ocala")(delivery_city "Orlando")(package_size 7)(order_arrival_time 27)(expackage_delivery_time 35)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 28)(status "arrived")(depart_city "Miami")(delivery_city "Orlando")(package_size 5)(order_arrival_time 28)(expackage_delivery_time 38)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 29)(status "arrived")(depart_city "West Palm")(delivery_city "Ft. Myers")(package_size 14)(order_arrival_time 30)(expackage_delivery_time 43)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 30)(status "arrived")(depart_city "Orlando")(delivery_city "Lake City")(package_size 6)(order_arrival_time 35)(expackage_delivery_time 40)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 31)(status "arrived")(depart_city "Miami")(delivery_city "Gainesville")(package_size 5)(order_arrival_time 37)(expackage_delivery_time 48)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 32)(status "arrived")(depart_city "Tampa")(delivery_city "Tallahassee")(package_size 12)(order_arrival_time 38)(expackage_delivery_time 50)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 33)(status "arrived")(depart_city "Miami")(delivery_city "Key West")(package_size 3)(order_arrival_time 40)(expackage_delivery_time 45)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 34)(status "arrived")(depart_city "St. Augustine")(delivery_city "Ft. Myers")(package_size 8)(order_arrival_time 43)(expackage_delivery_time 60)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 35)(status "arrived")(depart_city "Miami")(delivery_city "Ocala")(package_size 6)(order_arrival_time 45)(expackage_delivery_time 55)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 36)(status "arrived")(depart_city "Gainesville")(delivery_city "Orlando")(package_size 7)(order_arrival_time 47)(expackage_delivery_time 54)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 37)(status "arrived")(depart_city "St. Augustine")(delivery_city "Tallahassee")(package_size 8)(order_arrival_time 50)(expackage_delivery_time 65)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 38)(status "arrived")(depart_city "Miami")(delivery_city "Tallahassee")(package_size 7)(order_arrival_time 52)(expackage_delivery_time 70)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 39)(status "arrived")(depart_city "Tallahassee")(delivery_city "Lake City")(package_size 8)(order_arrival_time 55)(expackage_delivery_time 60)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 40)(status "arrived")(depart_city "Lake City")(delivery_city "Tallahassee")(package_size 7)(order_arrival_time 60)(expackage_delivery_time 67)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 41)(status "arrived")(depart_city "Tallahassee")(delivery_city "Key West")(package_size 12)(order_arrival_time 62)(expackage_delivery_time 82)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 42)(status "arrived")(depart_city "St. Augustine")(delivery_city "Key West")(package_size 5)(order_arrival_time 65)(expackage_delivery_time 85)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 43)(status "arrived")(depart_city "Tampa")(delivery_city "Jacksonville")(package_size 9)(order_arrival_time 67)(expackage_delivery_time 78)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 44)(status "arrived")(depart_city "Ft. Myers")(delivery_city "Key West")(package_size 6)(order_arrival_time 70)(expackage_delivery_time 80)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 45)(status "arrived")(depart_city "Miami")(delivery_city "Orlando")(package_size 7)(order_arrival_time 75)(expackage_delivery_time 85)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 46)(status "arrived")(depart_city "Key West")(delivery_city "St. Augustine")(package_size 15)(order_arrival_time 77)(expackage_delivery_time 79)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 47)(status "arrived")(depart_city "Tallahassee")(delivery_city "Lake City")(package_size 9)(order_arrival_time 80)(expackage_delivery_time 85)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 48)(status "arrived")(depart_city "West Palm")(delivery_city "Ft. Myers")(package_size 12)(order_arrival_time 80)(expackage_delivery_time 95)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 49)(status "arrived")(depart_city "Tampa")(delivery_city "Tallahassee")(package_size 10)(order_arrival_time 81)(expackage_delivery_time 84)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	(package (package_number 50)(status "arrived")(depart_city "Orlando")(delivery_city "Key West")(package_size 12)(order_arrival_time 82)(expackage_delivery_time 85)(wait_time 0)(package_delivery_time 0)(pick_up_time 0) (delivery-status ON-TIME)(delivery-delayed-by 0) (picked-up-by 0))
	
)
	
(deffacts cheapest_paths 
	(cheapest_paths (start_city "Key West")(neighboring_cities "Miami" 3)) 
	(cheapest_paths (start_city "Tallahassee")(neighboring_cities "Lake City" 2))
	(cheapest_paths (start_city "Ft. Myers")(neighboring_cities "Tampa" 2 "West Palm" 3))
	(cheapest_paths (start_city "Miami")(neighboring_cities "West Palm" 2 "Key West" 3))
	(cheapest_paths (start_city "Ocala")(neighboring_cities "Tampa" 2 "Gainesville" 1 "Orlando" 1))
	(cheapest_paths (start_city "Tampa")(neighboring_cities "Orlando" 1 "Ocala" 2 "Ft. Myers" 2))	
	(cheapest_paths (start_city "Jacksonville")(neighboring_cities "St. Augustine" 1 "Lake City" 1))
	(cheapest_paths (start_city "Gainesville")(neighboring_cities "St. Augustine" 1 "Ocala" 1 "Lake City" 1))
	(cheapest_paths (start_city "St. Augustine")(neighboring_cities "Jacksonville" 1 "Gainesville" 1 "Orlando" 2 "West Palm" 3))
	(cheapest_paths (start_city "Lake City")(neighboring_cities "Gainesville" 1 "Jacksonville" 1 "Tallahassee" 2))
	(cheapest_paths (start_city "West Palm")(neighboring_cities "Orlando" 3 "Ft. Myers" 3 "St. Augustine" 3 "Miami" 2))
	(cheapest_paths (start_city "Orlando")(neighboring_cities "Tampa" 1 "St. Augustine" 2 "Ocala" 1 "West Palm" 3))

)	
	
(deffacts data 	
	(queue) 
	(current-time 0)
	(#packages_delivered 0)
	(late-counter-package 0)
	(total-late-delivery-time 0)
	(total-no-packages 0)
	
)

	
(deffacts AVERAGE_REPORT 
	(AVG_PACKAGE_REPORT (tot_wait_time 0)
						(packs_delivered_ontime 50)
						(late-package-counter 0)
						(late_time 0))
)
	


(deffacts Package-wait-time-Counter
(All-Package-WaitTime-Counter (Package-Total-Wait-time 0)))




