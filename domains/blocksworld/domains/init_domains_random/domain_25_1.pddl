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
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
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
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (clear ?x))
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?y), (handempty), (holding ?y), (on ?x ?y), (holding ?x), (clear ?x), (ontable ?x), (on ?x ?y), (holding ?x), (ontable ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (ontable ?x), 
;; stack action has changed: (clear ?y), (holding ?x), (handempty), (holding ?y), (clear ?x), (clear ?x), (ontable ?x), (holding ?y), (ontable ?y), 
;; pick-up action has changed: (handempty), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
