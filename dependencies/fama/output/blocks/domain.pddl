(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?o1  - block ?o2 - block)
	       (ontable ?o1  - block)
	       (clear ?o1  - block)
	       (handempty)
	       (holding ?o1 - block)
	       )

  (:action pick-up
	     :parameters (?o1  - block )
	     :precondition (and (clear ?o1) (ontable ?o1) (handempty))
	     :effect
	     (and (not (ontable ?o1))
		   (not (clear ?o1))
		   (not (handempty))
		   (holding ?o1)))

  (:action put-down
	     :parameters (?o1 - block )
	     :precondition (holding ?o1)
	     :effect
	     (and (not (holding ?o1))
		   (clear ?o1)
		   (handempty)
		   (ontable ?o1)))

  (:action stack
	     :parameters (?o1 - block ?o2 - block)
	     :precondition (and (holding ?o1) (clear ?o2))
	     :effect
	     (and (not (holding ?o1))
		   (not (clear ?o2))
		   (clear ?o1)
		   (handempty)
		   (on ?o1 ?o2)))

  (:action unstack
	     :parameters (?o1 - block ?o2 - block)
	     :precondition (and (on ?o1 ?o2) (clear ?o1) (handempty))
	     :effect
	     (and (holding ?o1)
		   (clear ?o2)
		   (not (clear ?o1))
		   (not (handempty))
		   (not (on ?o1 ?o2)))))
