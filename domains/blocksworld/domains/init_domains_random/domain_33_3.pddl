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
			(ontable ?x)
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(not (ontable ?y))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (on ?x ?y), (ontable ?y), (clear ?y), (holding ?x), (handempty), (clear ?x), (on ?x ?y), (on ?y ?x), (ontable ?x), (on ?y ?x), (clear ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (ontable ?x), (clear ?x), (holding ?x), 
;; pick-up action has changed: (clear ?x), (handempty), (holding ?x), (ontable ?x), 
;; stack action has changed: (on ?y ?x), (clear ?y), (ontable ?y), (clear ?y), (ontable ?y), (holding ?x), (handempty), (on ?x ?y), (holding ?y), (holding ?x), (on ?x ?y), (holding ?y), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
