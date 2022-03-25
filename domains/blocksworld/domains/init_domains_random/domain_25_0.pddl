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
			(not (handempty))
			
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
			(not (clear ?x))
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?x)
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(clear ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(ontable ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (handempty), (on ?x ?y), (holding ?y), (holding ?y), (clear ?x), (holding ?x), (clear ?y), (ontable ?x), (ontable ?y), 
;; stack action has changed: (clear ?y), (holding ?x), (clear ?y), (on ?x ?y), (holding ?y), (ontable ?x), 
;; put-down action has changed: (clear ?x), (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
