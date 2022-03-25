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
			(ontable ?x)
			(holding ?x)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (holding ?y), (holding ?x), (holding ?x), (holding ?y), (ontable ?x), (on ?y ?x), (ontable ?x), (on ?x ?y), (clear ?x), 
;; unstack action has changed: (ontable ?x), (ontable ?y), (handempty), (ontable ?x), (clear ?x), (on ?x ?y), (ontable ?y), (holding ?x), (on ?y ?x), 
;; put-down action has changed: (holding ?x), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
