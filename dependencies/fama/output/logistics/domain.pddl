;; logistics domain Typed version.
;;
(define (domain logistics)
  (:requirements :strips :typing) 
  (:types truck
          airplane - vehicle
          package
          vehicle - physobj
          airport
          location - place
          city
          place 
          physobj - object)
  
  (:predicates 	(in-city ?o1 - place ?o2 - city)
		(at ?o1 - physobj ?o2 - place)
		(in ?o1 - package ?o2 - vehicle))
  
;; (:actions LOAD-TRUCK LOAD-AIRPLANE UNLOAD-TRUCK UNLOAD-AIRPLANE DRIVE-TRUCK)

(:action LOAD-TRUCK
   :parameters    (?o1 - package ?o2 - truck ?o3 - place)
   :precondition  (and (at ?o2 ?o3) (at ?o1 ?o3))
   :effect        (and (not (at ?o1 ?o3)) (in ?o1 ?o2)))

(:action LOAD-AIRPLANE
  :parameters   (?o1 - package ?o2 - airplane ?o3 - place)
  :precondition (and (at ?o1 ?o3) (at ?o2 ?o3))
  :effect       (and (not (at ?o1 ?o3)) (in ?o1 ?o2)))

(:action UNLOAD-TRUCK
  :parameters   (?o1 - package ?o2 - truck ?o3 - place)
  :precondition (and (at ?o2 ?o3) (in ?o1 ?o2))
  :effect       (and (not (in ?o1 ?o2)) (at ?o1 ?o3)))

(:action UNLOAD-AIRPLANE
  :parameters    (?o1 - package ?o2 - airplane ?o3 - place)
  :precondition  (and (in ?o1 ?o2) (at ?o2 ?o3))
  :effect        (and (not (in ?o1 ?o2)) (at ?o1 ?o3)))

(:action DRIVE-TRUCK
  :parameters (?o1 - truck ?o2 - place ?o3 - place ?city - city)
  :precondition
   (and (at ?o1 ?o2) (in-city ?o2 ?city) (in-city ?o3 ?city))
  :effect
   (and (not (at ?o1 ?o2)) (at ?o1 ?o3)))

(:action FLY-AIRPLANE
  :parameters (?o1 - airplane ?o2 - airport ?o3 - airport)
  :precondition
   (at ?o1 ?o2)
  :effect
   (and (not (at ?o1 ?o2)) (at ?o1 ?o3)))
)
