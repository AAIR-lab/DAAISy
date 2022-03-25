(define (domain miconic)
 (:requirements :strips)
 (:types object - None passenger - object floor - object )
 (:predicates (above ?o1 - floor ?o2 - floor) (boarded ?o1 - passenger) (destin ?o1 - passenger ?o2 - floor) (lift-at ?o1 - floor) (origin ?o1 - passenger ?o2 - floor) (served ?o1 - passenger))

 (:action board
   :parameters (?o1 - floor ?o2 - passenger)
   :precondition (and (lift-at ?o1)(origin ?o2 ?o1))
   :effect (and (boarded ?o2)))

 (:action depart
   :parameters (?o1 - floor ?o2 - passenger)
   :precondition (and (lift-at ?o1)(destin ?o2 ?o1)(boarded ?o2))
   :effect (and (not (boarded ?o2))(served ?o2)))

 (:action up
   :parameters (?o1 - floor ?o2 - floor)
   :precondition (and (lift-at ?o1)(above ?o1 ?o2))
   :effect (and (lift-at ?o2)(not (lift-at ?o1))))

 (:action down
   :parameters (?o1 - floor ?o2 - floor)
   :precondition (and (lift-at ?o1)(above ?o2 ?o1))
   :effect (and (lift-at ?o2)(not (lift-at ?o1))))

)