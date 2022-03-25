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
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?x ?y), (on ?y ?x), (ontable ?y), (on ?x ?y), (holding ?x), 
;; stack action has changed: (clear ?y), (holding ?x), (holding ?x), (on ?x ?y), (ontable ?x), (ontable ?y), (ontable ?x), (ontable ?y), 
;; put-down action has changed: (handempty), (handempty), 
;; pick-up action has changed: (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
