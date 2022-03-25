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
			(ontable ?x)
			
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
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (clear ?x))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
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
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?y), (handempty), (clear ?y), (on ?y ?x), (holding ?x), (ontable ?x), (holding ?x), (clear ?x), (on ?x ?y), (clear ?y), (ontable ?x), (handempty), (on ?y ?x), (on ?x ?y), (ontable ?y), (holding ?y), (clear ?x), (ontable ?y), 
;; stack action has changed: (handempty), (holding ?x), (ontable ?y), (clear ?x), (holding ?y), (on ?x ?y), (handempty), (holding ?x), (on ?x ?y), (clear ?x), (ontable ?x), (on ?y ?x), (clear ?y), (holding ?y), (clear ?y), (on ?y ?x), (ontable ?y), (ontable ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), (handempty), (holding ?x), 
;; pick-up action has changed: (handempty), (ontable ?x), (ontable ?x), (clear ?x), (holding ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
