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
			(holding ?x)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(clear ?x)
			(holding ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(handempty)
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (handempty), 
;; unstack action has changed: (handempty), (handempty), (on ?x ?y), (clear ?x), 
;; stack action has changed: (handempty), (clear ?x), (on ?y ?x), (ontable ?y), 
;; put-down action has changed: (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
