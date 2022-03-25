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
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
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
			(not (ontable ?x))
			(holding ?x)
			
		)
		:effect (and
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			
		)
		:effect (and
			(on ?x ?y)
			(clear ?x)
			(not (on ?y ?x))
			(ontable ?x)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (ontable ?x), (clear ?y), (handempty), (on ?x ?y), (holding ?x), (on ?y ?x), (holding ?y), (clear ?x), 
;; pick-up action has changed: (holding ?x), (holding ?x), (ontable ?x), (handempty), 
;; put-down action has changed: (holding ?x), (handempty), (ontable ?x), (ontable ?x), 
;; unstack action has changed: (clear ?y), (on ?y ?x), (holding ?x), (clear ?x), (holding ?y), (holding ?y), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
