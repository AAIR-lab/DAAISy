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
			(have_rock_analysis ?x ?z)
			(available ?x)
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?y))
			(not (communicated_soil_data ?y))
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
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
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (empty ?s)
			(full ?s)
			(not (at_rock_sample ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (equipped_for_rock_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (empty ?y)
			(not (full ?y))
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
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (not (available ?r))
			(at ?r ?w)
			(equipped_for_soil_analysis ?r)
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
			(not (calibration_target ?i ?o))
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (have_soil_analysis ?r ?p))
			(have_image ?r ?o ?m)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_rock_sample ?p))
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(have_soil_analysis ?r ?y)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?r ?y)
			(not (can_traverse ?r ?x ?p))
			(visible ?y ?p)
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
               (channel_free ?l)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (at ?r ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (visible ?p ?y))
			(can_traverse ?r ?p ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			
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
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(visible_from ?o ?y)
			(not (can_traverse ?r ?y ?x))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(at_rock_sample ?x)
			(at ?r ?y)
			(not (available ?r))
			(visible_from ?o ?x)
			(communicated_soil_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; calibrate action has changed: (available ?r), (calibrated ?i ?r), (have_soil_analysis ?r ?w), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (at ?r ?w), 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?p), (at_soil_sample ?x), (at_soil_sample ?y), (at_soil_sample ?p), (can_traverse ?r ?p ?y), (communicated_soil_data ?p), (visible ?p ?y), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (visible ?x ?y), (have_soil_analysis ?r ?x), (available ?r), (visible ?y ?p), (at ?r ?p), (at ?r ?y), (can_traverse ?r ?x ?p), (at_soil_sample ?y), (visible ?p ?y), 
;; communicate_image_data action has changed: (channel_free ?l), (at_rock_sample ?x), (visible ?y ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (visible_from ?o ?y), (visible_from ?o ?x), (at_lander ?l ?x), (at_soil_sample ?x), (communicated_rock_data ?x), (communicated_soil_data ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (visible ?x ?y), (equipped_for_imaging ?r), (available ?r), (can_traverse ?r ?x ?y), (at ?r ?y), 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?y), (visible ?y ?x), (at ?r ?x), (visible ?p ?y), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?p), (at_soil_sample ?y), (communicated_rock_data ?p), (channel_free ?l), (visible ?p ?y), (available ?r), (visible ?y ?p), (at_soil_sample ?p), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), 
;; navigate action has changed: (have_rock_analysis ?x ?z), (at_rock_sample ?y), (have_soil_analysis ?x ?y), (at ?x ?y), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (equipped_for_soil_analysis ?x), (communicated_soil_data ?y), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (calibration_target ?i ?o), (at_rock_sample ?p), (equipped_for_imaging ?r), (calibrated ?i ?r), (calibrated ?i ?r), (at ?r ?p), (on_board ?i ?r), (supports ?i ?m), (at_rock_sample ?p), (have_soil_analysis ?r ?p), 
;; sample_soil action has changed: (available ?x), (at_rock_sample ?p), (empty ?s), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), 
;; sample_rock action has changed: (communicated_rock_data ?p), (empty ?s), (empty ?s), (full ?s), (have_soil_analysis ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

