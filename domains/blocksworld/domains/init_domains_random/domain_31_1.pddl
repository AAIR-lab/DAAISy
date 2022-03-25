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
			(not (holding ?x))
			(handempty)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (holding ?x))
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(ontable ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?x))
			(not (holding ?x))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(holding ?x)
			(not (ontable ?y))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (clear ?x), (holding ?x), 
;; put-down action has changed: (ontable ?x), (holding ?x), (handempty), (handempty), 
;; stack action has changed: (ontable ?x), (holding ?y), (holding ?x), (ontable ?x), (holding ?x), (handempty), (clear ?x), (on ?y ?x), (on ?x ?y), (clear ?x), (clear ?y), (holding ?y), (ontable ?y), (clear ?y), 
;; unstack action has changed: (on ?x ?y), (on ?y ?x), (on ?x ?y), (ontable ?x), (holding ?y), (clear ?x), (ontable ?y), (handempty), (clear ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
