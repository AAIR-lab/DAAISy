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
			(clear ?x)
			
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
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (ontable ?y))
			(not (on ?y ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (clear ?x), (holding ?x), (ontable ?x), (handempty), (handempty), (holding ?x), 
;; unstack action has changed: (clear ?x), (clear ?x), (holding ?y), (on ?y ?x), (holding ?x), (clear ?y), (ontable ?y), (ontable ?y), (ontable ?x), (ontable ?x), (on ?y ?x), (clear ?y), (handempty), (handempty), 
;; pick-up action has changed: (handempty), (holding ?x), (ontable ?x), (clear ?x), (holding ?x), (handempty), (ontable ?x), 
;; stack action has changed: (handempty), (clear ?x), (on ?y ?x), (ontable ?y), (ontable ?x), (on ?x ?y), (ontable ?y), (clear ?x), (clear ?y), (holding ?y), (holding ?y), (holding ?x), (handempty), (holding ?x), (clear ?y), 
;; Last_reduced_capability_num_dropped_pals: None
