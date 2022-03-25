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
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			
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
			(not (ontable ?x))
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?y), (clear ?y), (ontable ?x), (clear ?y), (on ?x ?y), (on ?y ?x), (holding ?x), (holding ?y), (clear ?x), (holding ?x), (holding ?y), (ontable ?x), (on ?x ?y), (ontable ?y), (on ?y ?x), (handempty), (handempty), 
;; put-down action has changed: (ontable ?x), (handempty), (holding ?x), (ontable ?x), (clear ?x), (clear ?x), (handempty), 
;; unstack action has changed: (on ?y ?x), (on ?x ?y), (handempty), (holding ?y), (holding ?y), (on ?x ?y), (clear ?x), (ontable ?y), (clear ?x), (clear ?y), (clear ?y), (ontable ?y), (on ?y ?x), (ontable ?x), (handempty), (ontable ?x), (holding ?x), 
;; pick-up action has changed: (ontable ?x), (ontable ?x), (handempty), (clear ?x), (holding ?x), (handempty), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
