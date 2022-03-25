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
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(not (clear ?x))
			
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
			(clear ?y)
			(not (clear ?x))
			(holding ?x)
			(not (on ?y ?x))
			
		)
		:effect (and
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (ontable ?y), (holding ?x), (ontable ?x), (handempty), (clear ?y), (on ?y ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (holding ?x), 
;; unstack action has changed: (ontable ?x), (holding ?y), (holding ?x), (on ?x ?y), (clear ?x), (ontable ?y), 
;; pick-up action has changed: (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
