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
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
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
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(clear ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			
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
;; stack action has changed: (clear ?x), (holding ?x), (holding ?x), (clear ?y), (holding ?y), (clear ?y), 
;; unstack action has changed: (on ?y ?x), (ontable ?y), (ontable ?x), (holding ?x), (clear ?x), (holding ?x), (on ?x ?y), (handempty), 
;; pick-up action has changed: (clear ?x), (clear ?x), 
;; put-down action has changed: (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
