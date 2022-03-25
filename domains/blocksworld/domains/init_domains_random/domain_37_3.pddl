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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(not (on ?y ?x))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(ontable ?x)
			
		)
   )
)


;; 
;; stack action has changed: (on ?y ?x), (holding ?x), (handempty), (on ?y ?x), (clear ?y), (clear ?x), (ontable ?x), (clear ?y), (ontable ?y), (on ?x ?y), (handempty), (holding ?y), 
;; unstack action has changed: (holding ?y), (holding ?y), (ontable ?y), (clear ?y), (handempty), (on ?x ?y), (clear ?x), (handempty), (clear ?y), (on ?y ?x), (ontable ?y), (clear ?x), (ontable ?x), (holding ?x), 
;; pick-up action has changed: (clear ?x), (handempty), (holding ?x), (ontable ?x), (holding ?x), 
;; put-down action has changed: (holding ?x), (holding ?x), (clear ?x), (clear ?x), (handempty), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
