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
			
		)
		:effect (and
			(ontable ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?x ?y), (ontable ?x), (ontable ?x), (on ?y ?x), (handempty), (clear ?x), (holding ?y), (ontable ?y), (clear ?y), (on ?y ?x), (holding ?x), (on ?x ?y), (handempty), (holding ?y), (clear ?x), (clear ?y), (holding ?x), 
;; put-down action has changed: (holding ?x), (handempty), (handempty), (ontable ?x), (holding ?x), (ontable ?x), (clear ?x), 
;; stack action has changed: (clear ?y), (holding ?x), (clear ?x), (ontable ?x), (ontable ?y), (on ?y ?x), (holding ?y), (handempty), (ontable ?x), (clear ?y), (holding ?y), (ontable ?y), (on ?x ?y), (on ?x ?y), (holding ?x), (handempty), (on ?y ?x), 
;; pick-up action has changed: (clear ?x), (holding ?x), (handempty), (ontable ?x), (ontable ?x), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
