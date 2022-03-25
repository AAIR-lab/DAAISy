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
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(holding ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?x), (on ?x ?y), (holding ?y), (ontable ?y), (on ?x ?y), (on ?y ?x), (on ?y ?x), (ontable ?x), (handempty), (holding ?x), (handempty), (ontable ?x), (clear ?y), (clear ?x), (holding ?y), 
;; stack action has changed: (on ?x ?y), (on ?y ?x), (ontable ?y), (holding ?y), (ontable ?y), (holding ?y), (handempty), (clear ?y), (holding ?x), (handempty), (ontable ?x), (clear ?x), (holding ?x), (on ?x ?y), (clear ?x), (clear ?y), (on ?y ?x), 
;; pick-up action has changed: (handempty), (handempty), (clear ?x), (clear ?x), (ontable ?x), (holding ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (holding ?x), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
