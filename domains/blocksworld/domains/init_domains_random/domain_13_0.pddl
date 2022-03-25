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
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(handempty)
			
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
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			
		)
		:effect (and
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?y), (on ?x ?y), (ontable ?x), (clear ?x), (ontable ?y), 
;; pick-up action has changed: (holding ?x), 
;; unstack action has changed: (ontable ?x), (ontable ?y), (ontable ?y), (holding ?x), (on ?y ?x), 
;; put-down action has changed: (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
