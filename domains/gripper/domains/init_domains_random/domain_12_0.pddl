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
		    (not (at_robby ?to))
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(free ?gripper)
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (free ?gripper)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (not (at ?obj ?room))
			
        )
    )
)

;; 
;; pick action has changed: (carry ?obj ?gripper), (at ?obj ?room), (at ?obj ?room), (carry ?obj ?gripper), (free ?gripper), 
;; move action has changed: (at_robby ?from), (at_robby ?to), (at_robby ?to), 
;; drop action has changed: (free ?gripper), (at ?obj ?room), (carry ?obj ?gripper), (carry ?obj ?gripper), 
;; Last_reduced_capability_num_dropped_pals: None



