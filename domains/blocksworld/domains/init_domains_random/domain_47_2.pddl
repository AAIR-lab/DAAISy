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
			(not (holding ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
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
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (ontable ?y))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; pick-up action has changed: (handempty), (ontable ?x), (handempty), (ontable ?x), (holding ?x), (clear ?x), (holding ?x), (clear ?x), 
;; put-down action has changed: (holding ?x), (ontable ?x), (clear ?x), (holding ?x), (handempty), (ontable ?x), (clear ?x), 
;; stack action has changed: (clear ?x), (clear ?y), (ontable ?y), (clear ?y), (ontable ?x), (handempty), (holding ?x), (on ?y ?x), (on ?x ?y), (on ?y ?x), (holding ?x), (holding ?y), (holding ?y), (clear ?x), (ontable ?y), (ontable ?x), 
;; unstack action has changed: (holding ?y), (ontable ?y), (clear ?x), (holding ?y), (handempty), (clear ?y), (holding ?x), (ontable ?y), (on ?y ?x), (holding ?x), (clear ?y), (clear ?x), (on ?x ?y), (ontable ?x), (ontable ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
