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
			(clear ?x)
			
		)
		:effect (and
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (handempty), (ontable ?x), (on ?y ?x), (holding ?y), (clear ?y), (ontable ?y), (holding ?x), (clear ?y), (ontable ?y), (ontable ?x), (clear ?x), (on ?x ?y), (handempty), (on ?x ?y), (holding ?x), (holding ?y), (clear ?x), (on ?y ?x), 
;; unstack action has changed: (on ?y ?x), (handempty), (holding ?y), (handempty), (holding ?x), (holding ?x), (ontable ?y), (on ?x ?y), (ontable ?y), (clear ?x), (holding ?y), (clear ?y), (ontable ?x), (on ?y ?x), (ontable ?x), (clear ?x), (clear ?y), (on ?x ?y), 
;; pick-up action has changed: (ontable ?x), (ontable ?x), (holding ?x), (handempty), (holding ?x), (clear ?x), (handempty), 
;; put-down action has changed: (ontable ?x), (ontable ?x), (handempty), (handempty), (holding ?x), (clear ?x), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
