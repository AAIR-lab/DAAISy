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
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(clear ?x)
			(on ?y ?x)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?x), (holding ?x), (handempty), (clear ?y), (clear ?x), 
;; stack action has changed: (clear ?x), (holding ?y), (holding ?y), (holding ?x), (handempty), (on ?y ?x), (clear ?y), 
;; pick-up action has changed: (clear ?x), (holding ?x), (handempty), (handempty), (holding ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
