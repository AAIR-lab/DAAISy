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
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(not (on ?y ?x))
			
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
			(on ?x ?y)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?x), (clear ?x), 
;; put-down action has changed: (clear ?x), 
;; pick-up action has changed: (clear ?x), 
;; stack action has changed: (on ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None
