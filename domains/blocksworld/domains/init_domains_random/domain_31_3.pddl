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
			(not (holding ?x))
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			
		)
		:effect (and
			(holding ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (ontable ?y))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (clear ?x))
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
			(on ?x ?y)
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (holding ?x), (holding ?x), (ontable ?x), (clear ?x), (ontable ?x), 
;; stack action has changed: (holding ?x), (holding ?x), (clear ?y), (ontable ?y), (ontable ?y), (ontable ?x), (clear ?x), (ontable ?x), (handempty), (clear ?y), 
;; unstack action has changed: (ontable ?y), (clear ?y), (clear ?y), (holding ?x), (on ?x ?y), (clear ?x), (ontable ?y), (clear ?x), (on ?y ?x), (on ?x ?y), 
;; pick-up action has changed: (clear ?x), (holding ?x), (handempty), (ontable ?x), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
