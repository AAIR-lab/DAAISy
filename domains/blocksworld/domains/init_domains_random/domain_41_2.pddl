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
			(not (clear ?x))
			
		)
		:effect (and
			(holding ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(holding ?x)
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
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (clear ?x))
			(not (holding ?x))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(clear ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (holding ?x), (on ?x ?y), (on ?y ?x), (ontable ?x), (clear ?x), (on ?x ?y), (holding ?y), (holding ?x), (handempty), (clear ?y), (clear ?x), (handempty), (clear ?y), 
;; stack action has changed: (clear ?y), (holding ?y), (handempty), (on ?x ?y), (ontable ?x), (ontable ?y), (ontable ?y), (ontable ?x), (clear ?x), (holding ?x), (clear ?x), (on ?y ?x), (on ?y ?x), (on ?x ?y), 
;; put-down action has changed: (clear ?x), (holding ?x), (ontable ?x), (clear ?x), (handempty), (handempty), 
;; pick-up action has changed: (handempty), (clear ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
