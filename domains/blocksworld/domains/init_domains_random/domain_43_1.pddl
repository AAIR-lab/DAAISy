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
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(on ?y ?x)
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (handempty), (clear ?x), (holding ?x), (clear ?x), (holding ?x), (handempty), 
;; stack action has changed: (holding ?x), (clear ?x), (handempty), (ontable ?x), (on ?x ?y), (clear ?y), (ontable ?y), (on ?y ?x), (on ?x ?y), (handempty), (ontable ?y), (clear ?y), (holding ?y), (on ?y ?x), (holding ?y), 
;; unstack action has changed: (clear ?x), (handempty), (ontable ?x), (clear ?y), (on ?y ?x), (on ?x ?y), (ontable ?y), (holding ?x), (on ?y ?x), (holding ?y), (clear ?x), (holding ?y), (holding ?x), (clear ?y), (handempty), 
;; put-down action has changed: (clear ?x), (handempty), (ontable ?x), (handempty), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
