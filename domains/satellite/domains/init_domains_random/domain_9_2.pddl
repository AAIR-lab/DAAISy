
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
          (not (power_avail ?s))
			(not (pointing ?s ?d_prev))
			(pointing ?s ?d_new)
			
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          (power_on ?i)
			(on_board ?i ?s)
			(not (power_avail ?s))
			
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
          (power_on ?i)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (power_on ?i))
			(on_board ?i ?s)
			(power_avail ?s)
			
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          (power_on ?i)
			(pointing ?s ?d)
			(calibration_target ?i ?d)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (calibrated ?i))
			
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          (not (power_on ?i))
			(pointing ?s ?d)
			(not (calibration_target ?i ?d))
			(calibrated ?i)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (power_avail ?s))
			(have_image ?d ?m)
			
     )
  )
)


;; 
;; switch_off action has changed: (on_board ?i ?s), 
;; take_image action has changed: (power_avail ?s), (supports ?i ?m), (power_on ?i), (calibration_target ?i ?d), 
;; switch_on action has changed: (power_on ?i), (power_avail ?s), 
;; turn_to action has changed: (power_avail ?s), 
;; calibrate action has changed: (calibrated ?i), 
;; Last_reduced_capability_num_dropped_pals: None

