(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holding ?x - block)
  )

  (:action pick-up
		:parameters (?x - block)
		:precondition (and
			%PICK-UP PRECONDITION%
		)
		:effect (and
			%PICK-UP EFFECTS%
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			%PUT-DOWN PRECONDITION%
		)
		:effect (and
			%PUT-DOWN EFFECTS%
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			%STACK PRECONDITION%
		)
		:effect (and
			%STACK EFFECTS%
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			%UNSTACK PRECONDITION%
		)
		:effect (and
			%UNSTACK EFFECTS%
		)
   )
)


;; %INFO_STRING%