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
			(not (holding ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?x))
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (clear ?y), (ontable ?y), (holding ?x), (handempty), (clear ?y), (handempty), (holding ?y), (ontable ?x), (ontable ?y), (clear ?x), (ontable ?x), (holding ?y), (clear ?x), (on ?y ?x), (holding ?x), (on ?x ?y), 
;; unstack action has changed: (holding ?y), (handempty), (ontable ?x), (on ?y ?x), (on ?x ?y), (handempty), (ontable ?y), (clear ?x), (ontable ?y), (clear ?y), (ontable ?x), (holding ?x), (on ?x ?y), 
;; put-down action has changed: (clear ?x), (handempty), (holding ?x), (handempty), (clear ?x), (ontable ?x), (ontable ?x), 
;; pick-up action has changed: (holding ?x), (handempty), (clear ?x), (handempty), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
