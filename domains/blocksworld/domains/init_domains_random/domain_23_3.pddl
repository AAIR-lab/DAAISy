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
			(holding ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
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
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?y))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (on ?y ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (holding ?x), (holding ?y), (on ?x ?y), (ontable ?y), (clear ?x), (holding ?x), (clear ?x), (on ?y ?x), (holding ?y), 
;; unstack action has changed: (on ?x ?y), (holding ?x), (on ?y ?x), (on ?y ?x), (holding ?y), (clear ?y), (ontable ?y), 
;; put-down action has changed: (handempty), (clear ?x), 
;; pick-up action has changed: (clear ?x), (clear ?x), (handempty), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
