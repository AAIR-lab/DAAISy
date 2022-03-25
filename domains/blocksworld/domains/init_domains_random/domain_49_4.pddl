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
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			
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
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?y), (on ?x ?y), (clear ?y), (holding ?y), (ontable ?y), (clear ?x), (clear ?x), (holding ?y), (ontable ?y), (handempty), (on ?y ?x), (holding ?x), (holding ?x), (ontable ?x), (on ?x ?y), (handempty), (ontable ?x), 
;; put-down action has changed: (holding ?x), (ontable ?x), (holding ?x), (clear ?x), (clear ?x), (ontable ?x), (handempty), (handempty), 
;; stack action has changed: (on ?y ?x), (clear ?y), (holding ?y), (on ?y ?x), (ontable ?x), (ontable ?y), (on ?x ?y), (on ?x ?y), (handempty), (clear ?x), (clear ?y), (ontable ?y), (clear ?x), (holding ?y), (holding ?x), (handempty), 
;; pick-up action has changed: (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (handempty), (handempty), (ontable ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
