
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
			(not (pointing ?s ?d_new))
			
     )
     :effect (and  
          (power_avail ?s)
			(pointing ?s ?d_prev)
			(pointing ?s ?d_new)
			
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          (not (power_on ?i))
			(on_board ?i ?s)
			(not (power_avail ?s))
			(calibrated ?i)
			
     )
   :effect (and
          (power_on ?i)
			(not (calibrated ?i))
			
     )        
  )

 
  (:action switch_off
   :parameters (?i - instrument ?s - satellite)
   :precondition (and 
          (not (on_board ?i ?s))
			(not (power_avail ?s))
			
     )
   :effect (and 
          (not (power_avail ?s))
			(not (calibrated ?i))
			
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          (not (power_on ?i))
			(not (power_avail ?s))
			(pointing ?s ?d)
			(not (on_board ?i ?s))
			
     )
   :effect (and 
          (power_on ?i)
			(not (power_avail ?s))
			(calibration_target ?i ?d)
			(not (on_board ?i ?s))
			
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          (supports ?i ?m)
			(not (pointing ?s ?d))
			(not (have_image ?d ?m))
			(calibrated ?i)
			(on_board ?i ?s)
			
     )
   :effect (and 
          (not (power_on ?i))
			(pointing ?s ?d)
			(not (calibration_target ?i ?d))
			
     )
  )
)


;; 
;; switch_on action has changed: (power_on ?i), (power_avail ?s), (calibrated ?i), (power_avail ?s), 
;; take_image action has changed: (have_image ?d ?m), (calibration_target ?i ?d), (pointing ?s ?d), (pointing ?s ?d), (have_image ?d ?m), (power_on ?i), (power_on ?i), 
;; calibrate action has changed: (calibration_target ?i ?d), (on_board ?i ?s), (power_on ?i), (power_avail ?s), (power_avail ?s), (on_board ?i ?s), (power_on ?i), (calibrated ?i), (calibration_target ?i ?d), 
;; turn_to action has changed: (pointing ?s ?d_prev), (pointing ?s ?d_new), (power_avail ?s), 
;; switch_off action has changed: (power_avail ?s), (power_on ?i), (power_on ?i), (calibrated ?i), (on_board ?i ?s), (power_avail ?s), 
;; Last_reduced_capability_num_dropped_pals: None

