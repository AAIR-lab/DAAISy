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
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (available ?x)
			(at ?x ?y)
			(at_soil_sample ?z)
			(not (equipped_for_rock_analysis ?x))
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (full ?s))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
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
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(full ?y)
			
          )
        :effect (and 
               (empty ?y)
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
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(available ?r)
			(not (at ?r ?w))
			(visible_from ?t ?w)
			
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
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(visible_from ?o ?p)
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
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
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(communicated_soil_data ?p)
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (at ?r ?p))
			(can_traverse ?r ?x ?y)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			
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
			(not (equipped_for_imaging ?r))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(have_rock_analysis ?r ?p)
			(not (at_lander ?l ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			
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
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(visible ?x ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(visible_from ?o ?y)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?x ?y)
			(at_lander ?l ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; calibrate action has changed: (calibrated ?i ?r), (at ?r ?w), (at ?r ?w), (at_soil_sample ?w), (calibration_target ?i ?t), (visible_from ?t ?w), (available ?r), 
;; communicate_image_data action has changed: (equipped_for_imaging ?r), (visible ?y ?x), (at_lander ?l ?y), (equipped_for_imaging ?r), (at ?r ?y), (visible_from ?o ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (have_image ?r ?o ?m), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (visible ?y ?x), (visible ?x ?y), (communicated_rock_data ?y), (at_rock_sample ?x), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), 
;; communicate_rock_data action has changed: (at ?r ?y), (at_lander ?l ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (visible ?x ?y), (visible ?p ?y), (can_traverse ?r ?y ?p), (at_soil_sample ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?x), (can_traverse ?r ?p ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (at_rock_sample ?p), (at_lander ?l ?p), (channel_free ?l), (at ?r ?x), (communicated_soil_data ?y), (visible ?p ?x), (communicated_rock_data ?p), 
;; take_image action has changed: (calibrated ?i ?r), (on_board ?i ?r), (on_board ?i ?r), (calibration_target ?i ?o), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (at ?r ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (full ?s), (available ?x), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), 
;; communicate_soil_data action has changed: (communicated_rock_data ?p), (can_traverse ?r ?x ?y), (channel_free ?l), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (available ?r), (visible ?y ?x), (visible ?y ?p), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (at_lander ?l ?x), (visible ?p ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?p), (at ?r ?p), (at_lander ?l ?y), (communicated_rock_data ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (at ?r ?y), (communicated_soil_data ?p), (can_traverse ?r ?y ?p), (at_soil_sample ?y), (visible ?y ?x), (at_soil_sample ?y), (visible ?p ?x), (have_rock_analysis ?r ?x), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (available ?x), (available ?x), (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (at_soil_sample ?z), (at ?x ?y), (at_soil_sample ?z), (at ?x ?z), 
;; sample_rock action has changed: (full ?s), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (available ?x), (communicated_soil_data ?p), 
;; drop action has changed: (equipped_for_imaging ?x), (store_of ?y ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

