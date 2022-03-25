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
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?x)
			(not (handempty))
			
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
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (on ?y ?x), (on ?y ?x), (holding ?y), (holding ?y), (ontable ?y), (ontable ?x), (clear ?x), (handempty), (ontable ?y), (clear ?x), (holding ?x), (ontable ?x), (on ?x ?y), (holding ?x), (clear ?y), (on ?x ?y), (clear ?y), (handempty), 
;; stack action has changed: (handempty), (clear ?y), (holding ?y), (on ?x ?y), (on ?x ?y), (holding ?x), (clear ?x), (holding ?y), (clear ?x), (ontable ?y), (clear ?y), (on ?y ?x), (handempty), (ontable ?y), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (ontable ?x), (holding ?x), (holding ?x), 
;; put-down action has changed: (handempty), (ontable ?x), (clear ?x), (clear ?x), (holding ?x), (holding ?x), (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
