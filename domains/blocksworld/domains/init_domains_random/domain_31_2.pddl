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
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			
		)
		:effect (and
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(ontable ?y)
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(clear ?x)
			(holding ?x)
			(on ?y ?x)
			(ontable ?x)
			
		)
   )
)


;; 
;; stack action has changed: (holding ?x), (holding ?x), (on ?x ?y), (clear ?x), (on ?y ?x), (ontable ?y), (on ?x ?y), (ontable ?x), (clear ?x), (ontable ?y), 
;; pick-up action has changed: (holding ?x), (handempty), 
;; unstack action has changed: (handempty), (on ?x ?y), (holding ?y), (ontable ?x), (clear ?y), (holding ?x), (clear ?y), (holding ?y), (on ?y ?x), (on ?x ?y), (ontable ?y), (clear ?x), (clear ?x), (ontable ?x), (handempty), 
;; put-down action has changed: (holding ?x), (clear ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
