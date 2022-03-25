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
			(not (handempty))
			
		)
		:effect (and
			(holding ?x)
			
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
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
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
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
   )
)


;; 
;; pick-up action has changed: (clear ?x), (ontable ?x), (ontable ?x), (clear ?x), (handempty), (handempty), (holding ?x), 
;; stack action has changed: (holding ?y), (holding ?x), (clear ?x), (on ?x ?y), (clear ?y), (holding ?x), (ontable ?y), (ontable ?x), (clear ?y), (on ?y ?x), (on ?y ?x), (handempty), (clear ?x), (ontable ?y), (handempty), (ontable ?x), (holding ?y), (on ?x ?y), 
;; put-down action has changed: (clear ?x), (handempty), (holding ?x), (ontable ?x), (holding ?x), (handempty), (ontable ?x), (clear ?x), 
;; unstack action has changed: (on ?x ?y), (clear ?y), (holding ?x), (handempty), (ontable ?y), (clear ?x), (ontable ?x), (on ?y ?x), (on ?x ?y), (holding ?x), (clear ?y), (handempty), (ontable ?x), (on ?y ?x), (holding ?y), (clear ?x), (ontable ?y), (holding ?y), 
;; Last_reduced_capability_num_dropped_pals: None
