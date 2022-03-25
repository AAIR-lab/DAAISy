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
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (handempty), (clear ?x), (on ?y ?x), (on ?x ?y), (ontable ?y), (holding ?x), (clear ?y), (ontable ?y), (clear ?y), (ontable ?x), (on ?y ?x), (holding ?y), (ontable ?x), (clear ?x), (handempty), (on ?x ?y), (holding ?y), 
;; unstack action has changed: (holding ?y), (handempty), (clear ?y), (ontable ?x), (ontable ?y), (holding ?x), (on ?y ?x), (holding ?y), (on ?x ?y), (holding ?x), (clear ?y), (clear ?x), (on ?x ?y), (ontable ?y), (handempty), (clear ?x), 
;; put-down action has changed: (holding ?x), (ontable ?x), (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; pick-up action has changed: (handempty), (ontable ?x), (holding ?x), (holding ?x), (handempty), (ontable ?x), (clear ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
