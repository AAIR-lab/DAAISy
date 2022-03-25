
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
          (power_avail ?s)
			(pointing ?s ?d_prev)
			(not (pointing ?s ?d_new))
			
     )
     :effect (and  
          (not (pointing ?s ?d_prev))
			(not (pointing ?s ?d_new))
			
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          (not (power_avail ?s))
			(calibrated ?i)
			
     )
   :effect (and
          (not (power_on ?i))
			(not (on_board ?i ?s))
			(not (power_avail ?s))
			(calibrated ?i)
			
     )        
  )

 
  (:action switch_off
   :parameters (?i - instrument ?s - satellite)
   :precondition (and 
          (not (power_on ?i))
			(on_board ?i ?s)
			(power_avail ?s)
			(calibrated ?i)
			
     )
   :effect (and 
          (not (power_on ?i))
			(not (on_board ?i ?s))
			(not (power_avail ?s))
			
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          (not (power_on ?i))
			(power_avail ?s)
			(not (pointing ?s ?d))
			(not (calibrated ?i))
			(on_board ?i ?s)
			
     )
   :effect (and 
          (power_on ?i)
			(pointing ?s ?d)
			(calibrated ?i)
			
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          (power_on ?i)
			(not (supports ?i ?m))
			(not (pointing ?s ?d))
			(not (calibration_target ?i ?d))
			(calibrated ?i)
			
     )
   :effect (and 
          (power_on ?i)
			(supports ?i ?m)
			(not (pointing ?s ?d))
			(have_image ?d ?m)
			(calibration_target ?i ?d)
			(calibrated ?i)
			(on_board ?i ?s)
			
     )
  )
)


;; 
;; take_image action has changed: (on_board ?i ?s), (pointing ?s ?d), (supports ?i ?m), (power_on ?i), (on_board ?i ?s), (calibration_target ?i ?d), (calibration_target ?i ?d), (calibrated ?i), (supports ?i ?m), (pointing ?s ?d), 
;; calibrate action has changed: (calibration_target ?i ?d), (power_avail ?s), (calibrated ?i), (power_on ?i), (pointing ?s ?d), (pointing ?s ?d), (power_on ?i), 
;; switch_on action has changed: (power_on ?i), (on_board ?i ?s), (calibrated ?i), (on_board ?i ?s), (power_avail ?s), (calibrated ?i), 
;; switch_off action has changed: (power_avail ?s), (on_board ?i ?s), (calibrated ?i), (power_avail ?s), (power_on ?i), 
;; turn_to action has changed: (pointing ?s ?d_new), (pointing ?s ?d_new), (power_avail ?s), 
;; Last_reduced_capability_num_dropped_pals: None

