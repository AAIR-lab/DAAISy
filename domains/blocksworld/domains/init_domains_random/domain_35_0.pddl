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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (holding ?y), (clear ?x), (clear ?y), (on ?y ?x), (ontable ?y), (ontable ?y), (handempty), (on ?x ?y), (ontable ?x), (on ?x ?y), (clear ?x), 
;; unstack action has changed: (on ?x ?y), (ontable ?x), (clear ?y), (on ?y ?x), (clear ?x), (clear ?y), (ontable ?x), (handempty), (on ?x ?y), (clear ?x), (holding ?y), (on ?y ?x), (ontable ?y), (holding ?y), (handempty), 
;; put-down action has changed: (holding ?x), (ontable ?x), (clear ?x), (handempty), 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
