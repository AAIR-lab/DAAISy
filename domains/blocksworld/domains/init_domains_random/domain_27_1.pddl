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
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?x)
			(ontable ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (handempty), (handempty), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), 
;; pick-up action has changed: (holding ?x), (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; unstack action has changed: (clear ?x), (on ?x ?y), (ontable ?y), (clear ?x), (holding ?x), (holding ?x), (ontable ?x), (clear ?y), 
;; stack action has changed: (clear ?x), (on ?y ?x), (ontable ?y), (handempty), (holding ?y), (ontable ?y), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
