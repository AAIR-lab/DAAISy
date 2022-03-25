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
			(not (holding ?x))
			
		)
		:effect (and
			(not (clear ?y))
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
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (ontable ?y), 
;; stack action has changed: (on ?y ?x), (holding ?x), 
;; put-down action has changed: (holding ?x), 
;; pick-up action has changed: (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
