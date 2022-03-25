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
			(not (have_rock_analysis ?x ?z))
			(visible ?z ?y)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(not (visible ?z ?y))
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (communicated_soil_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			
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
			(communicated_image_data ?o ?m)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(visible ?x ?p)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (have_rock_analysis ?r ?p), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (supports ?i ?m), (at_rock_sample ?p), (on_board ?i ?r), (communicated_image_data ?o ?m), (available ?r), (calibrated ?i ?r), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), (communicated_rock_data ?p), (on_board ?i ?r), (calibration_target ?i ?o), (visible_from ?o ?p), (at ?r ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (at_soil_sample ?p), (calibration_target ?i ?o), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (calibrated ?i ?r), (supports ?i ?m), (communicated_rock_data ?p), 
;; communicate_soil_data action has changed: (communicated_soil_data ?p), (communicated_rock_data ?x), (communicated_rock_data ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (visible ?p ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (channel_free ?l), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (visible ?y ?x), (at_rock_sample ?p), (at_soil_sample ?p), (visible ?x ?y), (communicated_rock_data ?y), (at ?r ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (visible ?y ?p), (have_soil_analysis ?r ?y), (at ?r ?x), (at_soil_sample ?x), (available ?r), (at_lander ?l ?y), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (visible ?x ?p), (communicated_soil_data ?y), (at_lander ?l ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?x), (visible ?p ?y), (visible ?y ?x), (at ?r ?p), (can_traverse ?r ?p ?y), (at ?r ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?p), (at_rock_sample ?p), (channel_free ?l), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (visible ?x ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?p), (at_rock_sample ?x), (at ?r ?y), (visible ?p ?y), (at_lander ?l ?y), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (available ?r), (at_lander ?l ?x), (at ?r ?y), 
;; sample_rock action has changed: (equipped_for_rock_analysis ?x), (full ?s), (empty ?s), (have_rock_analysis ?x ?p), (available ?x), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (at ?x ?p), (at ?x ?p), (communicated_soil_data ?p), (full ?s), (communicated_soil_data ?p), (store_of ?s ?x), (available ?x), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (at_soil_sample ?p), (have_soil_analysis ?x ?p), 
;; communicate_rock_data action has changed: (at ?r ?y), (communicated_rock_data ?y), (visible ?p ?y), (at ?r ?y), (at_rock_sample ?x), (visible ?x ?y), (at_lander ?l ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (visible ?x ?p), (available ?r), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (available ?r), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?y), (visible ?y ?p), (at ?r ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (at_rock_sample ?p), (visible ?y ?x), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?y), (at ?r ?x), (visible ?x ?y), (visible ?p ?x), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (channel_free ?l), (at_rock_sample ?p), (communicated_rock_data ?x), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (at_rock_sample ?y), (communicated_soil_data ?x), (have_rock_analysis ?r ?y), (communicated_rock_data ?p), (communicated_soil_data ?p), (visible ?x ?p), 
;; sample_soil action has changed: (full ?s), (at_rock_sample ?p), (available ?x), (store_of ?s ?x), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (empty ?s), (equipped_for_imaging ?x), (at_soil_sample ?p), (at_soil_sample ?p), (at ?x ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), 
;; calibrate action has changed: (at_soil_sample ?w), (calibrated ?i ?r), (communicated_soil_data ?w), (available ?r), (calibration_target ?i ?t), (at_soil_sample ?w), (on_board ?i ?r), (calibration_target ?i ?t), (equipped_for_rock_analysis ?r), (visible_from ?t ?w), (communicated_rock_data ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (at ?r ?w), (at ?r ?w), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), 
;; communicate_image_data action has changed: (visible ?y ?x), (at ?r ?x), (at_soil_sample ?y), (at_lander ?l ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?x), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (at_soil_sample ?x), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (available ?r), (can_traverse ?r ?y ?x), (have_image ?r ?o ?m), (at_lander ?l ?x), (visible ?x ?y), (channel_free ?l), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?x), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (visible_from ?o ?x), (at ?r ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (visible_from ?o ?x), (equipped_for_soil_analysis ?r), (available ?r), (visible ?y ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?y), (at ?r ?y), (at_rock_sample ?y), (channel_free ?l), (can_traverse ?r ?y ?x), (visible_from ?o ?y), (at_rock_sample ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), 
;; navigate action has changed: (communicated_soil_data ?y), (at ?x ?y), (have_soil_analysis ?x ?z), (can_traverse ?x ?z ?y), (communicated_rock_data ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?z), (visible ?z ?y), (at_rock_sample ?z), (visible ?y ?z), (at_rock_sample ?y), (equipped_for_rock_analysis ?x), (visible ?z ?y), (visible ?y ?z), (at_rock_sample ?y), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_soil_data ?z), (available ?x), (at_soil_sample ?y), (at ?x ?y), (have_soil_analysis ?x ?z), (have_soil_analysis ?x ?y), (can_traverse ?x ?y ?z), (at ?x ?z), (at_rock_sample ?z), (can_traverse ?x ?y ?z), (can_traverse ?x ?z ?y), (at ?x ?z), (communicated_soil_data ?z), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_rock_analysis ?x), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

