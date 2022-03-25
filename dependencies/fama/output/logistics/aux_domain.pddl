(define (domain logistics)
 (:requirements :strips :typing)
 (:types object - None truck - vehicle airplane - vehicle package - physobj vehicle - physobj airport - place location - place city - object place - object physobj - object )
 (:predicates (at ?o1 - physobj ?o2 - place) (in ?o1 - package ?o2 - vehicle) (in-city ?o1 - place ?o2 - city))

 (:action load-truck
   :parameters (?o1 - package ?o2 - truck ?o3 - place)
   :precondition (and (at ?o2 ?o3)(at ?o1 ?o3))
   :effect (and (not (at ?o1 ?o3))(in ?o1 ?o2)))

 (:action load-airplane
   :parameters (?o1 - package ?o2 - airplane ?o3 - place)
   :precondition (and (at ?o1 ?o3)(at ?o2 ?o3))
   :effect (and (not (at ?o1 ?o3))(in ?o1 ?o2)))

 (:action unload-truck
   :parameters (?o1 - package ?o2 - truck ?o3 - place)
   :precondition (and (at ?o2 ?o3)(in ?o1 ?o2))
   :effect (and (not (in ?o1 ?o2))(at ?o1 ?o3)))

 (:action unload-airplane
   :parameters (?o1 - package ?o2 - airplane ?o3 - place)
   :precondition (and (in ?o1 ?o2)(at ?o2 ?o3))
   :effect (and (not (in ?o1 ?o2))(at ?o1 ?o3)))

 (:action drive-truck
   :parameters (?o1 - truck ?o2 - place ?o3 - place ?city - city)
   :precondition (and (at ?o1 ?o2)(in-city ?o2 ?city)(in-city ?o3 ?city))
   :effect (and (not (at ?o1 ?o2))(at ?o1 ?o3)))

 (:action fly-airplane
   :parameters (?o1 - airplane ?o2 - airport ?o3 - airport)
   :precondition (at ?o1 ?o2)
   :effect (and (not (at ?o1 ?o2))(at ?o1 ?o3)))

)