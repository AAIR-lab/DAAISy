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
			(not (at ?x ?y))
			(not (communicated_soil_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (available ?x)
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			
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
               (not (at ?x ?p))
			(not (empty ?s))
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(empty ?y)
			(equipped_for_soil_analysis ?x)
			(full ?y)
			
          )
        :effect (and 
               (store_of ?y ?x)
			(empty ?y)
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
			(equipped_for_rock_analysis ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
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
               (on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
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
               (not (channel_free ?l))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?x))
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(can_traverse ?r ?y ?p)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
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
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (not (visible ?x ?y))
			(at_rock_sample ?x)
			(available ?r)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?r))
			
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
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(visible ?x ?y)
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?x), (visible ?y ?p), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (channel_free ?l), (visible ?p ?y), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (visible ?x ?p), (visible ?x ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?p), (at ?r ?y), (at_rock_sample ?y), (at_rock_sample ?x), (equipped_for_imaging ?r), (visible ?p ?x), 
;; navigate action has changed: (have_soil_analysis ?x ?z), (visible ?z ?y), (available ?x), (equipped_for_imaging ?x), (communicated_soil_data ?y), (at ?x ?y), (communicated_soil_data ?z), (at ?x ?z), (equipped_for_rock_analysis ?x), (visible ?y ?z), (communicated_rock_data ?y), (equipped_for_rock_analysis ?x), 
;; take_image action has changed: (calibration_target ?i ?o), (supports ?i ?m), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), 
;; communicate_rock_data action has changed: (can_traverse ?r ?y ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (visible ?x ?y), (have_soil_analysis ?r ?x), (available ?r), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (at ?r ?p), 
;; sample_soil action has changed: (store_of ?s ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (empty ?s), (communicated_rock_data ?p), (store_of ?s ?x), 
;; communicate_image_data action has changed: (at_lander ?l ?y), (have_soil_analysis ?r ?x), (visible ?x ?y), (visible ?y ?x), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (visible_from ?o ?x), (at ?r ?x), (visible_from ?o ?x), (communicated_soil_data ?y), 
;; calibrate action has changed: (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), (equipped_for_imaging ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), 
;; sample_rock action has changed: (full ?s), (equipped_for_rock_analysis ?x), (at ?x ?p), (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), 
;; drop action has changed: (store_of ?y ?x), (empty ?y), (equipped_for_soil_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

