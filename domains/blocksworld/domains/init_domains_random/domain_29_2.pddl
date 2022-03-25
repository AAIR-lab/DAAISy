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
			(holding ?x)
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (on ?y ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (clear ?x), (handempty), (on ?x ?y), (clear ?y), (ontable ?y), (ontable ?y), (on ?y ?x), (holding ?y), (on ?y ?x), (holding ?x), (on ?x ?y), 
;; pick-up action has changed: (ontable ?x), (clear ?x), (holding ?x), (clear ?x), (holding ?x), 
;; unstack action has changed: (handempty), (handempty), (on ?y ?x), (clear ?x), (clear ?x), (holding ?x), (holding ?x), (ontable ?y), (ontable ?x), 
;; put-down action has changed: (handempty), (holding ?x), (holding ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
