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
			(not (ontable ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
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
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (ontable ?x), 
;; stack action has changed: (ontable ?x), (on ?y ?x), 
;; unstack action has changed: (handempty), 
;; Last_reduced_capability_num_dropped_pals: None