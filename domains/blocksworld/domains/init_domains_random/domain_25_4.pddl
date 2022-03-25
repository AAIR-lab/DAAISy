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
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
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
;; put-down action has changed: (handempty), (clear ?x), (ontable ?x), (clear ?x), 
;; stack action has changed: (ontable ?y), (clear ?x), (holding ?y), (on ?x ?y), (clear ?x), (holding ?x), (on ?x ?y), (ontable ?x), (clear ?y), 
;; unstack action has changed: (clear ?y), (clear ?y), (holding ?y), (ontable ?y), (clear ?x), (on ?y ?x), (ontable ?y), (on ?x ?y), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (handempty), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None