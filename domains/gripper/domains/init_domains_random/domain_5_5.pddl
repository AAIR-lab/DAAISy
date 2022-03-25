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
            (at_robby ?to)
			(not (at_robby ?from))
			
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
			(carry ?obj ?gripper)
			
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
            (free ?gripper)
			(at ?obj ?room)
			
        )
    )
)

;; 
;; move action has changed: (at_robby ?from), (at_robby ?from), (at_robby ?to), 
;; pick action has changed: (carry ?obj ?gripper), 
;; drop action has changed: (carry ?obj ?gripper), 
;; Last_reduced_capability_num_dropped_pals: None



