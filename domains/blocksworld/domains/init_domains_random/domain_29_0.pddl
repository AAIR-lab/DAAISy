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
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (clear ?x))
			
		)
		:effect (and
			(not (holding ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(holding ?x)
			(not (ontable ?y))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (handempty), (clear ?x), (clear ?x), (holding ?y), (holding ?y), (ontable ?y), (on ?x ?y), (holding ?x), (holding ?x), (ontable ?x), (on ?y ?x), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (holding ?x), (ontable ?x), (handempty), 
;; stack action has changed: (holding ?x), (on ?y ?x), (handempty), (ontable ?y), (holding ?x), (clear ?x), 
;; put-down action has changed: (handempty), (ontable ?x), (clear ?x), (holding ?x), (clear ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
