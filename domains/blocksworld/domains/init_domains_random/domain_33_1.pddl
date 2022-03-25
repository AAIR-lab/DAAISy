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
			
		)
		:effect (and
			(not (ontable ?x))
			(clear ?x)
			
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
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (holding ?y), (on ?x ?y), (on ?y ?x), (on ?x ?y), (handempty), (clear ?x), (clear ?y), (holding ?x), (ontable ?y), (holding ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (clear ?x), (handempty), (holding ?x), (handempty), 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (ontable ?y), (handempty), (clear ?x), (holding ?y), (on ?y ?x), (holding ?y), (holding ?x), 
;; pick-up action has changed: (handempty), (holding ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
