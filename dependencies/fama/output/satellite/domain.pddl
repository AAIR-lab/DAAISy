
(define (domain satellite)
  (:requirements :strips :equality :typing)
  (:types satellite direction instrument mode)
 (:predicates
           (on-board ?o1 - instrument ?o2 - satellite)
	       (supports ?o1 - instrument ?o2 - mode)
	       (pointing ?o1 - satellite ?o2 - direction)
	       (power-avail ?o1 - satellite)
	       (power-on ?o1 - instrument)
	       (calibrated ?o1 - instrument)
	       (have-image ?o1 - direction ?o2 - mode)
	       (calibration-target ?o1 - instrument ?o2 - direction))



  (:action turn-to
   :parameters (?o1 - satellite ?o2 - direction ?o3 - direction)
   :precondition (and (pointing ?o1 ?o3)

              )
   :effect (and  (pointing ?o1 ?o2)
                 (not (pointing ?o1 ?o3))
           )
  )


  (:action switch-on
   :parameters (?o1 - instrument ?o2 - satellite)

   :precondition (and (on-board ?o1 ?o2)
                      (power-avail ?o2)
                 )
   :effect (and (power-on ?o1)
                (not (calibrated ?o1))
                (not (power-avail ?o2))
           )

  )


  (:action switch-off
   :parameters (?o1 - instrument ?o2 - satellite)

   :precondition (and (on-board ?o1 ?o2)
                      (power-on ?o1)
                  )
   :effect (and (not (power-on ?o1))
                (power-avail ?o2)
           )
  )

  (:action calibrate
   :parameters (?o1 - satellite ?o2 - instrument ?o3 - direction)
   :precondition (and (on-board ?o2 ?o1)
		      (calibration-target ?o2 ?o3)
                      (pointing ?o1 ?o3)
                      (power-on ?o2)
                  )
   :effect (calibrated ?o2)
  )


  (:action take-image
   :parameters (?o1 - satellite ?o2 - direction ?o3 - instrument ?o4 - mode)
   :precondition (and (calibrated ?o3)
                      (on-board ?o3 ?o1)
                      (supports ?o3 ?o4)
                      (power-on ?o3)
                      (pointing ?o1 ?o2)
                      (power-on ?o3)
               )
   :effect (have-image ?o2 ?o4)
  )
)
