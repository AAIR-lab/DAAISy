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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			
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
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (clear ?x), (holding ?x), 
;; unstack action has changed: (clear ?x), (holding ?y), (on ?y ?x), (holding ?x), (handempty), (holding ?x), (handempty), (ontable ?y), (clear ?y), 
;; stack action has changed: (ontable ?x), (holding ?y), (ontable ?y), (clear ?x), (holding ?x), 
;; put-down action has changed: (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
