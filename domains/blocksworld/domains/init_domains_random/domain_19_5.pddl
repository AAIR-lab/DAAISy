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
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(clear ?x)
			(holding ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (clear ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (holding ?x), (ontable ?x), (clear ?x), 
;; unstack action has changed: (clear ?y), (ontable ?y), (holding ?x), (handempty), (on ?x ?y), (holding ?x), (holding ?y), 
;; stack action has changed: (clear ?x), (clear ?x), (ontable ?x), (ontable ?x), (on ?y ?x), (ontable ?y), 
;; pick-up action has changed: (handempty), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
