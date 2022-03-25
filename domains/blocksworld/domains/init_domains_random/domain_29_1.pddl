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
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(clear ?x)
			(holding ?x)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (handempty), (holding ?x), 
;; unstack action has changed: (holding ?x), (ontable ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (on ?y ?x), (clear ?y), (ontable ?x), (clear ?y), 
;; stack action has changed: (holding ?x), (on ?x ?y), (ontable ?x), (on ?y ?x), (handempty), (clear ?x), (handempty), (ontable ?y), (on ?x ?y), (holding ?y), (ontable ?y), (on ?y ?x), 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
