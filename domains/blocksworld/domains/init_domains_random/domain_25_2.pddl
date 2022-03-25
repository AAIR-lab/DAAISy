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
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), (handempty), (clear ?x), (holding ?x), 
;; stack action has changed: (holding ?y), (ontable ?y), (ontable ?y), (clear ?x), (clear ?y), (ontable ?x), (handempty), (on ?y ?x), 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (clear ?x), 
;; unstack action has changed: (clear ?y), (clear ?x), (ontable ?x), (holding ?y), (clear ?x), (clear ?y), 
;; Last_reduced_capability_num_dropped_pals: None
