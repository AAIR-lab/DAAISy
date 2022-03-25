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
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?x)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?y), (clear ?y), (holding ?x), (ontable ?x), (holding ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), 
;; stack action has changed: (holding ?x), (on ?x ?y), (clear ?y), (on ?y ?x), (clear ?x), (holding ?x), 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; put-down action has changed: (holding ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
