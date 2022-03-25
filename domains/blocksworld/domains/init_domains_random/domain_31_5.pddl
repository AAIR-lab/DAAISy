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
			(not (holding ?x))
			(clear ?x)
			
		)
		:effect (and
			(ontable ?x)
			(not (holding ?x))
			(not (clear ?x))
			(not (handempty))
			
		)
  )
  (:action put-down
		:parameters (?x - block)
		:precondition (and
			(not (clear ?x))
			(not (handempty))
			
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
			(not (on ?x ?y))
			(ontable ?y)
			(on ?y ?x)
			
		)
		:effect (and
			(clear ?y)
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?y))
			(not (on ?y ?x))
			(ontable ?x)
			(handempty)
			
		)
	)
  (:action unstack
		:parameters (?x - block ?y - block)
		:precondition (and
			(clear ?y)
			(not (holding ?x))
			(not (ontable ?y))
			(ontable ?x)
			
		)
		:effect (and
			(clear ?y)
			(not (holding ?y))
			(not (on ?x ?y))
			(clear ?x)
			(not (holding ?x))
			(not (ontable ?x))
			(not (handempty))
			
		)
   )
)


;; 
;; pick-up action has changed: (holding ?x), (handempty), (ontable ?x), (holding ?x), (ontable ?x), 
;; unstack action has changed: (clear ?x), (holding ?x), (ontable ?x), (holding ?y), (clear ?x), (clear ?y), (on ?x ?y), (handempty), (ontable ?y), (holding ?x), (ontable ?x), 
;; stack action has changed: (ontable ?y), (ontable ?x), (on ?y ?x), (on ?x ?y), (on ?x ?y), (clear ?y), (on ?y ?x), (ontable ?y), (holding ?x), (clear ?y), 
;; put-down action has changed: (handempty), (holding ?x), (handempty), (clear ?x), (ontable ?x), 
;; Last_reduced_capability_num_dropped_pals: None
