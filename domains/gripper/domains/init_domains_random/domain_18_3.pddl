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
			
       )
       :effect (and  
		    (at_robby ?from)
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (not (at_robby ?room))
			(free ?gripper)
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (at_robby ?room)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (free ?gripper)
			(not (at ?obj ?room))
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (not (at_robby ?room))
			(not (at ?obj ?room))
			(not (carry ?obj ?gripper))
			
        )
    )
)

;; 
;; drop action has changed: (carry ?obj ?gripper), (free ?gripper), (at_robby ?room), (free ?gripper), (at ?obj ?room), (at_robby ?room), (at ?obj ?room), 
;; move action has changed: (at_robby ?from), (at_robby ?to), (at_robby ?to), (at_robby ?from), 
;; pick action has changed: (carry ?obj ?gripper), (free ?gripper), (carry ?obj ?gripper), (at_robby ?room), (at ?obj ?room), (at_robby ?room), (at ?obj ?room), 
;; Last_reduced_capability_num_dropped_pals: None


