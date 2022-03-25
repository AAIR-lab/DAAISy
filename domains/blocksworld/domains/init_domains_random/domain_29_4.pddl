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
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(ontable ?y)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?y), (ontable ?x), (ontable ?y), (holding ?x), (ontable ?y), (ontable ?x), (holding ?x), (on ?y ?x), (clear ?x), (on ?x ?y), (clear ?y), (clear ?x), 
;; put-down action has changed: (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; stack action has changed: (handempty), (holding ?x), (clear ?y), (ontable ?y), (ontable ?y), (on ?x ?y), (holding ?x), (on ?x ?y), (clear ?x), (holding ?y), 
;; pick-up action has changed: (clear ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
