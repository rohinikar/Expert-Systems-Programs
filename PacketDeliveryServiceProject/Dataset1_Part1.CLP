(deftemplate package
(slot number)
(slot depart-city)
(slot delivery-city)
(slot size)
(slot wait-time)
(slot location)
(slot event-time)
(slot time-of-pick-up)
(slot time-of-delivery)
(slot delivery-delayed-by)
(slot status-at-delivery)
(slot order-arrival-time)
(slot expect-time-of-delivery))

(deftemplate truck
(slot number)
(slot current-location)
(slot destination)
(slot available-space)
(slot event-time)
(slot return-time)
(slot busy-time)
(slot space-occupied)
(slot total-travel-time)
(slot total-time-of-delivery)
(slot non-del-time)
(slot del-time)
(slot action)
(slot wait-time)
(slot packages-carrying)
(slot package-number))


(deftemplate Number-of-Packages-Delivered
(slot Packages-Delivered))

(deftemplate Number-of-Trucks-at-Orlando
(slot Trucks-at-Orlando))

(deftemplate Total-Wait-Time
(slot Package-Total-Wait-time))

(deftemplate edge 
(slot from) 
(slot to) 
(slot cost))

(deftemplate cheapest_paths 
(slot start) 
(slot stop))

(deftemplate path 
(multislot nodes)
(slot cost))



(deffacts P-A-U-delivery-service
(edge (from "Tallahassee") (to "Lake City") (cost 2))
(edge (from "Lake City") (to "Tallahassee") (cost 2))
(edge (from "Lake City") (to "Jacksonville") (cost 1))
(edge (from "Jacksonville") (to "Lake City") (cost 1))
(edge (from "Lake City") (to "Gainesville") (cost 1))
(edge (from "Gainesville") (to "Lake City") (cost 1))
(edge (from "Jacksonville") (to "St. Augustine") (cost 1))
(edge (from "St. Augustine") (to "Jacksonville") (cost 1))
(edge (from "Gainesville") (to "St. Augustine") (cost 1))
(edge (from "St. Augustine") (to "Gainesville") (cost 1))
(edge (from "Gainesville") (to "Ocala") (cost 1))
(edge (from "Ocala") (to "Gainesville") (cost 1))
(edge (from "St. Augustine") (to "Orlando") (cost 2))
(edge (from "Orlando") (to "St. Augustine") (cost 2))
(edge (from "Orlando") (to "Ocala") (cost 1))
(edge (from "Ocala") (to "Orlando") (cost 1))
(edge (from "Orlando") (to "Tampa") (cost 1))
(edge (from "Tampa") (to "Orlando") (cost 1))
(edge (from "Orlando") (to "West Palm") (cost 3))
(edge (from "West Palm") (to "Orlando") (cost 3))
(edge (from "St. Augustine") (to "West Palm") (cost 3))
(edge (from "West Palm") (to "St. Augustine") (cost 3))
(edge (from "Ocala") (to "Tampa") (cost 2))
(edge (from "Tampa") (to "Ocala") (cost 2))
(edge (from "Tampa") (to "Ft.Myers") (cost 2))
(edge (from "Ft.Myers") (to "Tampa") (cost 2))
(edge (from "Ft.Myers") (to "West Palm") (cost 3))
(edge (from "West Palm") (to "Ft.Myers") (cost 3))
(edge (from "West Palm") (to "Miami") (cost 2))
(edge (from "Miami") (to "West Palm") (cost 2))
(edge (from "Miami") (to "Key West") (cost 3))
(edge (from "Key West") (to "Miami") (cost 3))

(cost-from "Key West" "Key West" 0)
(cost-from "Miami" "Miami" 0)
(cost-from "Ft. Myers" "Ft. Myers" 0)
(cost-from "West Palm" "West Palm" 0)
(cost-from "Tampa" "Tampa" 0)
(cost-from "Ocala" "Ocala" 0)
(cost-from "St. Augustine" "St. Augustine" 0)
(cost-from "Gainesville" "Gainesville" 0)
(cost-from "Jacksonville" "Jacksonville" 0)
(cost-from "Lake City" "Lake City" 0)
(cost-from "Tallahassee" "Tallahassee" 0)

(truck (number 1) (current-location "Orlando") (destination NIL) (available-space 15) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0)
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0) (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))
(truck (number 2) (current-location "Orlando") (destination NIL) (available-space 5) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0)
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0)  (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))
(truck (number 3) (current-location "Orlando") (destination NIL) (available-space 5) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0)
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0)  (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))
(truck (number 4) (current-location "Orlando") (destination NIL) (available-space 10) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0) 
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0) (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))
(truck (number 5) (current-location "Orlando") (destination NIL) (available-space 15) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0) 
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0)  (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))
(truck (number 6) (current-location "Orlando") (destination NIL) (available-space 10) (event-time 0) (return-time 0) (busy-time 0) (space-occupied 0) 
(total-travel-time 0) (total-time-of-delivery 0) (non-del-time 0) (del-time 0) (action idle) (wait-time 0)  (packages-carrying 0) (package-number NIL))

