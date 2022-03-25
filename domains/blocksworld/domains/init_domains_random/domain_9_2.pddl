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
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (handempty), 
;; unstack action has changed: (on ?x ?y), (on ?x ?y), (ontable ?y), (handempty), (holding ?y), (ontable ?y), (holding ?x), 
;; put-down action has changed: (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
