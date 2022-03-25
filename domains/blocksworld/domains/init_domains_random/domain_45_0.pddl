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
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(not (on ?y ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
		:effect (and
			(not (clear ?y))
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(ontable ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (holding ?y))
			(not (on ?x ?y))
			(holding ?x)
			(ontable ?y)
			(on ?y ?x)
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(ontable ?y)
			(ontable ?x)
			(handempty)
			
		)
   )
)


;; 
;; unstack action has changed: (clear ?x), (on ?y ?x), (holding ?x), (ontable ?x), (ontable ?y), (ontable ?y), (holding ?x), (handempty), (holding ?y), (clear ?x), (handempty), (on ?x ?y), (holding ?y), (ontable ?x), 
;; stack action has changed: (holding ?x), (ontable ?y), (ontable ?x), (holding ?y), (clear ?x), (ontable ?x), (ontable ?y), (on ?x ?y), (on ?y ?x), (clear ?y), (on ?y ?x), (on ?x ?y), (handempty), (handempty), (holding ?y), (clear ?x), 
;; pick-up action has changed: (handempty), (handempty), (ontable ?x), (clear ?x), (clear ?x), (holding ?x), (ontable ?x), (holding ?x), 
;; put-down action has changed: (handempty), (ontable ?x), (handempty), (ontable ?x), (holding ?x), (holding ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
