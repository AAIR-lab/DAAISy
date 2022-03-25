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
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(have_soil_analysis ?x ?z)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(available ?x)
			(not (visible ?z ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
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
			(not (at ?x ?p))
			(empty ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(full ?y)
			
          )
        :effect (and 
               (empty ?y)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (equipped_for_imaging ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (have_rock_analysis ?r ?w))
			(not (at_soil_sample ?w))
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
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(not (on_board ?i ?r))
			(at_soil_sample ?p)
			(visible_from ?o ?p)
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
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?x)
			(visible ?y ?p)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?p)
			(not (visible ?y ?p))
			
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
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(have_rock_analysis ?r ?p)
			(at_lander ?l ?p)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(communicated_rock_data ?x)
			(not (at ?r ?p))
			(at ?r ?y)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(at_soil_sample ?x)
			
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
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(not (available ?r))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (visible ?x ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(visible_from ?o ?x)
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; sample_rock action has changed: (equipped_for_imaging ?x), (available ?x), (at_rock_sample ?p), (at ?x ?p), (have_soil_analysis ?x ?p), (at ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (at ?x ?y), (have_soil_analysis ?x ?z), (visible ?z ?y), (can_traverse ?x ?z ?y), (available ?x), (communicated_soil_data ?z), (at_soil_sample ?z), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (at ?x ?z), (at_rock_sample ?z), 
;; communicate_rock_data action has changed: (can_traverse ?r ?y ?p), (at_lander ?l ?p), (at_rock_sample ?p), (at_soil_sample ?y), (visible ?p ?y), (can_traverse ?r ?p ?x), (at ?r ?p), (equipped_for_imaging ?r), (at_lander ?l ?x), (have_soil_analysis ?r ?p), (visible ?y ?x), (at ?r ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (communicated_rock_data ?x), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?y), (at_rock_sample ?y), 
;; calibrate action has changed: (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (available ?r), (calibration_target ?i ?t), 
;; communicate_soil_data action has changed: (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (visible ?y ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?y), (visible ?y ?x), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?y), (visible ?p ?x), (visible ?y ?p), (at_rock_sample ?y), (at_rock_sample ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (communicated_rock_data ?p), 
;; take_image action has changed: (communicated_image_data ?o ?m), (visible_from ?o ?p), (on_board ?i ?r), (at_rock_sample ?p), (at_soil_sample ?p), 
;; communicate_image_data action has changed: (visible ?x ?y), (have_image ?r ?o ?m), (available ?r), (visible_from ?o ?y), (at ?r ?y), (visible_from ?o ?x), (equipped_for_imaging ?r), (communicated_soil_data ?x), (at_lander ?l ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?x), (communicated_image_data ?o ?m), (at ?r ?y), (communicated_image_data ?o ?m), (can_traverse ?r ?x ?y), 
;; sample_soil action has changed: (available ?x), (store_of ?s ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), 
;; drop action has changed: (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

