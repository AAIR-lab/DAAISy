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
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(ontable ?y)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (handempty), (ontable ?x), (clear ?y), (clear ?x), (holding ?y), (handempty), (ontable ?y), 
;; stack action has changed: (holding ?y), (holding ?y), (on ?y ?x), (ontable ?y), (handempty), (holding ?x), (ontable ?x), (clear ?x), (on ?x ?y), 
;; put-down action has changed: (holding ?x), (ontable ?x), (handempty), (handempty), (clear ?x), 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
