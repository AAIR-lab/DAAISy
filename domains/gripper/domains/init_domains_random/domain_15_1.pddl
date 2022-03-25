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
		    (not (at_robby ?to))
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (not (at ?obj ?room))
			(not (carry ?obj ?gripper))
			
        )
       :effect (and 
            (not (at_robby ?room))
			(free ?gripper)
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(not (at ?obj ?room))
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (at_robby ?room)
			(free ?gripper)
			(not (at ?obj ?room))
			(not (carry ?obj ?gripper))
			
        )
    )
)

;; 
;; pick action has changed: (carry ?obj ?gripper), (at ?obj ?room), (at ?obj ?room), (free ?gripper), (at_robby ?room), (carry ?obj ?gripper), (at_robby ?room), (free ?gripper), 
;; move action has changed: (at_robby ?from), (at_robby ?to), (at_robby ?to), (at_robby ?from), 
;; drop action has changed: (at_robby ?room), (at ?obj ?room), (at ?obj ?room), 
;; Last_reduced_capability_num_dropped_pals: None



