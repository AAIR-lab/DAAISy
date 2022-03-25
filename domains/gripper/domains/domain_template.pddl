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
            %MOVE PRECONDITION%
       )
       :effect (and  
		    %MOVE EFFECTS%
        )
    )

   (:action pick
       :parameters (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            %PICK PRECONDITION%
        )
       :effect (and 
            %PICK EFFECTS%
        )
    )

   (:action drop
       :parameters  (?obj - ball ?room - room ?gripper - gripper)
       :precondition  (and  
            %DROP PRECONDITION%
        )
       :effect (and 
            %DROP EFFECTS%
        )
    )
)

;; %INFO_STRING%


