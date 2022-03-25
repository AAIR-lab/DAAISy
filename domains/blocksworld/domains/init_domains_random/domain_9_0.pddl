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
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (handempty), (clear ?x), 
;; unstack action has changed: (clear ?y), (holding ?y), (on ?x ?y), (clear ?y), (handempty), 
;; put-down action has changed: (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
