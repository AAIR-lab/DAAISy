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
			(not (clear ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (on ?y ?x), (on ?y ?x), (clear ?y), (handempty), (clear ?x), (clear ?y), (holding ?x), (on ?x ?y), (holding ?y), (holding ?x), (ontable ?x), (clear ?x), (ontable ?y), (ontable ?x), (ontable ?y), (holding ?y), (handempty), (on ?x ?y), 
;; put-down action has changed: (handempty), (handempty), (clear ?x), (ontable ?x), (ontable ?x), (holding ?x), (holding ?x), (clear ?x), 
;; stack action has changed: (holding ?x), (ontable ?y), (holding ?y), (handempty), (handempty), (clear ?y), (on ?x ?y), (holding ?x), (on ?y ?x), (on ?x ?y), (on ?y ?x), (ontable ?y), (ontable ?x), (ontable ?x), (clear ?x), (clear ?y), 
;; pick-up action has changed: (holding ?x), (ontable ?x), (clear ?x), (handempty), (holding ?x), (clear ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
