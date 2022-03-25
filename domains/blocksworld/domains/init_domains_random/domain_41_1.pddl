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
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (handempty), (handempty), (clear ?x), (clear ?x), (ontable ?x), 
;; stack action has changed: (clear ?x), (on ?x ?y), (on ?y ?x), (ontable ?y), (handempty), (clear ?y), (holding ?y), (holding ?y), (on ?y ?x), (clear ?y), (handempty), (on ?x ?y), 
;; put-down action has changed: (clear ?x), (handempty), (handempty), (holding ?x), (holding ?x), (ontable ?x), (clear ?x), 
;; unstack action has changed: (on ?x ?y), (holding ?x), (ontable ?x), (clear ?x), (clear ?y), (clear ?x), (on ?y ?x), (ontable ?x), (holding ?y), (holding ?x), (on ?x ?y), (ontable ?y), (handempty), (handempty), (ontable ?y), (holding ?y), 
;; Last_reduced_capability_num_dropped_pals: None
