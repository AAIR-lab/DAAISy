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
               (have_rock_analysis ?x ?z)
			(available ?x)
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(at ?x ?y)
			(not (at_soil_sample ?y))
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (available ?x)
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(can_traverse ?x ?y ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(at ?r ?w)
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (calibrated ?i ?r))
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (supports ?i ?m)
			(have_soil_analysis ?r ?p)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (equipped_for_rock_analysis ?r))
			(have_image ?r ?o ?m)
			(not (equipped_for_imaging ?r))
			(not (calibrated ?i ?r))
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
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
          )
    )
    
    (:action communicate_rock_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (channel_free ?l)
			(visible ?x ?y)
			(at ?r ?y)
			(available ?r)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?x))
			(not (visible ?x ?p))
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
               (channel_free ?l)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(at_lander ?l ?y)
			(communicated_soil_data ?y)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(at_rock_sample ?x)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(at ?r ?x)
			(have_rock_analysis ?r ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (have_soil_analysis ?r ?p), (on_board ?i ?r), (supports ?i ?m), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at ?r ?p), (at ?r ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), 
;; navigate action has changed: (communicated_rock_data ?z), (at_soil_sample ?y), (equipped_for_imaging ?x), (communicated_rock_data ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?y ?z), (at ?x ?z), (available ?x), (visible ?z ?y), (communicated_rock_data ?z), (at_rock_sample ?y), (at_rock_sample ?y), (communicated_soil_data ?y), 
;; communicate_rock_data action has changed: (can_traverse ?r ?p ?x), (can_traverse ?r ?p ?y), (communicated_soil_data ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (at ?r ?y), (at_lander ?l ?y), (communicated_rock_data ?p), (visible ?x ?y), (visible ?x ?p), (at_soil_sample ?x), (visible ?x ?p), (at_soil_sample ?p), (at_rock_sample ?p), (can_traverse ?r ?y ?p), (equipped_for_imaging ?r), (communicated_rock_data ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?p), 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (at ?r ?p), (can_traverse ?r ?y ?x), (visible ?x ?y), (at_lander ?l ?x), (visible ?x ?p), (can_traverse ?r ?p ?y), (visible ?x ?y), (at_rock_sample ?x), (communicated_soil_data ?p), (available ?r), (communicated_soil_data ?x), (visible ?p ?y), (at_rock_sample ?y), (visible ?p ?y), (at_soil_sample ?x), (communicated_soil_data ?p), (visible ?p ?x), (have_soil_analysis ?r ?x), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (full ?y), (store_of ?y ?x), (store_of ?y ?x), (full ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (empty ?y), 
;; communicate_image_data action has changed: (equipped_for_imaging ?r), (at ?r ?x), (have_rock_analysis ?r ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (communicated_rock_data ?y), (visible_from ?o ?x), (have_image ?r ?o ?m), (at_rock_sample ?x), (at ?r ?x), (visible ?y ?x), (at_rock_sample ?y), 
;; sample_soil action has changed: (at ?x ?p), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (at_rock_sample ?p), (empty ?s), (available ?x), (communicated_rock_data ?p), 
;; calibrate action has changed: (communicated_rock_data ?w), (calibration_target ?i ?t), (equipped_for_imaging ?r), (at ?r ?w), (calibrated ?i ?r), (calibrated ?i ?r), (on_board ?i ?r), (communicated_soil_data ?w), (communicated_soil_data ?w), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), 
;; sample_rock action has changed: (empty ?s), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

