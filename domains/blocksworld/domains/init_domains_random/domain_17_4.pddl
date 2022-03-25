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
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (holding ?x))
			
		)
		:effect (and
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (clear ?x), (ontable ?x), 
;; unstack action has changed: (holding ?x), (ontable ?x), (handempty), (clear ?y), (holding ?y), (clear ?x), (ontable ?y), 
;; stack action has changed: (holding ?y), (holding ?x), (clear ?y), (holding ?y), (on ?x ?y), 
;; pick-up action has changed: (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
