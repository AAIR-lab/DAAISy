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
			
       )
       :effect (and  
		    (at_robby ?to)
			(at_robby ?from)
			
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(free ?gripper)
			(not (at ?obj ?room))
			
        )
       :effect (and 
            (not (at ?obj ?room))
			
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            (at_robby ?room)
			(at ?obj ?room)
			(carry ?obj ?gripper)
			
        )
       :effect (and 
            (at ?obj ?room)
			(carry ?obj ?gripper)
			
        )
    )
)

;; 
;; drop action has changed: (at ?obj ?room), (carry ?obj ?gripper), (free ?gripper), 
;; move action has changed: (at_robby ?to), (at_robby ?from), (at_robby ?from), 
;; pick action has changed: (free ?gripper), (carry ?obj ?gripper), (at ?obj ?room), 
;; Last_reduced_capability_num_dropped_pals: None



