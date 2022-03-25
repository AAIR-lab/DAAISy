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
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
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
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(clear ?x)
			(on ?y ?x)
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (on ?x ?y), (handempty), (clear ?x), (ontable ?x), (holding ?x), (clear ?y), (ontable ?x), (clear ?y), (holding ?x), (on ?x ?y), (holding ?y), (handempty), (on ?y ?x), (ontable ?y), 
;; unstack action has changed: (ontable ?y), (ontable ?x), (holding ?x), (ontable ?y), (holding ?y), (on ?x ?y), (on ?y ?x), (on ?y ?x), (holding ?y), (on ?x ?y), (handempty), (clear ?x), (clear ?y), (holding ?x), (clear ?x), 
;; pick-up action has changed: (handempty), (holding ?x), (holding ?x), (ontable ?x), (ontable ?x), (clear ?x), (clear ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (clear ?x), (handempty), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
