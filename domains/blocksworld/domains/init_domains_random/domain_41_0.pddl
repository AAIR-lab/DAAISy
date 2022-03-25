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
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(ontable ?y)
			(on ?y ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?x), (ontable ?y), (on ?x ?y), (handempty), (holding ?x), (on ?x ?y), (clear ?y), (holding ?y), (ontable ?y), (handempty), (ontable ?x), (holding ?y), (clear ?x), (on ?y ?x), (on ?y ?x), (clear ?x), 
;; stack action has changed: (ontable ?x), (on ?x ?y), (clear ?y), (handempty), (ontable ?y), (clear ?y), (clear ?x), (ontable ?y), (holding ?x), (ontable ?x), (holding ?y), (holding ?x), (handempty), (on ?y ?x), 
;; put-down action has changed: (clear ?x), (handempty), (ontable ?x), (handempty), (ontable ?x), 
;; pick-up action has changed: (handempty), (clear ?x), (clear ?x), (ontable ?x), (holding ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
