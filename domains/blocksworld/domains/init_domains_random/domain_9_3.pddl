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
			(not (clear ?x))
			
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
			(handempty)
			
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
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (ontable ?y), (clear ?x), 
;; pick-up action has changed: (clear ?x), (handempty), 
;; unstack action has changed: (on ?x ?y), (clear ?y), 
;; put-down action has changed: (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
