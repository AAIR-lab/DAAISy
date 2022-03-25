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
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
		:effect (and
			(ontable ?x)
			(clear ?x)
			(handempty)
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?x)
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(clear ?y)
			(clear ?x)
			(ontable ?y)
			(not (on ?y ?x))
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (on ?x ?y))
			(clear ?x)
			(holding ?x)
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(not (clear ?y))
			(not (clear ?x))
			(holding ?x)
			(on ?y ?x)
			(not (handempty))
			
		)
   )
)


;; 
;; stack action has changed: (clear ?y), (handempty), (on ?y ?x), (on ?y ?x), (ontable ?x), (holding ?x), (on ?x ?y), (ontable ?y), 
;; unstack action has changed: (ontable ?x), (ontable ?y), (on ?y ?x), (on ?x ?y), (clear ?y), (on ?x ?y), (holding ?x), 
;; put-down action has changed: (handempty), (clear ?x), (holding ?x), 
;; pick-up action has changed: (holding ?x), (handempty), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
