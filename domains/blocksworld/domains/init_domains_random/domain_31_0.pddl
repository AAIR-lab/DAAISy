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
			
		)
		:effect (and
			(not (ontable ?x))
			(holding ?x)
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(holding ?x)
			(not (clear ?x))
			
		)
		:effect (and
			(not (ontable ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(holding ?y)
			(on ?x ?y)
			(not (holding ?x))
			(ontable ?y)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (on ?y ?x))
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(handempty)
			
		)
		:effect (and
			(clear ?y)
			(holding ?y)
			(not (on ?x ?y))
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(handempty)
			
		)
   )
)


;; 
;; put-down action has changed: (ontable ?x), (holding ?x), (clear ?x), (clear ?x), (handempty), 
;; unstack action has changed: (ontable ?y), (holding ?x), (on ?x ?y), (clear ?x), (on ?y ?x), (ontable ?x), (on ?y ?x), (holding ?y), (clear ?x), (handempty), (holding ?x), (ontable ?y), 
;; stack action has changed: (ontable ?x), (ontable ?y), (holding ?y), (on ?y ?x), (handempty), (clear ?y), (on ?x ?y), (holding ?x), (holding ?x), (holding ?y), 
;; pick-up action has changed: (handempty), (ontable ?x), (clear ?x), (clear ?x), 
;; Last_reduced_capability_num_dropped_pals: None
