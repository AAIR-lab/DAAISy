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
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(ontable ?x)
			
		)
		:effect (and
			(holding ?y)
			(not (holding ?x))
			(on ?y ?x)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?y), (clear ?x), (clear ?x), (ontable ?x), (clear ?y), (handempty), (ontable ?y), (on ?x ?y), (on ?x ?y), (holding ?y), (on ?y ?x), (clear ?y), (on ?y ?x), (holding ?x), (handempty), (holding ?y), (ontable ?x), 
;; put-down action has changed: (ontable ?x), (handempty), (clear ?x), (handempty), (ontable ?x), (holding ?x), (holding ?x), (clear ?x), 
;; pick-up action has changed: (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), (holding ?x), (handempty), (clear ?x), 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (holding ?x), (on ?x ?y), (clear ?x), (on ?x ?y), (handempty), (holding ?y), (handempty), (clear ?x), (ontable ?x), (holding ?y), (holding ?x), (clear ?y), 
;; Last_reduced_capability_num_dropped_pals: None
