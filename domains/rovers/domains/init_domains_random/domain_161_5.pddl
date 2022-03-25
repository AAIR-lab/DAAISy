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
               (available ?x)
			(visible ?z ?y)
			(at ?x ?y)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (available ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at_soil_sample ?z))
			(communicated_soil_data ?y)
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(not (full ?y))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?y)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
			
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
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			
          )
         :effect (and 
               (equipped_for_soil_analysis ?r)
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
			(not (calibration_target ?i ?o))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(have_rock_analysis ?r ?p)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_rock_data ?p)
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
               (visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (at_soil_sample ?p))
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?y))
			
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
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
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
               (visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(not (visible_from ?o ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (communicated_rock_data ?x), (visible_from ?o ?x), (channel_free ?l), (communicated_soil_data ?y), (communicated_rock_data ?x), (visible_from ?o ?y), (available ?r), (visible ?y ?x), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (communicated_rock_data ?y), (communicated_image_data ?o ?m), (available ?r), (visible_from ?o ?x), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?x), (visible ?y ?x), (channel_free ?l), (can_traverse ?r ?x ?y), (visible ?x ?y), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), 
;; communicate_rock_data action has changed: (equipped_for_imaging ?r), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (can_traverse ?r ?x ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (visible ?p ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (visible ?y ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (communicated_rock_data ?y), (communicated_soil_data ?x), (have_rock_analysis ?r ?p), (at_rock_sample ?x), (at ?r ?p), (communicated_rock_data ?p), (communicated_rock_data ?x), (at_lander ?l ?p), (have_soil_analysis ?r ?p), (channel_free ?l), (have_rock_analysis ?r ?y), (visible ?y ?x), (communicated_soil_data ?y), (at ?r ?p), (at_soil_sample ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (communicated_soil_data ?p), (visible ?p ?y), (visible ?x ?p), 
;; take_image action has changed: (communicated_rock_data ?p), (calibration_target ?i ?o), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (supports ?i ?m), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (calibrated ?i ?r), (at ?r ?p), (calibration_target ?i ?o), 
;; communicate_soil_data action has changed: (at_rock_sample ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (at_soil_sample ?p), (at ?r ?x), (at_rock_sample ?x), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?p), (visible ?y ?p), (channel_free ?l), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (at_lander ?l ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?y), (visible ?p ?x), (visible ?p ?y), (at ?r ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (communicated_soil_data ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (at ?r ?p), (communicated_soil_data ?y), (visible ?x ?y), (at_rock_sample ?x), (communicated_rock_data ?y), (communicated_rock_data ?p), (communicated_soil_data ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (can_traverse ?r ?p ?x), (available ?r), (at ?r ?y), 
;; calibrate action has changed: (available ?r), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), 
;; drop action has changed: (empty ?y), (full ?y), (equipped_for_soil_analysis ?x), (available ?x), 
;; navigate action has changed: (at_rock_sample ?y), (at ?x ?y), (equipped_for_soil_analysis ?x), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?y), (at ?x ?z), (visible ?y ?z), (communicated_rock_data ?y), (communicated_soil_data ?y), (equipped_for_rock_analysis ?x), (communicated_rock_data ?y), (at_soil_sample ?z), (visible ?z ?y), (available ?x), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (available ?x), (equipped_for_soil_analysis ?x), (full ?s), (at ?x ?p), (at ?x ?p), (communicated_rock_data ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (store_of ?s ?x), (empty ?s), (communicated_soil_data ?p), (at_soil_sample ?p), 
;; sample_soil action has changed: (store_of ?s ?x), (full ?s), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (empty ?s), (communicated_rock_data ?p), (equipped_for_imaging ?x), (at ?x ?p), (equipped_for_soil_analysis ?x), (empty ?s), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

