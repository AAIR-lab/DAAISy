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
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(clear ?x)
			(not (ontable ?x))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (clear ?y), (clear ?x), (ontable ?x), (on ?x ?y), (clear ?x), (ontable ?x), (ontable ?y), (holding ?y), (holding ?y), (clear ?y), (handempty), (holding ?x), (handempty), (holding ?x), 
;; stack action has changed: (clear ?x), (on ?y ?x), (on ?y ?x), (holding ?y), (clear ?y), (handempty), (clear ?x), (clear ?y), (holding ?y), (ontable ?y), (handempty), (holding ?x), (ontable ?x), (ontable ?y), (on ?x ?y), (holding ?x), (ontable ?x), (on ?x ?y), 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), (handempty), 
;; pick-up action has changed: (holding ?x), (handempty), (handempty), (clear ?x), (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
