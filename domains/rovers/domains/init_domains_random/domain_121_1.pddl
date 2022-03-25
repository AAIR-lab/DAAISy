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
			(not (available ?x))
			(not (visible ?z ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(not (at ?x ?z))
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
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
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_rock_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (store_of ?y ?x)
			(empty ?y)
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
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(available ?r)
			(not (at ?r ?w))
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
               (not (have_soil_analysis ?r ?p))
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (calibrated ?i ?r))
			
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
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (visible ?p ?x)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
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
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?x ?y))
			(at ?r ?y)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?r ?y))
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
			(not (equipped_for_imaging ?r))
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(not (at ?r ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(equipped_for_soil_analysis ?r)
			(visible_from ?o ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?x), (visible ?p ?y), (equipped_for_imaging ?r), (at ?r ?y), (communicated_soil_data ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?x), (at_lander ?l ?y), (visible ?x ?y), (visible ?x ?p), (at_soil_sample ?x), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (at ?r ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?p), (visible ?x ?y), (at_rock_sample ?y), (channel_free ?l), (can_traverse ?r ?x ?y), 
;; communicate_soil_data action has changed: (visible ?p ?x), (communicated_soil_data ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (available ?r), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?x), (at_rock_sample ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (at ?r ?x), 
;; navigate action has changed: (have_rock_analysis ?x ?y), (can_traverse ?x ?z ?y), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (at ?x ?z), (at_rock_sample ?z), (at_soil_sample ?y), (visible ?y ?z), (at_rock_sample ?z), (at_soil_sample ?y), (at ?x ?y), (available ?x), (communicated_soil_data ?y), (at ?x ?z), (visible ?z ?y), (communicated_rock_data ?y), (have_soil_analysis ?x ?z), (communicated_rock_data ?y), (communicated_soil_data ?z), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (full ?s), (equipped_for_imaging ?x), (available ?x), (have_rock_analysis ?x ?p), (at_soil_sample ?p), 
;; take_image action has changed: (equipped_for_imaging ?r), (calibration_target ?i ?o), (visible_from ?o ?p), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (calibration_target ?i ?o), (have_image ?r ?o ?m), (have_rock_analysis ?r ?p), (supports ?i ?m), (available ?r), (on_board ?i ?r), (at_soil_sample ?p), (communicated_soil_data ?p), 
;; calibrate action has changed: (available ?r), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (at ?r ?w), (equipped_for_imaging ?r), (available ?r), 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (at ?x ?p), (at ?x ?p), (available ?x), (empty ?s), (communicated_soil_data ?p), (equipped_for_imaging ?x), 
;; communicate_image_data action has changed: (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (have_image ?r ?o ?m), (at_lander ?l ?y), (equipped_for_rock_analysis ?r), (visible_from ?o ?y), (at_rock_sample ?y), (communicated_rock_data ?x), (communicated_rock_data ?x), (visible_from ?o ?y), (at_rock_sample ?y), (at_soil_sample ?x), (visible_from ?o ?x), (channel_free ?l), (visible ?x ?y), (available ?r), (equipped_for_imaging ?r), (at ?r ?y), (at_soil_sample ?y), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

