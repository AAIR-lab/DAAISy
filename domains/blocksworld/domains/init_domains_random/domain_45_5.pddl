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
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(clear ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (clear ?y), (on ?y ?x), (on ?y ?x), (clear ?x), (holding ?y), (ontable ?x), (ontable ?y), (holding ?x), (ontable ?x), (clear ?x), (ontable ?y), (holding ?y), (handempty), (on ?x ?y), (clear ?y), (handempty), 
;; put-down action has changed: (handempty), (holding ?x), (handempty), (holding ?x), (clear ?x), (ontable ?x), (ontable ?x), (clear ?x), 
;; pick-up action has changed: (clear ?x), (holding ?x), (ontable ?x), (handempty), (holding ?x), (ontable ?x), (clear ?x), 
;; stack action has changed: (ontable ?y), (clear ?y), (holding ?y), (on ?y ?x), (on ?x ?y), (holding ?x), (on ?y ?x), (handempty), (ontable ?y), (clear ?y), (holding ?y), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
