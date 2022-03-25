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
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (handempty), (clear ?y), (holding ?x), (holding ?y), (on ?y ?x), (ontable ?x), (holding ?x), (clear ?x), (clear ?y), (ontable ?y), (holding ?y), 
;; put-down action has changed: (ontable ?x), (holding ?x), (handempty), (holding ?x), (clear ?x), (ontable ?x), 
;; unstack action has changed: (clear ?x), (ontable ?x), (holding ?x), (clear ?y), (holding ?y), (ontable ?y), 
;; pick-up action has changed: (handempty), (holding ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
