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
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
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
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (holding ?x))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (clear ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(handempty)
			
		)
   )
)


;; 
;; stack action has changed: (clear ?y), (ontable ?x), (clear ?x), (on ?y ?x), (handempty), (ontable ?x), (on ?x ?y), (on ?x ?y), (clear ?x), (on ?y ?x), (handempty), (holding ?y), (holding ?x), (clear ?y), 
;; pick-up action has changed: (holding ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (ontable ?x), 
;; put-down action has changed: (ontable ?x), (clear ?x), (ontable ?x), 
;; unstack action has changed: (on ?y ?x), (handempty), (ontable ?y), (clear ?y), (on ?x ?y), (on ?y ?x), (holding ?x), (clear ?y), (holding ?y), (on ?x ?y), (clear ?x), (ontable ?x), (ontable ?y), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
