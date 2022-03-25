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
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			
		)
		:effect (and
			(ontable ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(clear ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (holding ?x), (on ?y ?x), (ontable ?x), (on ?x ?y), 
;; unstack action has changed: (ontable ?y), (holding ?x), (on ?y ?x), (holding ?x), (ontable ?x), 
;; put-down action has changed: (clear ?x), (holding ?x), (ontable ?x), 
;; pick-up action has changed: (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
