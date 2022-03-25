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
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (clear ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(on ?y ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(holding ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?y ?x), (ontable ?x), (holding ?y), (clear ?x), (holding ?x), (ontable ?x), (clear ?y), (ontable ?y), (clear ?y), (clear ?x), (ontable ?y), (holding ?y), (handempty), (on ?x ?y), 
;; stack action has changed: (clear ?x), (clear ?x), (clear ?y), (ontable ?y), (holding ?y), (on ?y ?x), (ontable ?x), (holding ?y), (clear ?y), (holding ?x), (handempty), (handempty), (holding ?x), (on ?y ?x), 
;; pick-up action has changed: (handempty), (holding ?x), (holding ?x), (clear ?x), 
;; put-down action has changed: (handempty), (handempty), (ontable ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
