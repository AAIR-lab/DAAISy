(define (domain miconic)
  (:requirements :strips)
  (:types passenger floor )

(:predicates
(origin ?o1 - passenger ?o2 - floor)
;; entry of ?person is ?floor
;; inertia

(destin ?o1 - passenger ?o2 - floor)
;; exit of ?person is ?floor
;; inertia

(above ?o1 - floor  ?o2 - floor)
;; ?floor2 is located above of ?floor1

(boarded ?o1 - passenger)
;; true if ?person has boarded the lift

(served ?o1 - passenger)
;; true if ?person has alighted as her destination

(lift-at ?o1 - floor)
;; current position of the lift is at ?floor
)


;;stop and allow boarding

(:action board
  :parameters (?o1 - floor ?o2 - passenger)
  :precondition (and (lift-at ?o1) (origin ?o2 ?o1))
  :effect (boarded ?o2))

(:action depart
  :parameters (?o1 - floor ?o2 - passenger)
  :precondition (and (lift-at ?o1) (destin ?o2 ?o1)
		     (boarded ?o2))
  :effect (and (not (boarded ?o2))
	       (served ?o2)))
;;drive up

(:action up
  :parameters (?o1 - floor ?o2 - floor)
  :precondition (and (lift-at ?o1) (above ?o1 ?o2))
  :effect (and (lift-at ?o2) (not (lift-at ?o1))))


;;drive down

(:action down
  :parameters (?o1 - floor ?o2 - floor)
  :precondition (and (lift-at ?o1) (above ?o2 ?o1))
  :effect (and (lift-at ?o2) (not (lift-at ?o1))))
)



