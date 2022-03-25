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
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (ontable ?x), (clear ?x), (clear ?x), (handempty), 
;; put-down action has changed: (clear ?x), (handempty), (ontable ?x), (ontable ?x), (handempty), (holding ?x), 
;; unstack action has changed: (on ?x ?y), (ontable ?y), (ontable ?y), (holding ?x), (clear ?x), (holding ?y), (ontable ?x), (holding ?y), (holding ?x), (handempty), (on ?x ?y), (clear ?y), 
;; stack action has changed: (clear ?x), (ontable ?y), (on ?y ?x), (ontable ?y), (holding ?y), (holding ?x), (on ?y ?x), (handempty), (ontable ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
