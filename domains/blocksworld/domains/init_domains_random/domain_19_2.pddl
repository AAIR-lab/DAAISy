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
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(holding ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (on ?x ?y), (on ?x ?y), (clear ?x), (ontable ?x), 
;; unstack action has changed: (holding ?y), (ontable ?y), (on ?y ?x), (handempty), (ontable ?x), (clear ?x), (on ?x ?y), (ontable ?x), 
;; put-down action has changed: (clear ?x), (handempty), (holding ?x), (holding ?x), 
;; pick-up action has changed: (holding ?x), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
