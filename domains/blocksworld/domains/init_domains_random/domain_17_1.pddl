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
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(holding ?x)
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(on ?y ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(on ?y ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (ontable ?y))
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (handempty), (clear ?x), (clear ?x), (handempty), (ontable ?x), (holding ?x), 
;; stack action has changed: (handempty), (on ?y ?x), (on ?x ?y), (clear ?x), (on ?y ?x), (holding ?y), 
;; pick-up action has changed: (handempty), 
;; unstack action has changed: (on ?y ?x), (holding ?x), (ontable ?y), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
