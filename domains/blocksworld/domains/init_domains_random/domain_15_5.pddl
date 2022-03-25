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
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			
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
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?x), (holding ?y), (ontable ?y), (on ?y ?x), (holding ?x), (ontable ?y), 
;; stack action has changed: (holding ?y), (holding ?y), (handempty), (clear ?y), (on ?y ?x), (holding ?x), (ontable ?y), 
;; pick-up action has changed: (handempty), 
;; put-down action has changed: (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
