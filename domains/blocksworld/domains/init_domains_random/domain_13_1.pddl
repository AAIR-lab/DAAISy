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
			(not (ontable ?x))
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
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(holding ?x)
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(on ?y ?x)
			(handempty)
			
		)
   )
)


;; 
;; put-down action has changed: (ontable ?x), (ontable ?x), (holding ?x), 
;; stack action has changed: (on ?y ?x), (holding ?y), (holding ?y), (clear ?x), 
;; unstack action has changed: (clear ?y), (ontable ?x), (handempty), (clear ?y), (on ?y ?x), 
;; pick-up action has changed: (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
