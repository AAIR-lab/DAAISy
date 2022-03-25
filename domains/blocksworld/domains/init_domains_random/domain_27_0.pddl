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
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(ontable ?y)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (clear ?x))
			(holding ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (holding ?x), (holding ?x), (clear ?y), (holding ?y), (ontable ?x), (on ?y ?x), (handempty), (on ?x ?y), 
;; stack action has changed: (holding ?x), (clear ?y), (on ?x ?y), (clear ?x), (clear ?x), (holding ?x), (ontable ?y), (ontable ?x), (handempty), (holding ?y), (on ?x ?y), 
;; put-down action has changed: (ontable ?x), (handempty), (clear ?x), (holding ?x), 
;; pick-up action has changed: (clear ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
