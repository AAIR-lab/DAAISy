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
			(not (holding ?x))
			(not (clear ?x))
			
		)
		:effect (and
			(not (clear ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(ontable ?y)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; stack action has changed: (holding ?x), (on ?x ?y), (ontable ?y), (ontable ?x), (handempty), (on ?y ?x), (holding ?x), (clear ?x), (clear ?y), (on ?x ?y), (clear ?y), (handempty), (clear ?x), 
;; put-down action has changed: (clear ?x), (holding ?x), (ontable ?x), (ontable ?x), (handempty), (clear ?x), 
;; pick-up action has changed: (holding ?x), (handempty), (ontable ?x), (handempty), (clear ?x), (holding ?x), 
;; unstack action has changed: (handempty), (clear ?x), (on ?y ?x), (on ?x ?y), (clear ?y), (holding ?y), (holding ?y), (holding ?x), (handempty), (ontable ?x), (holding ?x), (ontable ?y), (clear ?x), (ontable ?y), 
;; Last_reduced_capability_num_dropped_pals: None
