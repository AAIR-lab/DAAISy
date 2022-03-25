(define (domain miconic)
  (:requirements :strips)
  (:types passenger - object
          floor - object
         )

(:predicates 
(origin ?person - passenger ?floor - floor)
;; entry of ?person is ?floor
;; inertia

(destin ?person - passenger ?floor - floor)
;; exit of ?person is ?floor
;; inertia

(above ?floor1 - floor  ?floor2 - floor)
;; ?floor2 is located above of ?floor1

(boarded ?person - passenger)
;; true if ?person has boarded the lift

;(not_boarded ?person - passenger)
;; true if ?person has not boarded the lift

(served ?person - passenger)
;; true if ?person has alighted as her destination

;(not_served ?person - passenger)
;; true if ?person is not at their destination

(lift_at ?floor - floor)
;; current position of the lift is at ?floor
)


;;stop and allow boarding
(:action board
  :parameters (?floor - floor ?passenger - passenger)
  :precondition (and 
    (boarded ?passenger)
			(not (origin ?passenger ?floor))
			(destin ?passenger ?floor)
			
  )
  :effect (and 
   (not (lift_at ?floor))
			(boarded ?passenger)
			(not (origin ?passenger ?floor))
			(destin ?passenger ?floor)
			(served ?passenger)
			
  )
)

;;depart
(:action depart
  :parameters (?floor - floor ?passenger - passenger)
  :precondition (and 
    (not (origin ?passenger ?floor))
			(not (destin ?passenger ?floor))
			(not (served ?passenger))
			
  )
  :effect (and 
    (not (boarded ?passenger))
			(origin ?passenger ?floor)
			(not (destin ?passenger ?floor))
			(served ?passenger)
			
  )
)

;;drive up
(:action up
  :parameters (?floor1 - floor ?floor2 - floor)
  :precondition (and 
    (not (lift_at ?floor1))
			
  )
  :effect (and 
    (above ?floor1 ?floor2)
			(not (lift_at ?floor1))
			(above ?floor2 ?floor1)
			
  )
)

;;drive down
(:action down
  :parameters (?floor1 - floor ?floor2 - floor)
  :precondition (and 
    (lift_at ?floor1)
			
  )
  :effect (and 
    (above ?floor1 ?floor2)
			(lift_at ?floor1)
			(not (lift_at ?floor2))
			
  )
)
)

;; 
;; board action has changed: (origin ?passenger ?floor), (served ?passenger), (boarded ?passenger), (lift_at ?floor), (lift_at ?floor), (destin ?passenger ?floor), (origin ?passenger ?floor), (destin ?passenger ?floor), 
;; up action has changed: (lift_at ?floor1), (lift_at ?floor2), (above ?floor1 ?floor2), (above ?floor2 ?floor1), (above ?floor2 ?floor1), 
;; depart action has changed: (served ?passenger), (boarded ?passenger), (destin ?passenger ?floor), (origin ?passenger ?floor), (origin ?passenger ?floor), (destin ?passenger ?floor), (lift_at ?floor), 
;; down action has changed: (lift_at ?floor2), (lift_at ?floor1), (above ?floor1 ?floor2), (above ?floor1 ?floor2), 
;; Last_reduced_capability_num_dropped_pals: None



