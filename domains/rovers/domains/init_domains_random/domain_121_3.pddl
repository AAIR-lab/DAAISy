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
               (not (available ?x))
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			
          )
          :effect (and 
               (available ?x)
			(not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?s)
			(full ?s)
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			
          )
        :effect (and 
               (equipped_for_rock_analysis ?x)
			(full ?y)
			
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
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(at ?r ?w)
			(on_board ?i ?r)
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
			(have_image ?r ?o ?m)
			(equipped_for_imaging ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(equipped_for_imaging ?r)
			(not (at_rock_sample ?p))
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
			(equipped_for_imaging ?r)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
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
               (channel_free ?l)
			(not (visible ?y ?x))
			(not (visible ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (available ?r))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?p))
			(not (have_rock_analysis ?r ?x))
			(visible ?x ?p)
			(visible ?y ?p)
			
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
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at_rock_sample ?y), (visible ?x ?y), (visible ?x ?p), (at_lander ?l ?x), (visible ?y ?x), (at_rock_sample ?p), (visible ?y ?x), (communicated_soil_data ?p), (channel_free ?l), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (available ?r), (have_rock_analysis ?r ?p), (visible ?y ?p), (visible ?x ?p), 
;; communicate_image_data action has changed: (at ?r ?y), (visible ?y ?x), (have_image ?r ?o ?m), (can_traverse ?r ?y ?x), (communicated_soil_data ?x), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (visible_from ?o ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (available ?r), (communicated_soil_data ?x), 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (visible ?y ?p), (at ?r ?y), (visible ?x ?y), (visible ?x ?p), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (at_soil_sample ?p), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (at_soil_sample ?y), (at_rock_sample ?p), (can_traverse ?r ?p ?y), (available ?r), (visible ?p ?x), (at ?r ?y), (at_rock_sample ?p), (at_lander ?l ?x), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (visible ?y ?p), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (communicated_rock_data ?x), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (at ?r ?x), (can_traverse ?r ?x ?y), 
;; navigate action has changed: (available ?x), (have_soil_analysis ?x ?z), (visible ?y ?z), (can_traverse ?x ?z ?y), (at ?x ?z), (equipped_for_rock_analysis ?x), (communicated_rock_data ?z), (available ?x), (communicated_soil_data ?z), (have_soil_analysis ?x ?z), (visible ?z ?y), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), (at_rock_sample ?y), 
;; sample_rock action has changed: (at_rock_sample ?p), (store_of ?s ?x), (full ?s), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (available ?x), (communicated_soil_data ?p), (available ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), 
;; calibrate action has changed: (on_board ?i ?r), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?w), (at ?r ?w), 
;; take_image action has changed: (at ?r ?p), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (calibrated ?i ?r), (equipped_for_imaging ?r), (calibrated ?i ?r), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (at_rock_sample ?p), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (empty ?y), (full ?y), (full ?y), 
;; sample_soil action has changed: (at_rock_sample ?p), (at_soil_sample ?p), (available ?x), (communicated_rock_data ?p), (empty ?s), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

