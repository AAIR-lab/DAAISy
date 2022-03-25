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
			(not (at_robby ?from))
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(at ?obj ?room)
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (not (at_robby ?room))
			(free ?gripper)
			(at ?obj ?room)
			(carry ?obj ?gripper)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(free ?gripper)
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (at_robby ?room)
			(carry ?obj ?gripper)
			
        )
    )
)

;; 
;; drop action has changed: (carry ?obj ?gripper), (free ?gripper), (free ?gripper), (at ?obj ?room), (carry ?obj ?gripper), (at_robby ?room), 
;; pick action has changed: (free ?gripper), (carry ?obj ?gripper), (free ?gripper), (at ?obj ?room), (at_robby ?room), 
;; move action has changed: (at_robby ?from), (at_robby ?to), 
;; Last_reduced_capability_num_dropped_pals: None


