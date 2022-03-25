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
			(not (holding ?x))
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
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?x ?y), (on ?x ?y), (on ?y ?x), (handempty), 
;; put-down action has changed: (handempty), (ontable ?x), 
;; stack action has changed: (on ?y ?x), (holding ?x), (on ?y ?x), (clear ?y), (holding ?y), (ontable ?x), 
;; pick-up action has changed: (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
