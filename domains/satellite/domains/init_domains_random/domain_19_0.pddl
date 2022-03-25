
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
			
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          (on_board ?i ?s)
			(not (power_avail ?s))
			(not (calibrated ?i))
			
     )
   :effect (and
          (power_on ?i)
			(not (power_avail ?s))
			(not (calibrated ?i))
			
     )        
  )

 
  (:action switch_off
   :parameters (?i - instrument ?s - satellite)
   :precondition (and 
          (not (power_on ?i))
			(on_board ?i ?s)
			(power_avail ?s)
			(not (calibrated ?i))
			
     )
   :effect (and 
          (not (power_on ?i))
			(on_board ?i ?s)
			(power_avail ?s)
			(not (calibrated ?i))
			
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          (not (power_on ?i))
			(pointing ?s ?d)
			(calibration_target ?i ?d)
			(not (calibrated ?i))
			(on_board ?i ?s)
			
     )
   :effect (and 
          (power_on ?i)
			(not (calibrated ?i))
			(on_board ?i ?s)
			
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          (not (power_on ?i))
			(supports ?i ?m)
			(not (calibration_target ?i ?d))
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (supports ?i ?m))
			(not (pointing ?s ?d))
			(have_image ?d ?m)
			
     )
  )
)


;; 
;; take_image action has changed: (power_on ?i), (calibrated ?i), (pointing ?s ?d), (supports ?i ?m), (pointing ?s ?d), (calibration_target ?i ?d), 
;; switch_off action has changed: (power_on ?i), (calibrated ?i), (calibrated ?i), (on_board ?i ?s), (power_avail ?s), 
;; calibrate action has changed: (calibrated ?i), (power_on ?i), (on_board ?i ?s), (power_on ?i), (calibrated ?i), 
;; turn_to action has changed: (pointing ?s ?d_new), 
;; switch_on action has changed: (power_avail ?s), (calibrated ?i), 
;; Last_reduced_capability_num_dropped_pals: None

