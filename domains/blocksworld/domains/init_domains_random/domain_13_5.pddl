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
			(not (holding ?x))
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
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?y ?x), (ontable ?y), (ontable ?x), (on ?x ?y), (holding ?x), 
;; pick-up action has changed: (ontable ?x), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), 
;; put-down action has changed: (holding ?x), 
;; stack action has changed: (holding ?y), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
