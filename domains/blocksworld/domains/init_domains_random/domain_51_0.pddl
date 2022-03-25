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
			(not (handempty))
			
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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
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
			(holding ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
   )
)


;; 
;; pick-up action has changed: (handempty), (clear ?x), (holding ?x), (holding ?x), (clear ?x), (ontable ?x), (handempty), (ontable ?x), 
;; put-down action has changed: (holding ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), 
;; stack action has changed: (ontable ?y), (ontable ?y), (ontable ?x), (holding ?x), (on ?x ?y), (clear ?y), (holding ?y), (holding ?y), (on ?y ?x), (on ?y ?x), (holding ?x), (clear ?x), (on ?x ?y), (handempty), (ontable ?x), (handempty), (clear ?y), (clear ?x), 
;; unstack action has changed: (on ?x ?y), (holding ?y), (on ?x ?y), (on ?y ?x), (clear ?y), (ontable ?y), (holding ?x), (ontable ?x), (clear ?x), (handempty), (holding ?y), (ontable ?x), (clear ?x), (on ?y ?x), (handempty), (ontable ?y), (holding ?x), (clear ?y), 
;; Last_reduced_capability_num_dropped_pals: None
