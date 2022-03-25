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
			(not (holding ?x))
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
			(handempty)
			
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
			(clear ?y)
			(holding ?y)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (handempty), (on ?x ?y), (clear ?y), (holding ?x), (clear ?x), 
;; stack action has changed: (clear ?y), (holding ?y), (ontable ?x), (on ?y ?x), (holding ?x), (on ?y ?x), (holding ?y), 
;; put-down action has changed: (handempty), (handempty), 
;; pick-up action has changed: (clear ?x), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
