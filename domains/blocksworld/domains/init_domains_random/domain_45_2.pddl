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
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?y), (holding ?y), (handempty), (ontable ?y), (on ?y ?x), (on ?x ?y), (on ?y ?x), (clear ?y), (holding ?x), (ontable ?x), (holding ?y), (clear ?x), (clear ?x), (clear ?y), 
;; put-down action has changed: (ontable ?x), (holding ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), (handempty), (clear ?x), 
;; unstack action has changed: (ontable ?x), (clear ?x), (handempty), (holding ?y), (holding ?y), (holding ?x), (on ?y ?x), (clear ?x), (holding ?x), (ontable ?x), (on ?y ?x), (clear ?y), (ontable ?y), (on ?x ?y), (clear ?y), (ontable ?y), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (handempty), (handempty), (ontable ?x), (holding ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
