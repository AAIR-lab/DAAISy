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
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			
		)
		:effect (and
			(not (clear ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(on ?y ?x)
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (holding ?x), 
;; unstack action has changed: (clear ?x), (on ?y ?x), (clear ?y), (handempty), (holding ?y), (holding ?x), (on ?y ?x), (ontable ?x), (ontable ?x), (clear ?x), (holding ?y), (handempty), 
;; stack action has changed: (holding ?y), (clear ?x), (ontable ?y), (on ?x ?y), (on ?x ?y), (handempty), (ontable ?x), (clear ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (handempty), (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
