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
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(holding ?x)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (clear ?x))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (clear ?x), (holding ?x), (holding ?x), 
;; unstack action has changed: (clear ?x), (clear ?y), (handempty), (holding ?y), (ontable ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (on ?y ?x), (holding ?x), (holding ?y), (holding ?x), (clear ?y), 
;; stack action has changed: (ontable ?x), (clear ?x), (holding ?x), (on ?x ?y), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
