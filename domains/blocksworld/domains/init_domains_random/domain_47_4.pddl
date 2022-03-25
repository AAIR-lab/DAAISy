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
			(ontable ?x)
			(not (holding ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(holding ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (on ?y ?x), (ontable ?y), (handempty), (holding ?x), (holding ?y), (ontable ?y), (clear ?x), (clear ?y), (on ?y ?x), (ontable ?x), (clear ?x), (holding ?x), (on ?x ?y), (on ?x ?y), (clear ?y), 
;; unstack action has changed: (holding ?x), (on ?y ?x), (clear ?y), (on ?x ?y), (clear ?x), (on ?x ?y), (handempty), (ontable ?x), (clear ?y), (ontable ?y), (ontable ?x), (holding ?y), (clear ?x), (holding ?y), (on ?y ?x), (handempty), 
;; pick-up action has changed: (holding ?x), (clear ?x), (handempty), (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), 
;; put-down action has changed: (ontable ?x), (ontable ?x), (handempty), (holding ?x), (holding ?x), (clear ?x), (clear ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
