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
			(clear ?x)
			(handempty)
			
		)
		:effect (and
			(not (holding ?x))
			(not (clear ?x))
			(handempty)
			
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
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (on ?x ?y))
			(not (clear ?x))
			(ontable ?y)
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(holding ?y)
			(not (holding ?x))
			(ontable ?y)
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(clear ?x)
			(on ?y ?x)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (holding ?y), (handempty), (ontable ?x), (holding ?y), (ontable ?y), (on ?x ?y), (on ?x ?y), (holding ?x), (clear ?x), (holding ?x), (on ?y ?x), (clear ?x), (handempty), (clear ?y), (ontable ?x), 
;; put-down action has changed: (clear ?x), (ontable ?x), (handempty), (handempty), (holding ?x), 
;; stack action has changed: (ontable ?x), (on ?y ?x), (ontable ?y), (holding ?x), (ontable ?y), (handempty), (ontable ?x), (on ?x ?y), (clear ?x), (handempty), (clear ?y), 
;; pick-up action has changed: (handempty), (ontable ?x), (ontable ?x), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
