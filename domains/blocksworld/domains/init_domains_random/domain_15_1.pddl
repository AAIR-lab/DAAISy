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
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(holding ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?x), (on ?y ?x), (ontable ?y), (holding ?y), (clear ?y), (ontable ?y), 
;; stack action has changed: (on ?x ?y), (ontable ?x), (on ?y ?x), (handempty), (holding ?y), (clear ?y), 
;; put-down action has changed: (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
