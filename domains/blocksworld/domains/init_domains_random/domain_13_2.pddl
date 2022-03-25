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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?x), (ontable ?y), (clear ?x), (handempty), (holding ?y), 
;; pick-up action has changed: (ontable ?x), (ontable ?x), (handempty), 
;; stack action has changed: (holding ?y), (holding ?x), (on ?y ?x), (ontable ?y), 
;; put-down action has changed: (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
