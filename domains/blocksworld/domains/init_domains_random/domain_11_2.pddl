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
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			
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
			(clear ?x)
			(holding ?x)
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
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
			(handempty)
			
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
;; stack action has changed: (on ?x ?y), (clear ?x), (clear ?y), (clear ?x), (clear ?y), (ontable ?x), 
;; unstack action has changed: (holding ?x), (on ?x ?y), 
;; pick-up action has changed: (clear ?x), 
;; put-down action has changed: (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
