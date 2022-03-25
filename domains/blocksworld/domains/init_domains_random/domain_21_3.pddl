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
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
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
			(not (on ?x ?y))
			(holding ?x)
			(on ?y ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(clear ?x)
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (on ?y ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (holding ?y), (clear ?y), (holding ?y), (on ?x ?y), (on ?y ?x), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (holding ?x), (ontable ?x), (handempty), 
;; unstack action has changed: (on ?y ?x), (holding ?y), (ontable ?y), (clear ?y), (holding ?y), (on ?x ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (ontable ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
