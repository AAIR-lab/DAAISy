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
			
		)
		:effect (and
			(not (holding ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(on ?x ?y)
			(holding ?x)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
   )
)


;; 
;; put-down action has changed: (clear ?x), (holding ?x), (clear ?x), (handempty), (ontable ?x), (holding ?x), 
;; stack action has changed: (ontable ?x), (holding ?x), (clear ?y), (holding ?y), (clear ?y), (clear ?x), (on ?x ?y), (on ?y ?x), (on ?x ?y), 
;; unstack action has changed: (handempty), (ontable ?y), (on ?y ?x), (ontable ?x), (clear ?x), (clear ?y), (on ?y ?x), (clear ?x), (handempty), (ontable ?x), (holding ?x), (on ?x ?y), (on ?x ?y), 
;; pick-up action has changed: (holding ?x), (clear ?x), (holding ?x), (clear ?x), (ontable ?x), (ontable ?x), (handempty), 
;; Last_reduced_capability_num_dropped_pals: None
