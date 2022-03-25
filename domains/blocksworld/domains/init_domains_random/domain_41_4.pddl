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
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (clear ?x))
			(handempty)
			
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
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (ontable ?x), (on ?y ?x), (holding ?y), (ontable ?y), (clear ?x), (clear ?y), (ontable ?x), (on ?y ?x), (holding ?x), (on ?x ?y), (holding ?x), (clear ?y), (holding ?y), 
;; stack action has changed: (holding ?x), (ontable ?y), (handempty), (on ?y ?x), (holding ?x), (ontable ?y), (ontable ?x), (holding ?y), (on ?x ?y), (handempty), (holding ?y), (clear ?x), 
;; put-down action has changed: (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (clear ?x), (ontable ?x), (handempty), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (handempty), (holding ?x), (ontable ?x), (holding ?x), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
