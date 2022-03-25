(define (domain gripper-typed)
   (:requirements :typing :equality)
   (:types room ball gripper)
   (:predicates (at_robby ?r - room)
		(at ?b - ball ?r - room)
		(free ?g - gripper)
		(carry ?o - ball ?g - gripper)
    )

   (:action move
       :parameters  (?from - room ?to - room)
       :precondition (and
            (not (at_robby ?to))
			(at_robby ?from)
			
       )
       :effect (and  
		    (at_robby ?to)
			(not (at_robby ?from))
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(free ?gripper)
			(at ?obj ?room)
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (not (free ?gripper))
			(carry ?obj ?gripper)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (at ?obj ?room)
			(not (carry ?obj ?gripper))
			
        )
    )
)

;; 
;; drop action has changed: (free ?gripper), 
;; pick action has changed: (at ?obj ?room), (carry ?obj ?gripper), 
;; move action has changed: (at_robby ?to), 
;; Last_reduced_capability_num_dropped_pals: None


