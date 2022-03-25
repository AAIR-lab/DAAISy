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
			(not (holding ?x))
			
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
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?x)
			(holding ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (on ?x ?y), (holding ?y), (clear ?x), (ontable ?y), (clear ?y), (ontable ?x), (handempty), 
;; unstack action has changed: (clear ?y), (ontable ?x), (clear ?x), (handempty), (on ?y ?x), (holding ?y), (ontable ?y), (holding ?x), (on ?x ?y), (handempty), (ontable ?y), (holding ?y), (clear ?y), (clear ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (clear ?x), (holding ?x), (holding ?x), (handempty), 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), (clear ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
