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
            (not (at_robby ?room))
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (at ?obj ?room)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (free ?gripper)
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (free ?gripper)
			(not (at ?obj ?room))
			(not (carry ?obj ?gripper))
			
        )
    )
)

;; 
;; pick action has changed: (carry ?obj ?gripper), (at ?obj ?room), (at ?obj ?room), (carry ?obj ?gripper), (free ?gripper), (free ?gripper), (at_robby ?room), 
;; move action has changed: (at_robby ?from), 
;; drop action has changed: (at ?obj ?room), (free ?gripper), (at_robby ?room), 
;; Last_reduced_capability_num_dropped_pals: None


