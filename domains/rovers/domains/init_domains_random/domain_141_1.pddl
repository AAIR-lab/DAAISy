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
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(at ?x ?y)
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			
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
			(full ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(full ?y)
			
          )
        :effect (and 
               (available ?x)
			(not (store_of ?y ?x))
			(not (empty ?y))
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (available ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(on_board ?i ?r)
			(not (visible_from ?t ?w))
			(not (communicated_soil_data ?w))
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
			(not (equipped_for_rock_analysis ?r))
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(available ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
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
               (channel_free ?l)
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(at_rock_sample ?p)
			(not (have_rock_analysis ?r ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
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
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(visible ?p ?x)
			(at ?r ?p)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			
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
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (have_soil_analysis ?r ?y))
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; navigate action has changed: (at_rock_sample ?y), (communicated_soil_data ?y), (at_rock_sample ?y), (equipped_for_soil_analysis ?x), (communicated_rock_data ?y), (visible ?z ?y), (at ?x ?y), (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (communicated_rock_data ?z), (have_rock_analysis ?x ?y), (at ?x ?z), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (available ?x), (full ?s), (at_soil_sample ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (empty ?s), (full ?s), 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (at ?r ?y), (can_traverse ?r ?x ?y), (visible ?p ?x), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?p), (at_rock_sample ?x), (at_soil_sample ?p), (communicated_soil_data ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (at_rock_sample ?p), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?x), (communicated_soil_data ?y), (visible ?p ?y), (at ?r ?x), (visible ?x ?y), (communicated_rock_data ?y), (communicated_soil_data ?p), (at_soil_sample ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (visible ?y ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (visible ?x ?p), 
;; calibrate action has changed: (calibration_target ?i ?t), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (on_board ?i ?r), (visible_from ?t ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (communicated_soil_data ?w), (available ?r), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?y), (at_rock_sample ?x), (visible ?x ?y), (can_traverse ?r ?x ?y), (visible_from ?o ?y), (have_soil_analysis ?r ?x), (visible ?y ?x), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (communicated_rock_data ?x), (visible_from ?o ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (have_image ?r ?o ?m), 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (visible ?p ?x), (visible ?x ?y), (at_soil_sample ?y), (visible ?y ?x), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?x), (at ?r ?x), (at_lander ?l ?p), (channel_free ?l), (visible ?y ?p), (can_traverse ?r ?y ?p), (at ?r ?y), (at ?r ?p), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (communicated_soil_data ?x), (available ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (visible ?y ?p), (at_lander ?l ?x), (have_soil_analysis ?r ?p), 
;; drop action has changed: (available ?x), (store_of ?y ?x), (available ?x), (full ?y), (equipped_for_imaging ?x), (empty ?y), 
;; sample_soil action has changed: (at_soil_sample ?p), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (available ?x), 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (calibration_target ?i ?o), (at_soil_sample ?p), (available ?r), (supports ?i ?m), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (calibrated ?i ?r), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (communicated_image_data ?o ?m), 
;; Last_reduced_capability_num_dropped_pals: None

