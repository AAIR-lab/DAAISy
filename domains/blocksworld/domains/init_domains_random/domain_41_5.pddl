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
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
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
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (clear ?x), (on ?y ?x), (clear ?y), (on ?x ?y), (ontable ?x), (holding ?y), (holding ?y), (on ?y ?x), (ontable ?y), (holding ?x), (on ?x ?y), (handempty), (ontable ?y), (holding ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), (clear ?x), 
;; unstack action has changed: (clear ?y), (handempty), (ontable ?x), (clear ?y), (holding ?x), (on ?y ?x), (holding ?y), (ontable ?x), (on ?y ?x), (clear ?x), (holding ?x), (ontable ?y), (holding ?y), (on ?x ?y), 
;; pick-up action has changed: (handempty), (clear ?x), (holding ?x), (ontable ?x), (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
