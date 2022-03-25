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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
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
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(clear ?x)
			(holding ?x)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (holding ?x), (ontable ?x), (handempty), (ontable ?x), (handempty), 
;; unstack action has changed: (ontable ?x), (ontable ?x), (holding ?x), (on ?x ?y), (ontable ?y), (clear ?x), (on ?y ?x), (holding ?y), (holding ?y), (clear ?y), (on ?y ?x), (on ?x ?y), (holding ?x), 
;; stack action has changed: (ontable ?y), (holding ?x), (handempty), (on ?x ?y), (holding ?y), (clear ?x), (ontable ?x), (on ?y ?x), (holding ?x), (holding ?y), (clear ?y), (ontable ?x), (clear ?y), 
;; put-down action has changed: (holding ?x), (holding ?x), (ontable ?x), (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
