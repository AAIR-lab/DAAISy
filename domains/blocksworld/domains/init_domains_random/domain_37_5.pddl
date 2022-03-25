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
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (clear ?x))
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (on ?y ?x), (handempty), (holding ?y), (ontable ?x), (handempty), (clear ?y), (clear ?x), (on ?y ?x), (holding ?y), (holding ?x), (on ?x ?y), (clear ?y), (ontable ?y), 
;; unstack action has changed: (on ?y ?x), (on ?y ?x), (ontable ?x), (holding ?y), (holding ?x), (clear ?y), (ontable ?y), (on ?x ?y), (holding ?x), (clear ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (clear ?x), (ontable ?x), (handempty), (handempty), (holding ?x), (holding ?x), 
;; pick-up action has changed: (holding ?x), (ontable ?x), (clear ?x), (handempty), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
