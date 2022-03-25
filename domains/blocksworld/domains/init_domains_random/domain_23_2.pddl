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
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			
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
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (clear ?x), (holding ?x), (handempty), (handempty), (ontable ?x), (on ?y ?x), (clear ?y), (clear ?y), 
;; put-down action has changed: (holding ?x), 
;; stack action has changed: (ontable ?x), (holding ?x), (on ?x ?y), (ontable ?x), (clear ?x), (ontable ?y), (on ?y ?x), (handempty), (on ?x ?y), (holding ?y), (clear ?x), 
;; pick-up action has changed: (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
