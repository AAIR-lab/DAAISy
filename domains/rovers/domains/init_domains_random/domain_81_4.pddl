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
               (not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(at_soil_sample ?z)
			(visible ?y ?z)
			(have_soil_analysis ?x ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(not (communicated_rock_data ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			
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
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			
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
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(not (at_rock_sample ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			
          )
        :effect (and 
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
			(not (available ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (have_soil_analysis ?r ?w))
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
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (calibration_target ?i ?o))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?p))
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
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(at_lander ?l ?x)
			(not (at_lander ?l ?p))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(visible ?p ?y)
			(not (at ?r ?y))
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			
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
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (visible ?y ?x)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
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
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (visible_from ?o ?y))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(have_soil_analysis ?r ?y)
			(at ?r ?x)
			(at_soil_sample ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at_soil_sample ?p), (can_traverse ?r ?y ?x), (visible ?y ?p), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (at_rock_sample ?x), (available ?r), (at ?r ?y), (communicated_rock_data ?x), (at_lander ?l ?p), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (visible ?p ?x), (visible ?y ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), 
;; communicate_soil_data action has changed: (communicated_rock_data ?x), (at_lander ?l ?y), (can_traverse ?r ?p ?y), (at ?r ?x), (visible ?p ?y), (equipped_for_imaging ?r), (at_lander ?l ?x), (at_lander ?l ?p), (at_rock_sample ?p), (at_rock_sample ?y), (can_traverse ?r ?y ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (equipped_for_rock_analysis ?r), (visible ?y ?p), (at ?r ?y), 
;; sample_rock action has changed: (available ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (available ?x), 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (can_traverse ?x ?y ?z), (can_traverse ?x ?z ?y), (at_soil_sample ?z), (communicated_rock_data ?z), (equipped_for_imaging ?x), (have_soil_analysis ?x ?z), (visible ?z ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?y ?z), (at_soil_sample ?z), 
;; communicate_image_data action has changed: (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (visible_from ?o ?y), (at_soil_sample ?x), (at ?r ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (visible ?y ?x), 
;; calibrate action has changed: (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (available ?r), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), 
;; take_image action has changed: (communicated_soil_data ?p), (at ?r ?p), (at_rock_sample ?p), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (calibration_target ?i ?o), (have_image ?r ?o ?m), (have_image ?r ?o ?m), 
;; drop action has changed: (full ?y), (store_of ?y ?x), (equipped_for_imaging ?x), (empty ?y), 
;; sample_soil action has changed: (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), 
;; Last_reduced_capability_num_dropped_pals: None

