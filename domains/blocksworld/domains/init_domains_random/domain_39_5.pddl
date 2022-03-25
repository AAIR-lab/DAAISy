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
			(not (holding ?x))
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (on ?y ?x), (clear ?x), (holding ?x), (clear ?x), (clear ?y), (holding ?y), (ontable ?y), (ontable ?x), (holding ?y), (holding ?x), (ontable ?x), (clear ?y), (handempty), (ontable ?y), 
;; stack action has changed: (clear ?y), (on ?y ?x), (ontable ?x), (on ?y ?x), (holding ?y), (holding ?y), (handempty), (clear ?y), (holding ?x), (on ?x ?y), (ontable ?y), (ontable ?y), 
;; pick-up action has changed: (holding ?x), (handempty), (ontable ?x), (handempty), (ontable ?x), (clear ?x), (holding ?x), 
;; put-down action has changed: (handempty), (ontable ?x), (clear ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
