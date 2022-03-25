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
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; stack action has changed: (ontable ?y), (clear ?y), (handempty), 
;; unstack action has changed: (ontable ?y), (handempty), (holding ?y), 
;; put-down action has changed: (handempty), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
