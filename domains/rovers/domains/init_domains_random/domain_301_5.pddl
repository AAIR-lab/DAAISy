(define (domain Rover)
    (:requirements :typing)
    (:types rover waypoint store camera mode lander objective)
    
    (:predicates (at ?x - rover ?y - waypoint) 
                 (at_lander ?x - lander ?y - waypoint)
                 (can_traverse ?r - rover ?x - waypoint ?y - waypoint)
                 (equipped_for_soil_analysis ?r - rover)
                 (equipped_for_rock_analysis ?r - rover)
                 (equipped_for_imaging ?r - rover)
                 (empty ?s - store)
                 (have_rock_analysis ?r - rover ?w - waypoint)
                 (have_soil_analysis ?r - rover ?w - waypoint)
                 (full ?s - store)
                 (calibrated ?c - camera ?r - rover) 
                 (supports ?c - camera ?m - mode)
                 (available ?r - rover)
                 (visible ?w - waypoint ?p - waypoint)
                 (have_image ?r - rover ?o - objective ?m - mode)
                 (communicated_soil_data ?w - waypoint)
                 (communicated_rock_data ?w - waypoint)
                 (communicated_image_data ?o - objective ?m - mode)
                 (at_soil_sample ?w - waypoint)
                 (at_rock_sample ?w - waypoint)
                 (visible_from ?o - objective ?w - waypoint)
                 (store_of ?s - store ?r - rover)
                 (calibration_target ?i - camera ?o - objective)
                 (on_board ?i - camera ?r - rover)
                 (channel_free ?l - lander)
    )
    
    (:action navigate
        :parameters (?x - rover 
                     ?y - waypoint 
                     ?z - waypoint) 
        :precondition (and 
               (not (at_rock_sample ?z))
			(have_rock_analysis ?x ?z)
			(available ?x)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(available ?x)
			(visible ?z ?y)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(have_rock_analysis ?x ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(equipped_for_soil_analysis ?r)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(communicated_image_data ?o ?m)
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?p ?x))
			
          )
    )
    
    (:action communicate_image_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?o - objective 
                      ?m - mode 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
          )
    )

)

;; 
;; take_image action has changed: (communicated_image_data ?o ?m), (at_rock_sample ?p), (at ?r ?p), (at ?r ?p), (at_soil_sample ?p), (calibration_target ?i ?o), (have_image ?r ?o ?m), (calibrated ?i ?r), (visible_from ?o ?p), (on_board ?i ?r), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (supports ?i ?m), (supports ?i ?m), (equipped_for_imaging ?r), (at_rock_sample ?p), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), (calibrated ?i ?r), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (communicated_rock_data ?y), (available ?r), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (at_rock_sample ?y), (at_soil_sample ?y), (communicated_soil_data ?x), (at_lander ?l ?p), (visible ?p ?x), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (available ?r), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?y), (visible ?p ?x), (at_soil_sample ?p), (at_soil_sample ?y), (at_soil_sample ?x), (at ?r ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (visible ?y ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (at_soil_sample ?x), (at_rock_sample ?p), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?p), (at_rock_sample ?p), (visible ?p ?y), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (at_lander ?l ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (visible ?x ?p), (communicated_soil_data ?y), (visible ?x ?y), (visible ?p ?y), (visible ?x ?y), (visible ?x ?p), (channel_free ?l), (at_soil_sample ?p), (at ?r ?p), 
;; navigate action has changed: (have_soil_analysis ?x ?y), (at_rock_sample ?z), (at_soil_sample ?y), (at_soil_sample ?z), (communicated_rock_data ?z), (at ?x ?y), (can_traverse ?x ?z ?y), (equipped_for_imaging ?x), (have_rock_analysis ?x ?z), (at ?x ?y), (have_rock_analysis ?x ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?y ?z), (can_traverse ?x ?y ?z), (visible ?z ?y), (visible ?z ?y), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (visible ?y ?z), (available ?x), (visible ?y ?z), (at_rock_sample ?y), (communicated_soil_data ?z), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?y), (at ?x ?z), (communicated_soil_data ?y), (communicated_rock_data ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?y), (equipped_for_soil_analysis ?x), (at ?x ?z), (communicated_rock_data ?y), 
;; sample_soil action has changed: (full ?s), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (store_of ?s ?x), (communicated_soil_data ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (full ?s), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (empty ?s), (available ?x), (store_of ?s ?x), (available ?x), (have_rock_analysis ?x ?p), 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?p), (visible ?x ?y), (at_lander ?l ?x), (visible ?p ?y), (available ?r), (visible ?p ?x), (at_soil_sample ?y), (communicated_soil_data ?x), (at_soil_sample ?p), (communicated_rock_data ?p), (visible ?y ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (at_rock_sample ?p), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (available ?r), (can_traverse ?r ?y ?p), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (visible ?x ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (visible ?y ?p), (visible ?p ?x), (communicated_rock_data ?p), (visible ?x ?p), (at ?r ?p), (visible ?y ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (can_traverse ?r ?p ?y), (at_soil_sample ?y), (can_traverse ?r ?y ?p), (visible ?p ?y), (channel_free ?l), (can_traverse ?r ?x ?y), (at ?r ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (communicated_rock_data ?x), (visible ?x ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?x), (at ?r ?y), (at ?r ?x), (communicated_soil_data ?y), (at_rock_sample ?p), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (at_lander ?l ?x), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?y), (visible_from ?o ?x), (equipped_for_soil_analysis ?r), (visible ?y ?x), (at ?r ?y), (communicated_rock_data ?x), (visible ?x ?y), (at_soil_sample ?x), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (have_image ?r ?o ?m), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (at_rock_sample ?x), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (at_lander ?l ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (at_soil_sample ?y), (communicated_soil_data ?x), (at_rock_sample ?y), (at_lander ?l ?x), (communicated_image_data ?o ?m), (at ?r ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (channel_free ?l), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?x), (at ?r ?x), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), 
;; calibrate action has changed: (equipped_for_imaging ?r), (communicated_rock_data ?w), (at_soil_sample ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (calibrated ?i ?r), (at ?r ?w), (at ?r ?w), (communicated_soil_data ?w), (available ?r), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (visible_from ?t ?w), (equipped_for_imaging ?r), 
;; sample_rock action has changed: (communicated_rock_data ?p), (at_rock_sample ?p), (full ?s), (equipped_for_imaging ?x), (at ?x ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (empty ?s), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (empty ?s), (at ?x ?p), (full ?s), (store_of ?s ?x), (available ?x), 
;; drop action has changed: (full ?y), (equipped_for_soil_analysis ?x), (empty ?y), (full ?y), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (available ?x), (empty ?y), (available ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

