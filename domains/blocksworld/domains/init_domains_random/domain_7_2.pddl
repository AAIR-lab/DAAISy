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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (on ?y ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (clear ?x), 
;; stack action has changed: (handempty), (handempty), 
;; unstack action has changed: (on ?x ?y), (on ?y ?x), 
;; put-down action has changed: (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
