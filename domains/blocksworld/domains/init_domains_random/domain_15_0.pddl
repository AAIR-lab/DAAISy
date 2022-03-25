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
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(holding ?x)
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (handempty), (on ?y ?x), (clear ?y), (ontable ?x), (holding ?x), 
;; stack action has changed: (holding ?y), (clear ?x), (clear ?y), (on ?x ?y), (ontable ?y), 
;; put-down action has changed: (clear ?x), (ontable ?x), (holding ?x), (handempty), 
;; pick-up action has changed: (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
