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
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(ontable ?y)
			(on ?y ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (ontable ?y), (on ?x ?y), (ontable ?x), (holding ?x), (handempty), (clear ?x), (clear ?y), (holding ?y), (on ?y ?x), (on ?y ?x), 
;; put-down action has changed: (holding ?x), (clear ?x), (holding ?x), (handempty), (ontable ?x), (handempty), 
;; stack action has changed: (on ?x ?y), (holding ?y), (clear ?y), (on ?x ?y), (ontable ?x), (holding ?y), (ontable ?y), (handempty), (holding ?x), 
;; pick-up action has changed: (holding ?x), (clear ?x), (ontable ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
