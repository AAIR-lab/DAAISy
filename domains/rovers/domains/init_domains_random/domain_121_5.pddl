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
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (have_rock_analysis ?x ?z)
			(available ?x)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (visible ?y ?z))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
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
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (full ?y))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
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
               (not (supports ?i ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(equipped_for_soil_analysis ?r)
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
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
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (visible ?x ?p))
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(not (available ?r))
			(not (at_soil_sample ?p))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(communicated_rock_data ?y)
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
               (channel_free ?l)
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at ?r ?p)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			
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
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (at_lander ?l ?x))
			(at_soil_sample ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(not (available ?r))
			(not (visible_from ?o ?x))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(visible_from ?o ?y)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (communicated_image_data ?o ?m), (at_soil_sample ?y), (visible_from ?o ?x), (available ?r), (visible ?y ?x), (visible ?y ?x), (communicated_soil_data ?x), (visible_from ?o ?y), (available ?r), (communicated_image_data ?o ?m), (communicated_rock_data ?x), (communicated_rock_data ?x), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (visible_from ?o ?x), (equipped_for_imaging ?r), (at_lander ?l ?y), (at_soil_sample ?y), 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (visible ?p ?y), (visible ?y ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?y), (available ?r), (visible ?p ?y), (have_soil_analysis ?r ?x), (visible ?x ?p), (at_soil_sample ?x), (communicated_rock_data ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (at ?r ?p), (can_traverse ?r ?x ?p), (visible ?p ?x), (at_soil_sample ?p), (can_traverse ?r ?p ?x), (visible ?x ?y), (at_rock_sample ?y), (equipped_for_imaging ?r), 
;; communicate_rock_data action has changed: (at ?r ?p), (visible ?y ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?p ?x), (visible ?x ?p), (can_traverse ?r ?y ?p), (communicated_rock_data ?p), (have_rock_analysis ?r ?y), (communicated_soil_data ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (visible ?p ?y), (visible ?p ?y), (at_rock_sample ?p), (communicated_rock_data ?x), (at_soil_sample ?y), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), 
;; navigate action has changed: (have_soil_analysis ?x ?z), (at ?x ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (have_rock_analysis ?x ?y), (equipped_for_imaging ?x), (have_soil_analysis ?x ?y), (available ?x), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?y), (at_rock_sample ?y), (communicated_soil_data ?y), (visible ?z ?y), (at_soil_sample ?y), 
;; sample_rock action has changed: (equipped_for_imaging ?x), (available ?x), (at_soil_sample ?p), (available ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (full ?s), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (store_of ?s ?x), (available ?x), (empty ?s), (empty ?s), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), 
;; take_image action has changed: (supports ?i ?m), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (calibration_target ?i ?o), (communicated_rock_data ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (on_board ?i ?r), (supports ?i ?m), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (have_rock_analysis ?r ?w), (communicated_soil_data ?w), (visible_from ?t ?w), (calibrated ?i ?r), (at ?r ?w), (calibration_target ?i ?t), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (full ?y), (empty ?y), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

