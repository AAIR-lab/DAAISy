
(define (domain satellite)
  (:requirements :strips :equality :typing)
  (:types satellite direction instrument mode)
 (:predicates 
          (on_board ?i - instrument ?s - satellite)
	       (supports ?i - instrument ?m - mode)
	       (pointing ?s - satellite ?d - direction)
	       (power_avail ?s - satellite)
	       (power_on ?i - instrument)
	       (calibrated ?i - instrument)
	       (have_image ?d - direction ?m - mode)
	       (calibration_target ?i - instrument ?d - direction))
 
 

  (:action turn_to
   :parameters (?s - satellite ?d_new - direction ?d_prev - direction)
   :precondition (and 
          (pointing ?s ?d_prev)
			
     )
     :effect (and  
          (not (pointing ?s ?d_prev))
			(pointing ?s ?d_new)
			
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          (on_board ?i ?s)
			(power_avail ?s)
			
     )
   :effect (and
          (not (power_on ?i))
			(power_avail ?s)
			(not (calibrated ?i))
			
     )        
  )

 
  (:action switch_off
   :parameters (?i - instrument ?s - satellite)
   :precondition (and 
          (not (power_on ?i))
			
     )
   :effect (and 
          (not (on_board ?i ?s))
			(power_avail ?s)
			
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          (pointing ?s ?d)
			(calibration_target ?i ?d)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (pointing ?s ?d))
			(not (calibration_target ?i ?d))
			(calibrated ?i)
			
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          (power_on ?i)
			(supports ?i ?m)
			(pointing ?s ?d)
			(have_image ?d ?m)
			(calibrated ?i)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (supports ?i ?m)
			(have_image ?d ?m)
			(calibration_target ?i ?d)
			(not (calibrated ?i))
			
     )
  )
)


;; 
;; switch_off action has changed: (on_board ?i ?s), (power_on ?i), (on_board ?i ?s), (power_on ?i), 
;; calibrate action has changed: (power_on ?i), (calibration_target ?i ?d), (pointing ?s ?d), 
;; take_image action has changed: (have_image ?d ?m), (supports ?i ?m), (calibrated ?i), (calibration_target ?i ?d), 
;; switch_on action has changed: (power_avail ?s), (power_on ?i), 
;; Last_reduced_capability_num_dropped_pals: None

