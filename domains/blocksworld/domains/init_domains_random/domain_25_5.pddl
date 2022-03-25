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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
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
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (clear ?x))
			(not (ontable ?x))
			(handempty)
			
		)
   )
)


;; 
;; put-down action has changed: (handempty), (clear ?x), (ontable ?x), 
;; pick-up action has changed: (holding ?x), (handempty), (ontable ?x), (ontable ?x), 
;; unstack action has changed: (ontable ?x), (holding ?x), (holding ?x), (holding ?y), (ontable ?x), (handempty), (on ?x ?y), (clear ?y), (on ?x ?y), (holding ?y), 
;; stack action has changed: (handempty), (ontable ?y), (on ?y ?x), (on ?x ?y), (holding ?x), (ontable ?x), (clear ?y), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
