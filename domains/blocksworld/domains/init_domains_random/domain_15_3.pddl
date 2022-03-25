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
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (ontable ?y), (holding ?x), (clear ?y), (on ?x ?y), (ontable ?x), (handempty), 
;; unstack action has changed: (handempty), (holding ?x), (ontable ?x), (clear ?y), (on ?y ?x), 
;; pick-up action has changed: (ontable ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
