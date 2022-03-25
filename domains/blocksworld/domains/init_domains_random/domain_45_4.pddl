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
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; stack action has changed: (handempty), (holding ?x), (clear ?x), (clear ?y), (holding ?y), (on ?y ?x), (clear ?y), (ontable ?y), (on ?x ?y), (holding ?x), (on ?x ?y), (holding ?y), (ontable ?x), (ontable ?y), (handempty), (ontable ?x), 
;; unstack action has changed: (on ?y ?x), (on ?x ?y), (ontable ?x), (clear ?x), (on ?y ?x), (handempty), (ontable ?y), (ontable ?x), (ontable ?y), (clear ?x), (handempty), (on ?x ?y), (holding ?y), (holding ?x), (holding ?y), (clear ?y), 
;; put-down action has changed: (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (handempty), (ontable ?x), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (holding ?x), (ontable ?x), (handempty), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
