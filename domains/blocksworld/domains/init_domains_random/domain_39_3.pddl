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
			(not (holding ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (ontable ?y))
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (holding ?x), (ontable ?x), (holding ?x), (on ?y ?x), (holding ?y), (clear ?y), (handempty), (on ?y ?x), (on ?x ?y), (clear ?x), (handempty), (holding ?y), (ontable ?x), 
;; unstack action has changed: (handempty), (ontable ?y), (clear ?y), (handempty), (on ?y ?x), (ontable ?x), (holding ?x), (ontable ?y), (on ?y ?x), (clear ?x), (clear ?x), (on ?x ?y), (clear ?y), (on ?x ?y), 
;; pick-up action has changed: (handempty), (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), (clear ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
