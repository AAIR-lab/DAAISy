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
			(not (ontable ?x))
			(clear ?x)
			(handempty)
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (ontable ?x))
			
		)
		:effect (and
			(ontable ?x)
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action stack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (on ?x ?y))
			(not (holding ?x))
			(not (on ?y ?x))
			(not (ontable ?x))
			
		)
		:effect (and
			(not (clear ?y))
			(clear ?x)
			(not (handempty))
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(on ?x ?y)
			(clear ?x)
			(on ?y ?x)
			(not (ontable ?x))
			
		)
		:effect (and
			(clear ?y)
			(not (on ?x ?y))
			(not (clear ?x))
			(not (holding ?x))
			(not (ontable ?y))
			
		)
   )
)


;; 
;; pick-up action has changed: (clear ?x), (holding ?x), (clear ?x), (handempty), (ontable ?x), 
;; unstack action has changed: (holding ?x), (on ?y ?x), (handempty), (ontable ?x), (ontable ?y), (handempty), 
;; put-down action has changed: (holding ?x), (holding ?x), (clear ?x), (ontable ?x), (handempty), 
;; stack action has changed: (holding ?x), (ontable ?x), (on ?y ?x), (on ?x ?y), (on ?x ?y), (handempty), (holding ?x), 
;; Last_reduced_capability_num_dropped_pals: None
