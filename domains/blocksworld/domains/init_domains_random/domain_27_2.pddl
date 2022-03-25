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
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), 
;; unstack action has changed: (clear ?y), (on ?x ?y), (handempty), (holding ?x), (holding ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (clear ?y), (clear ?x), 
;; stack action has changed: (ontable ?x), (handempty), (on ?y ?x), (holding ?x), (clear ?x), (clear ?y), (ontable ?y), (handempty), (on ?x ?y), 
;; pick-up action has changed: (holding ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
