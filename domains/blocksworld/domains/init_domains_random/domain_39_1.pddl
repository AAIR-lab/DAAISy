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
			(not (clear ?x))
			
		)
		:effect (and
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(holding ?y)
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(holding ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			
		)
   )
)


;; 
;; stack action has changed: (holding ?x), (holding ?y), (ontable ?x), (ontable ?y), (handempty), (clear ?y), (clear ?y), (on ?x ?y), (on ?y ?x), (holding ?y), (clear ?x), (ontable ?x), (holding ?x), (handempty), (clear ?x), 
;; unstack action has changed: (ontable ?y), (handempty), (holding ?x), (holding ?y), (ontable ?x), (clear ?y), (holding ?y), (clear ?y), (clear ?x), (on ?x ?y), (ontable ?y), (handempty), (on ?x ?y), (on ?y ?x), 
;; put-down action has changed: (ontable ?x), (holding ?x), (holding ?x), (handempty), (handempty), 
;; pick-up action has changed: (ontable ?x), (clear ?x), (ontable ?x), (handempty), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
