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
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
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
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
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
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
   )
)


;; 
;; pick-up action has changed: (handempty), (ontable ?x), (holding ?x), (handempty), (holding ?x), (clear ?x), (ontable ?x), (clear ?x), 
;; stack action has changed: (holding ?y), (holding ?x), (on ?y ?x), (ontable ?x), (clear ?y), (on ?x ?y), (ontable ?x), (holding ?x), (on ?x ?y), (ontable ?y), (handempty), (on ?y ?x), (handempty), (clear ?x), (clear ?y), (clear ?x), (holding ?y), (ontable ?y), 
;; unstack action has changed: (handempty), (handempty), (on ?y ?x), (ontable ?y), (holding ?y), (clear ?x), (clear ?y), (on ?y ?x), (on ?x ?y), (holding ?x), (on ?x ?y), (holding ?y), (ontable ?y), (ontable ?x), (holding ?x), (clear ?x), (clear ?y), 
;; put-down action has changed: (handempty), (holding ?x), (ontable ?x), (clear ?x), (clear ?x), (ontable ?x), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
