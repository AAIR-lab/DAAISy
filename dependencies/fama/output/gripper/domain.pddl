(define (domain gripper)
   (:requirements :typing)
   (:types room ball gripper)
   (:predicates (at-robby ?o1 - room)
		(at ?o1 - ball ?o2 - room)
		(free ?o1 - gripper)
		(carry ?o1 - ball ?o2 - gripper))

   (:action move
       :parameters  (?o1 - room ?o2 - room)
       :precondition (at-robby ?o1)
       :effect (and  (at-robby ?o2)
		     (not (at-robby ?o1))))



   (:action pick
       :parameters (?o1 - ball ?o2 - room ?o3 - gripper)
       :precondition  (and  (at ?o1 ?o2) (at-robby ?o2) (free ?o3))
       :effect (and (carry ?o1 ?o3)
		    (not (at ?o1 ?o2)) 
		    (not (free ?o3))))


   (:action drop
       :parameters  (?o1 - ball ?o2 - room ?o3 - gripper)
       :precondition  (and  (carry ?o1 ?o3) (at-robby ?o2))
       :effect (and (at ?o1 ?o2)
		    (free ?o3)
		    (not (carry ?o1 ?o3)))))



