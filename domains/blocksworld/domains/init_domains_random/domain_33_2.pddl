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
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(ontable ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?y), (ontable ?y), (holding ?x), (holding ?y), (on ?y ?x), (holding ?x), (on ?x ?y), (ontable ?y), (ontable ?x), (ontable ?x), (holding ?y), (handempty), (handempty), (clear ?y), 
;; stack action has changed: (holding ?y), (on ?x ?y), (handempty), (ontable ?y), (holding ?y), (handempty), (ontable ?y), (holding ?x), (on ?y ?x), (clear ?x), (ontable ?x), 
;; put-down action has changed: (handempty), (clear ?x), (holding ?x), (handempty), (clear ?x), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
