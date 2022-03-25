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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?x))
			
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
			(ontable ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(ontable ?y)
			(not (on ?y ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			
		)
   )
)


;; 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (holding ?x), (handempty), (holding ?x), 
;; stack action has changed: (ontable ?y), (on ?x ?y), (holding ?x), (clear ?x), (holding ?y), (holding ?y), (ontable ?x), (handempty), (clear ?x), (clear ?y), (on ?y ?x), (ontable ?y), (ontable ?x), 
;; pick-up action has changed: (handempty), (holding ?x), (ontable ?x), (holding ?x), (ontable ?x), 
;; unstack action has changed: (clear ?y), (clear ?y), (ontable ?y), (holding ?y), (clear ?x), (on ?y ?x), (on ?x ?y), (ontable ?y), (handempty), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
