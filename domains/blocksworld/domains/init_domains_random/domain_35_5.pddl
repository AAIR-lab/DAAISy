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
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (holding ?x), (holding ?x), (handempty), (handempty), 
;; stack action has changed: (ontable ?y), (on ?y ?x), (ontable ?y), (holding ?y), (clear ?y), (clear ?y), (on ?x ?y), (ontable ?x), (handempty), (clear ?x), (holding ?x), 
;; pick-up action has changed: (handempty), (clear ?x), (holding ?x), (ontable ?x), (clear ?x), (handempty), (holding ?x), (ontable ?x), 
;; unstack action has changed: (on ?y ?x), (on ?x ?y), (ontable ?y), (on ?y ?x), (clear ?y), (clear ?y), (holding ?x), (ontable ?x), (ontable ?x), (clear ?x), (ontable ?y), 
;; Last_reduced_capability_num_dropped_pals: None
