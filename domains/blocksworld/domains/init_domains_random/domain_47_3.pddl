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
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
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
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
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
;; stack action has changed: (on ?x ?y), (on ?x ?y), (holding ?x), (on ?y ?x), (clear ?y), (clear ?y), (on ?y ?x), (ontable ?y), (ontable ?y), (clear ?x), (ontable ?x), (clear ?x), (holding ?y), (holding ?y), (holding ?x), (handempty), (ontable ?x), 
;; unstack action has changed: (holding ?y), (clear ?x), (on ?y ?x), (ontable ?x), (on ?x ?y), (ontable ?y), (ontable ?x), (clear ?y), (handempty), (holding ?y), (holding ?x), (clear ?x), (on ?x ?y), (handempty), (holding ?x), (on ?y ?x), 
;; put-down action has changed: (ontable ?x), (holding ?x), (clear ?x), (handempty), (holding ?x), (handempty), (ontable ?x), 
;; pick-up action has changed: (clear ?x), (holding ?x), (handempty), (holding ?x), (handempty), (clear ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
