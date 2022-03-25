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
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
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
			(holding ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (handempty), (holding ?y), (holding ?y), (on ?x ?y), (on ?x ?y), (ontable ?x), (clear ?x), (on ?y ?x), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), (clear ?y), (ontable ?y), (on ?y ?x), (clear ?y), 
;; stack action has changed: (holding ?x), (holding ?y), (on ?x ?y), (holding ?x), (ontable ?x), (clear ?x), (clear ?y), (handempty), (ontable ?x), (ontable ?y), (clear ?x), (ontable ?y), (on ?y ?x), (on ?x ?y), (handempty), (on ?y ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (handempty), (holding ?x), (ontable ?x), (holding ?x), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (holding ?x), (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
