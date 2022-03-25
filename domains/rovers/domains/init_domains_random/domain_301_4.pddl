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
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(not (visible ?z ?y))
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(not (have_soil_analysis ?x ?z))
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(have_rock_analysis ?x ?z)
			(not (visible ?z ?y))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(have_soil_analysis ?x ?z)
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(equipped_for_imaging ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (empty ?y))
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (available ?x)
			(not (store_of ?y ?x))
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(equipped_for_imaging ?x)
			
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
			(equipped_for_imaging ?r)
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
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
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; calibrate action has changed: (equipped_for_imaging ?r), (communicated_soil_data ?w), (calibrated ?i ?r), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?w), (at ?r ?w), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (at ?r ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (calibration_target ?i ?t), (on_board ?i ?r), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (available ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (on_board ?i ?r), (communicated_soil_data ?w), (equipped_for_rock_analysis ?r), 
;; drop action has changed: (equipped_for_imaging ?x), (available ?x), (available ?x), (full ?y), (store_of ?y ?x), (empty ?y), (empty ?y), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), 
;; sample_soil action has changed: (available ?x), (equipped_for_imaging ?x), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (available ?x), (at ?x ?p), (empty ?s), (at ?x ?p), (empty ?s), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (full ?s), (at_soil_sample ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (store_of ?s ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), 
;; communicate_rock_data action has changed: (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (visible ?x ?y), (visible ?y ?p), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (at_soil_sample ?x), (at ?r ?p), (at_soil_sample ?y), (have_rock_analysis ?r ?p), (visible ?y ?p), (at_rock_sample ?y), (communicated_rock_data ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?p), (at ?r ?x), (visible ?p ?x), (have_rock_analysis ?r ?p), (visible ?p ?x), (channel_free ?l), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (at ?r ?y), (at_rock_sample ?x), (at_soil_sample ?p), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (at ?r ?p), (communicated_soil_data ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (visible ?y ?x), (available ?r), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (channel_free ?l), (visible ?p ?y), (at_soil_sample ?p), (available ?r), (communicated_soil_data ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?y), (communicated_soil_data ?y), (communicated_soil_data ?p), (can_traverse ?r ?p ?y), (communicated_rock_data ?x), (visible ?x ?p), (at_rock_sample ?x), (communicated_soil_data ?x), (visible ?p ?y), (communicated_rock_data ?p), (at ?r ?x), (can_traverse ?r ?y ?p), 
;; navigate action has changed: (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (available ?x), (communicated_rock_data ?z), (at ?x ?y), (at_soil_sample ?z), (communicated_rock_data ?y), (communicated_rock_data ?y), (at ?x ?y), (can_traverse ?x ?z ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (at ?x ?z), (visible ?z ?y), (have_soil_analysis ?x ?z), (communicated_soil_data ?y), (at_soil_sample ?z), (have_rock_analysis ?x ?z), (at_soil_sample ?y), (visible ?y ?z), (have_rock_analysis ?x ?z), (at_soil_sample ?y), (communicated_rock_data ?z), (can_traverse ?x ?y ?z), (at_rock_sample ?z), (at_rock_sample ?z), (visible ?z ?y), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), 
;; take_image action has changed: (visible_from ?o ?p), (available ?r), (at ?r ?p), (communicated_soil_data ?p), (calibration_target ?i ?o), (have_soil_analysis ?r ?p), (equipped_for_imaging ?r), (calibrated ?i ?r), (at_rock_sample ?p), (calibrated ?i ?r), (on_board ?i ?r), (on_board ?i ?r), (calibration_target ?i ?o), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (supports ?i ?m), (at_rock_sample ?p), (communicated_rock_data ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (have_rock_analysis ?r ?p), (at ?r ?p), (have_rock_analysis ?r ?p), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?y), (at_lander ?l ?p), (at_soil_sample ?y), (communicated_rock_data ?y), (can_traverse ?r ?p ?y), (at ?r ?x), (have_soil_analysis ?r ?p), (at_rock_sample ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?y), (visible ?x ?p), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?p), (at_lander ?l ?x), (at_lander ?l ?y), (visible ?x ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?y), (at ?r ?y), (communicated_rock_data ?x), (visible ?y ?x), (equipped_for_imaging ?r), (communicated_rock_data ?y), (visible ?x ?p), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (can_traverse ?r ?p ?x), (equipped_for_imaging ?r), (at_soil_sample ?x), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (at ?r ?x), (visible ?p ?x), (at ?r ?p), (at_rock_sample ?x), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (visible ?p ?y), (communicated_soil_data ?p), (visible ?p ?y), (channel_free ?l), (available ?r), (can_traverse ?r ?y ?p), (visible ?y ?p), (can_traverse ?r ?x ?y), (channel_free ?l), 
;; communicate_image_data action has changed: (communicated_soil_data ?x), (at ?r ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (at_lander ?l ?x), (at_lander ?l ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?x), (visible ?y ?x), (at_rock_sample ?x), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (at_soil_sample ?x), (at ?r ?y), (equipped_for_rock_analysis ?r), (at ?r ?x), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (visible ?x ?y), (visible ?y ?x), (visible_from ?o ?y), (equipped_for_imaging ?r), (visible ?x ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (visible_from ?o ?y), (visible_from ?o ?x), (at_soil_sample ?y), (communicated_image_data ?o ?m), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (communicated_rock_data ?x), (channel_free ?l), (communicated_soil_data ?x), (have_image ?r ?o ?m), (at_rock_sample ?x), (communicated_rock_data ?x), 
;; sample_rock action has changed: (empty ?s), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (at ?x ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (full ?s), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (available ?x), (empty ?s), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

