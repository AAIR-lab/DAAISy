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
			
		)
		:effect (and
			(ontable ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (ontable ?x), (holding ?y), (on ?y ?x), (holding ?x), (on ?x ?y), (clear ?x), (ontable ?y), (on ?y ?x), (holding ?y), (holding ?x), (clear ?x), (clear ?y), (on ?x ?y), (handempty), (handempty), (ontable ?y), 
;; unstack action has changed: (clear ?y), (holding ?y), (ontable ?x), (handempty), (handempty), (holding ?y), (on ?x ?y), (ontable ?y), (ontable ?x), (clear ?y), (holding ?x), (clear ?x), (on ?y ?x), (on ?y ?x), (holding ?x), (on ?x ?y), (clear ?x), (ontable ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (clear ?x), (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (handempty), 
;; pick-up action has changed: (ontable ?x), (holding ?x), (ontable ?x), (handempty), (clear ?x), (handempty), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
