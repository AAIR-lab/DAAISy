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
            (at_robby ?from)
			
       )
       :effect (and  
		    (at_robby ?to)
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(free ?gripper)
			(at ?obj ?room)
			
        )
       :effect (and 
            (not (free ?gripper))
			(not (at ?obj ?room))
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
            (not (free ?gripper))
			(not (carry ?obj ?gripper))
			
        )
    )
)

;; 
;; drop action has changed: (at ?obj ?room), (free ?gripper), 
;; move action has changed: (at_robby ?from), 
;; Last_reduced_capability_num_dropped_pals: None



