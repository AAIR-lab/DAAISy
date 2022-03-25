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
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(available ?x)
			(equipped_for_imaging ?x)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(not (have_soil_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
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
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
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
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_soil_sample ?w)
			
          )
         :effect (and 
               (communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
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
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(at_soil_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(have_rock_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
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
			(visible ?y ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(at_soil_sample ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			
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
			(visible ?p ?x)
			(not (visible ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (at_lander ?l ?p))
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?x)
			
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
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(available ?r)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			
          )
         :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (at_lander ?l ?p), (have_rock_analysis ?r ?x), (visible ?x ?p), (at ?r ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (visible ?y ?x), (have_soil_analysis ?r ?x), (visible ?p ?y), (at_soil_sample ?x), (communicated_soil_data ?p), (at_lander ?l ?y), (visible ?x ?p), (at_soil_sample ?p), (equipped_for_imaging ?r), (at_soil_sample ?x), (visible ?x ?y), (at ?r ?x), (visible ?p ?x), 
;; communicate_image_data action has changed: (channel_free ?l), (visible ?x ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (can_traverse ?r ?y ?x), (at ?r ?x), (at_soil_sample ?x), (communicated_soil_data ?x), (at_soil_sample ?y), (equipped_for_imaging ?r), (at_rock_sample ?y), (at_rock_sample ?x), (visible ?y ?x), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (store_of ?s ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (communicated_soil_data ?p), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (at ?r ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?p), (at_soil_sample ?x), (at_soil_sample ?y), (visible ?x ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?x), (at_rock_sample ?y), (at_rock_sample ?y), (visible ?p ?x), (can_traverse ?r ?y ?x), (communicated_soil_data ?y), 
;; calibrate action has changed: (at_soil_sample ?w), (communicated_rock_data ?w), (visible_from ?t ?w), (on_board ?i ?r), (equipped_for_imaging ?r), (communicated_soil_data ?w), 
;; navigate action has changed: (communicated_soil_data ?z), (available ?x), (communicated_rock_data ?z), (at_rock_sample ?z), (visible ?y ?z), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?y), (can_traverse ?x ?z ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?z), 
;; sample_soil action has changed: (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (at ?x ?p), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (empty ?s), 
;; drop action has changed: (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

