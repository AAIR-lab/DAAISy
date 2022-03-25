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
			(ontable ?x)
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
			(holding ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(not (clear ?x))
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
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (clear ?y), (ontable ?x), (clear ?x), 
;; unstack action has changed: (clear ?y), (holding ?x), (holding ?y), (handempty), 
;; pick-up action has changed: (handempty), (ontable ?x), 
;; put-down action has changed: (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
