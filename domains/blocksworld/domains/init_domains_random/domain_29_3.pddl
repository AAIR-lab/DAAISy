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
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (on ?x ?y))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?y), (holding ?x), (handempty), (holding ?x), (holding ?y), (on ?y ?x), (ontable ?x), (on ?x ?y), (clear ?y), (on ?x ?y), (clear ?x), 
;; unstack action has changed: (clear ?x), (handempty), (clear ?y), (ontable ?y), (holding ?x), (on ?y ?x), (holding ?x), (clear ?x), (holding ?y), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (handempty), (holding ?x), (clear ?x), (clear ?x), 
;; put-down action has changed: (ontable ?x), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
