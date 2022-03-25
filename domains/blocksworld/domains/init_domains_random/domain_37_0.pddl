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
			(not (clear ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (on ?y ?x), (holding ?x), (holding ?y), (ontable ?x), (holding ?x), (clear ?y), (on ?x ?y), 
;; pick-up action has changed: (handempty), (ontable ?x), (holding ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), (clear ?x), 
;; unstack action has changed: (ontable ?y), (clear ?x), (clear ?x), (on ?y ?x), (ontable ?y), (ontable ?x), (ontable ?x), (holding ?y), (holding ?y), (clear ?y), (on ?y ?x), (holding ?x), (clear ?y), (on ?x ?y), (handempty), (holding ?x), 
;; put-down action has changed: (handempty), (clear ?x), (holding ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
