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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(on ?y ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (ontable ?y))
			(not (handempty))
			
		)
		:effect (and
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (handempty), (clear ?y), (on ?x ?y), (on ?y ?x), (clear ?x), (clear ?x), (holding ?y), 
;; unstack action has changed: (clear ?y), (clear ?x), (clear ?y), (handempty), (handempty), (ontable ?y), 
;; put-down action has changed: (handempty), (ontable ?x), (ontable ?x), 
;; pick-up action has changed: (ontable ?x), (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
