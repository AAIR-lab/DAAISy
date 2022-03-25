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
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(holding ?x)
			(ontable ?y)
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
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (handempty), (ontable ?x), (clear ?x), (on ?y ?x), (on ?x ?y), (holding ?y), (clear ?y), (ontable ?y), (clear ?y), (clear ?x), (holding ?x), (holding ?y), (on ?y ?x), (handempty), (holding ?x), 
;; pick-up action has changed: (clear ?x), (handempty), (holding ?x), (handempty), (clear ?x), (ontable ?x), (holding ?x), 
;; stack action has changed: (ontable ?x), (clear ?y), (holding ?y), (on ?x ?y), (on ?y ?x), (ontable ?y), (ontable ?x), (holding ?x), (handempty), (on ?x ?y), (holding ?x), (handempty), (ontable ?y), (on ?y ?x), (holding ?y), (clear ?y), (clear ?x), (clear ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (handempty), (holding ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
