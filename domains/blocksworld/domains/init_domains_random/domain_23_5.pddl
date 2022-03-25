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
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?y))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (holding ?x), (ontable ?x), (ontable ?x), (holding ?x), (handempty), (clear ?x), 
;; unstack action has changed: (holding ?y), (on ?y ?x), (handempty), (ontable ?x), (holding ?y), (ontable ?y), (on ?x ?y), (on ?y ?x), (ontable ?y), 
;; pick-up action has changed: (ontable ?x), (clear ?x), 
;; stack action has changed: (on ?x ?y), (holding ?x), (holding ?y), (ontable ?y), (clear ?x), (ontable ?y), 
;; Last_reduced_capability_num_dropped_pals: None
