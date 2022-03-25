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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			
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
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (ontable ?x), (holding ?x), (holding ?x), (handempty), (handempty), 
;; stack action has changed: (holding ?x), (ontable ?x), (on ?x ?y), (on ?x ?y), (holding ?x), (handempty), (clear ?y), (clear ?x), (on ?y ?x), (clear ?y), (ontable ?y), (holding ?y), 
;; put-down action has changed: (ontable ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (handempty), (holding ?x), (clear ?x), 
;; unstack action has changed: (ontable ?y), (clear ?y), (ontable ?x), (holding ?x), (holding ?y), (holding ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (holding ?x), (clear ?x), (ontable ?y), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
