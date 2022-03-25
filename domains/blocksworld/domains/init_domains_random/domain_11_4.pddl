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
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (on ?x ?y), (ontable ?x), (ontable ?x), (clear ?x), (holding ?x), (holding ?x), (holding ?y), 
;; put-down action has changed: (handempty), 
;; unstack action has changed: (holding ?y), (clear ?x), (on ?x ?y), 
;; Last_reduced_capability_num_dropped_pals: None
