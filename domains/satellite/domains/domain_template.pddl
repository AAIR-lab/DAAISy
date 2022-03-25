
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
          %TURN_TO PRECONDITION%
     )
     :effect (and  
          %TURN_TO EFFECTS%
     )
  )

 
  (:action switch_on
   :parameters (?i - instrument ?s - satellite)
 
   :precondition (and 
          %SWITCH_ON PRECONDITION%
     )
   :effect (and
          %SWITCH_ON EFFECTS%
     )        
  )

 
  (:action switch_off
   :parameters (?i - instrument ?s - satellite)
   :precondition (and 
          %SWITCH_OFF PRECONDITION%
     )
   :effect (and 
          %SWITCH_OFF EFFECTS%
     )
  )

  (:action calibrate
   :parameters (?s - satellite ?i - instrument ?d - direction)
   :precondition (and 
          %CALIBRATE PRECONDITION%
     )
   :effect (and 
          %CALIBRATE EFFECTS%
     )
  )


  (:action take_image
   :parameters (?s - satellite ?d - direction ?i - instrument ?m - mode)
   :precondition (and 
          %TAKE_IMAGE PRECONDITION%
     )
   :effect (and 
          %TAKE_IMAGE EFFECTS%
     )
  )
)


;; %INFO_STRING%
