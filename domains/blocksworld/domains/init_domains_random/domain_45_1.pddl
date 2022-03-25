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
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (holding ?x))
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (ontable ?x), (handempty), (ontable ?x), (ontable ?y), (handempty), (ontable ?y), (clear ?y), (clear ?x), (clear ?x), (clear ?y), (on ?x ?y), (on ?x ?y), (on ?y ?x), (holding ?x), (holding ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (holding ?x), (holding ?x), (handempty), (clear ?x), 
;; unstack action has changed: (handempty), (holding ?y), (clear ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (clear ?x), (ontable ?y), (clear ?x), (ontable ?y), (ontable ?x), (holding ?y), (handempty), (on ?x ?y), (clear ?y), (holding ?x), 
;; pick-up action has changed: (clear ?x), (handempty), (holding ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
