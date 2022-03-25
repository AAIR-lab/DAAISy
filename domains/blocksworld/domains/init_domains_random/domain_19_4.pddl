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
			(holding ?x)
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
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(clear ?x)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?x), (handempty), (holding ?y), (on ?y ?x), (on ?y ?x), (ontable ?x), (holding ?x), (holding ?x), 
;; stack action has changed: (ontable ?x), (on ?x ?y), (holding ?x), (handempty), (holding ?x), (on ?x ?y), (ontable ?x), (holding ?y), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
