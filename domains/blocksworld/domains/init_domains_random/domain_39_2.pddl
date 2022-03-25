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
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(holding ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), (holding ?x), (handempty), (clear ?x), (clear ?x), 
;; put-down action has changed: (holding ?x), (clear ?x), (clear ?x), (holding ?x), (handempty), (ontable ?x), 
;; unstack action has changed: (handempty), (ontable ?y), (handempty), (clear ?x), (holding ?y), (holding ?y), (clear ?y), (ontable ?y), (on ?y ?x), (ontable ?x), (holding ?x), (clear ?x), (clear ?y), (holding ?x), (ontable ?x), 
;; stack action has changed: (ontable ?y), (holding ?x), (on ?x ?y), (on ?x ?y), (ontable ?y), (on ?y ?x), (on ?y ?x), (clear ?y), (clear ?y), (handempty), (holding ?y), 
;; Last_reduced_capability_num_dropped_pals: None
