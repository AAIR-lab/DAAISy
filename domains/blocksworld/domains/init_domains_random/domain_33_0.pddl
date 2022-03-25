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
			(handempty)
			
		)
		:effect (and
			(ontable ?x)
			(holding ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(clear ?x)
			
		)
		:effect (and
			(not (ontable ?x))
			(not (holding ?x))
			(clear ?x)
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(not (clear ?y))
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(holding ?x)
			(not (ontable ?y))
			(ontable ?x)
			(not (handempty))
			
		)
		:effect (and
			(not (holding ?y))
			(on ?x ?y)
			(clear ?x)
			(not (ontable ?y))
			(on ?y ?x)
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
			(not (on ?y ?x))
			
		)
		:effect (and
			(on ?x ?y)
			(holding ?x)
			(not (ontable ?y))
			(on ?y ?x)
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (handempty), (ontable ?x), (clear ?x), (ontable ?x), (clear ?x), 
;; stack action has changed: (clear ?x), (ontable ?x), (on ?x ?y), (ontable ?y), (holding ?x), (ontable ?y), (holding ?y), (clear ?y), (on ?y ?x), (handempty), (holding ?y), (handempty), (clear ?y), 
;; unstack action has changed: (on ?y ?x), (on ?x ?y), (clear ?y), (holding ?y), (ontable ?y), (clear ?x), (clear ?y), (clear ?x), (ontable ?x), (on ?y ?x), (handempty), 
;; put-down action has changed: (ontable ?x), (clear ?x), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
