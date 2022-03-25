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
			(not (clear ?x))
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (holding ?x))
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(holding ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(not (clear ?x))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(holding ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (clear ?x))
			(not (holding ?x))
			(ontable ?y)
			(not (on ?y ?x))
			
		)
		:effect (and
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; put-down action has changed: (holding ?x), (handempty), (clear ?x), (holding ?x), (ontable ?x), (ontable ?x), (clear ?x), (handempty), 
;; unstack action has changed: (ontable ?y), (on ?y ?x), (clear ?y), (on ?y ?x), (clear ?y), (on ?x ?y), (holding ?x), (on ?x ?y), (ontable ?y), (clear ?x), (ontable ?x), (handempty), (holding ?x), 
;; pick-up action has changed: (clear ?x), (ontable ?x), (clear ?x), (ontable ?x), (holding ?x), (handempty), 
;; stack action has changed: (on ?y ?x), (on ?y ?x), (on ?x ?y), (on ?x ?y), (clear ?y), (clear ?x), (ontable ?x), (holding ?y), (handempty), (ontable ?x), (ontable ?y), (clear ?x), (holding ?x), (clear ?y), 
;; Last_reduced_capability_num_dropped_pals: None
