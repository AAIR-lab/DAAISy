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
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
		:effect (and
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(ontable ?y)
			
		)
		:effect (and
			(not (clear ?y))
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
			(on ?x ?y)
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
   )
)


;; 
;; stack action has changed: (holding ?x), (ontable ?y), (ontable ?y), (on ?y ?x), (clear ?x), (holding ?y), (clear ?y), (on ?x ?y), (ontable ?x), (handempty), (on ?x ?y), (holding ?x), 
;; unstack action has changed: (handempty), (holding ?x), (ontable ?x), (ontable ?y), (on ?y ?x), (on ?x ?y), (holding ?x), (clear ?y), (clear ?x), (clear ?x), 
;; pick-up action has changed: (holding ?x), (ontable ?x), (clear ?x), (holding ?x), (handempty), (ontable ?x), (clear ?x), 
;; put-down action has changed: (ontable ?x), (handempty), (handempty), (holding ?x), (clear ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
