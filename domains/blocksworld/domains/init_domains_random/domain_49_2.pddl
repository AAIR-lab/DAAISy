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
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (clear ?x))
			(handempty)
			
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
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (on ?x ?y), (handempty), (holding ?y), (handempty), (holding ?x), (on ?x ?y), (ontable ?y), (holding ?x), (ontable ?x), (holding ?y), (clear ?y), (ontable ?y), (on ?y ?x), (clear ?x), (on ?y ?x), (clear ?y), 
;; unstack action has changed: (handempty), (holding ?x), (clear ?y), (on ?y ?x), (handempty), (holding ?y), (ontable ?y), (clear ?x), (ontable ?x), (on ?x ?y), (ontable ?y), (holding ?x), (ontable ?x), (holding ?y), (clear ?x), (on ?y ?x), (clear ?y), (on ?x ?y), 
;; put-down action has changed: (handempty), (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (clear ?x), (handempty), 
;; pick-up action has changed: (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