(package (number 1) (depart-city "Orlando") (delivery-city "Jacksonville") (size 4) (wait-time 0)  (location arrival) (event-time 1) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 1) (expect-time-of-delivery 15))
(package (number 2) (depart-city "Gainesville") (delivery-city "Jacksonville") (size 1) (wait-time 0)  (location arrival) (event-time 1) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 1) (expect-time-of-delivery 15))
(package (number 3) (depart-city "West Palm") (delivery-city "St. Augustine") (size 3) (wait-time 0)  (location arrival) (event-time 4) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 4) (expect-time-of-delivery 10))
(package (number 4) (depart-city "Key West") (delivery-city "St. Augustine") (size 4) (wait-time 0)  (location arrival) (event-time 4) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 4) (expect-time-of-delivery 10))
(package (number 5) (depart-city "Gainesville") (delivery-city "Tallahassee") (size 9) (wait-time 0)  (location arrival) (event-time 5) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 5) (expect-time-of-delivery 10))
(package (number 6) (depart-city "Jacksonville") (delivery-city "Orlando") (size 10) (wait-time 0)  (location arrival) (event-time 8) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 8) (expect-time-of-delivery 18))
(package (number 7) (depart-city "Jacksonville") (delivery-city "Miami") (size 5) (wait-time 0)  (location arrival) (event-time 8) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 8) (expect-time-of-delivery 25))
(package (number 8) (depart-city "Ft.Myers") (delivery-city "Key West") (size 4) (wait-time 0)  (location arrival) (event-time 9) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 9) (expect-time-of-delivery 20))
(package (number 9) (depart-city "Orlando") (delivery-city "Key West") (size 4) (wait-time 0)  (location arrival) (event-time 9) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 9) (expect-time-of-delivery 22))
(package (number 10) (depart-city "West Palm") (delivery-city "Miami") (size 2) (wait-time 0)  (location arrival) (event-time 9) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 9) (expect-time-of-delivery 16))
(package (number 11) (depart-city "Miami") (delivery-city "Ocala") (size 4) (wait-time 0)  (location arrival) (event-time 10) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 10) (expect-time-of-delivery 20))
(package (number 12) (depart-city "Gainesville") (delivery-city "Orlando") (size 7) (wait-time 0)  (location arrival) (event-time 11) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 11) (expect-time-of-delivery 17))
(package (number 13) (depart-city "Tampa") (delivery-city "Tallahassee") (size 12) (wait-time 0) (location arrival) (event-time 12) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 12) (expect-time-of-delivery 25))
(package (number 14) (depart-city "Miami") (delivery-city "Orlando") (size 5) (wait-time 0) (location arrival) (event-time 20) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 20) (expect-time-of-delivery 30))
(package (number 15) (depart-city "Ocala") (delivery-city "Orlando") (size 7) (wait-time 0) (location arrival) (event-time 30) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 30) (expect-time-of-delivery 40))
(package (number 16) (depart-city "Orlando") (delivery-city "Lake City") (size 6) (wait-time 0) (location arrival) (event-time 40) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 40) (expect-time-of-delivery 45))
(package (number 17) (depart-city "Jacksonville") (delivery-city "Tallahassee") (size 5) (wait-time 0) (location arrival) (event-time 65) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 65) (expect-time-of-delivery 80))
(package (number 18) (depart-city "Tallahassee") (delivery-city "Gainesville") (size 8) (wait-time 0) (location arrival) (event-time 80) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 80) (expect-time-of-delivery 100))
(package (number 19) (depart-city "St. Augustine") (delivery-city "Tallahassee") (size 5) (wait-time 0) (location arrival) (event-time 90) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 90) (expect-time-of-delivery 110))
(package (number 20) (depart-city "West Palm") (delivery-city "Ft. Myers") (size 4) (wait-time 0) (location arrival) (event-time 110) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 110) (expect-time-of-delivery 120))
(package (number 21) (depart-city "St. Augustine") (delivery-city "Ft.Myers") (size 7) (wait-time 0)  (location arrival) (event-time 110) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 110) (expect-time-of-delivery 120))
(package (number 22) (depart-city "Jacksonville") (delivery-city "Key West") (size 2) (wait-time 0)  (location arrival) (event-time 120) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 120) (expect-time-of-delivery 150))
(package (number 23) (depart-city "Miami") (delivery-city "Key West") (size 4) (wait-time 0) (location arrival) (event-time 150) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 150) (expect-time-of-delivery 155))
(package (number 24) (depart-city "Miami") (delivery-city "Gainesville") (size 5) (wait-time 0) (location arrival) (event-time 150) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 150) (expect-time-of-delivery 165))
(package (number 25) (depart-city "Miami") (delivery-city "Tallahassee") (size 5) (wait-time 0) (location arrival) (event-time 150) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 150) (expect-time-of-delivery 170))
(package (number 26) (depart-city "Tallahassee") (delivery-city "Lake City") (size 8) (wait-time 0) (location arrival) (event-time 180) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 180) (expect-time-of-delivery 200))
(package (number 27) (depart-city "Lake City") (delivery-city "Tallahassee") (size 7) (wait-time 0) (location arrival) (event-time 190) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 190) (expect-time-of-delivery 200))
(package (number 28) (depart-city "Tallahassee") (delivery-city "Key West") (size 12) (wait-time 0) (location arrival) (event-time 200) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 200) (expect-time-of-delivery 250))
(package (number 29) (depart-city "St. Augustine") (delivery-city "Key West") (size 3) (wait-time 0) (location arrival) (event-time 200) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 200) (expect-time-of-delivery 260))
(package (number 30) (depart-city "Tampa") (delivery-city "Jacksonville") (size 9) (wait-time 0) (location arrival) (event-time 210) (time-of-pick-up 0) (time-of-delivery 0) (delivery-delayed-by 0) (status-at-delivery ON-TIME) (order-arrival-time 210) (expect-time-of-delivery 240))




(current-time 0)
(Packages-Delivered-Late 0)
(total-late-time-of-delivery 0)
(total-no-packages 0))

(deffacts counter-1				
(Number-of-Packages-Delivered(Packages-Delivered 0)))	

(deffacts Truck-Counter
(Number-of-Trucks-at-Orlando (Trucks-at-Orlando 6)))	


(deffacts Package-wait-time-Counter
(Total-Wait-Time (Package-Total-Wait-time 0)))




