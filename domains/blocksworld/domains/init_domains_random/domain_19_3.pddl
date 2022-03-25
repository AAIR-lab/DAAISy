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
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
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
			(not (holding ?y))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (holding ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (ontable ?x), (holding ?x), (clear ?x), (holding ?x), (holding ?y), (holding ?y), 
;; unstack action has changed: (handempty), (clear ?y), (ontable ?x), (holding ?x), (holding ?x), (on ?y ?x), (clear ?y), (holding ?y), (clear ?x), 
;; pick-up action has changed: (holding ?x), (ontable ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
