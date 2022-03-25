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
			(available ?x)
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(at_soil_sample ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (visible ?z ?y)
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (at ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(empty ?y)
			(full ?y)
			
          )
        :effect (and 
               (available ?x)
			(empty ?y)
			(not (equipped_for_soil_analysis ?x))
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
               (calibration_target ?i ?t)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(have_rock_analysis ?r ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(communicated_soil_data ?w)
			(calibrated ?i ?r)
			
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
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
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
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?p)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?p)
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
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
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
               (not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(communicated_soil_data ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(visible ?x ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; sample_rock action has changed: (full ?s), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (store_of ?s ?x), (available ?x), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (at_soil_sample ?p), 
;; communicate_soil_data action has changed: (visible ?p ?y), (can_traverse ?r ?y ?x), (communicated_soil_data ?p), (available ?r), (at ?r ?y), (at_soil_sample ?p), (at ?r ?p), (visible ?p ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (at_soil_sample ?y), (have_soil_analysis ?r ?p), (visible ?y ?x), (at_soil_sample ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (communicated_soil_data ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), 
;; take_image action has changed: (at_rock_sample ?p), (communicated_image_data ?o ?m), (supports ?i ?m), (calibration_target ?i ?o), (visible_from ?o ?p), (available ?r), (communicated_soil_data ?p), (calibration_target ?i ?o), (communicated_soil_data ?p), (on_board ?i ?r), (at ?r ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (at ?r ?p), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), 
;; communicate_rock_data action has changed: (communicated_rock_data ?y), (at_lander ?l ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?p), (visible ?p ?x), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (visible ?x ?p), (have_soil_analysis ?r ?x), (communicated_soil_data ?p), (at_lander ?l ?x), (visible ?p ?y), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?p), (communicated_soil_data ?x), (visible ?x ?p), (can_traverse ?r ?p ?y), (communicated_soil_data ?y), (at_soil_sample ?x), (channel_free ?l), (visible ?p ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (visible ?y ?p), (at ?r ?p), (equipped_for_rock_analysis ?r), 
;; sample_soil action has changed: (at_soil_sample ?p), (at_rock_sample ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (available ?x), 
;; navigate action has changed: (at_soil_sample ?z), (at_rock_sample ?y), (at_rock_sample ?z), (can_traverse ?x ?z ?y), (visible ?z ?y), (at ?x ?z), (communicated_soil_data ?y), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?y), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (visible ?z ?y), (communicated_rock_data ?z), (equipped_for_rock_analysis ?x), 
;; calibrate action has changed: (calibrated ?i ?r), (at_rock_sample ?w), (visible_from ?t ?w), (on_board ?i ?r), (equipped_for_imaging ?r), (at ?r ?w), (equipped_for_imaging ?r), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), 
;; communicate_image_data action has changed: (visible ?x ?y), (equipped_for_imaging ?r), (communicated_soil_data ?y), (communicated_rock_data ?x), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (communicated_soil_data ?x), (can_traverse ?r ?x ?y), (available ?r), (visible_from ?o ?y), (can_traverse ?r ?y ?x), (visible_from ?o ?x), (communicated_image_data ?o ?m), (visible ?y ?x), (at_soil_sample ?x), (channel_free ?l), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (channel_free ?l), (visible ?y ?x), 
;; drop action has changed: (empty ?y), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (available ?x), 
;; Last_reduced_capability_num_dropped_pals: None

