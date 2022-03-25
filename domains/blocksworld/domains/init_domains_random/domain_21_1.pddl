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
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
		:effect (and
			(on ?x ?y)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (clear ?y), (handempty), (ontable ?y), (on ?y ?x), (clear ?x), (holding ?y), (on ?x ?y), (handempty), (on ?x ?y), (clear ?y), (on ?y ?x), 
;; pick-up action has changed: (holding ?x), (handempty), 
;; stack action has changed: (holding ?x), (ontable ?x), (clear ?y), (ontable ?x), 
;; put-down action has changed: (ontable ?x), (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
