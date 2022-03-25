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
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(not (clear ?x))
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			(not (holding ?x))
			(not (handempty))
			
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
			(holding ?y)
			(on ?x ?y)
			(not (clear ?x))
			(not (holding ?x))
			(on ?y ?x)
			
		)
		:effect (and
			(not (clear ?y))
			(holding ?y)
			(not (on ?x ?y))
			(ontable ?y)
			(on ?y ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?y), (on ?x ?y), (on ?y ?x), (holding ?y), (clear ?x), (ontable ?y), (ontable ?y), (handempty), (handempty), (holding ?x), 
;; pick-up action has changed: (handempty), (handempty), (ontable ?x), 
;; put-down action has changed: (ontable ?x), (holding ?x), (handempty), (ontable ?x), (holding ?x), (handempty), 
;; stack action has changed: (holding ?x), (on ?y ?x), (holding ?y), (holding ?x), (on ?x ?y), (on ?x ?y), (clear ?x), (ontable ?y), (handempty), (holding ?y), (on ?y ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
