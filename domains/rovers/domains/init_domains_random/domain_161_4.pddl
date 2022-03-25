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
               (at ?x ?y)
			(not (at_soil_sample ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (available ?x))
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (communicated_soil_data ?z))
			(communicated_soil_data ?y)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?s))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
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
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
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
			(not (equipped_for_rock_analysis ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (not (at_rock_sample ?w))
			(have_rock_analysis ?r ?w)
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
               (supports ?i ?m)
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(not (at_soil_sample ?p))
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (supports ?i ?m)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(calibrated ?i ?r)
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
               (channel_free ?l)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (have_rock_analysis ?r ?y))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(not (visible ?y ?p))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
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
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at_lander ?l ?x), (at_soil_sample ?y), (at_rock_sample ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (visible ?p ?x), (equipped_for_imaging ?r), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (can_traverse ?r ?p ?x), (visible ?y ?p), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?p), (visible ?x ?p), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?p), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (communicated_rock_data ?x), (communicated_rock_data ?y), (communicated_rock_data ?y), (visible ?y ?x), (at_lander ?l ?y), 
;; sample_soil action has changed: (at_rock_sample ?p), (store_of ?s ?x), (full ?s), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (empty ?s), (available ?x), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (available ?x), (full ?s), (at_rock_sample ?p), (empty ?s), (at_soil_sample ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), 
;; take_image action has changed: (equipped_for_soil_analysis ?r), (supports ?i ?m), (equipped_for_imaging ?r), (calibrated ?i ?r), (at ?r ?p), (at_soil_sample ?p), (at_rock_sample ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (visible_from ?o ?p), (at ?r ?p), (at_soil_sample ?p), (on_board ?i ?r), 
;; navigate action has changed: (can_traverse ?x ?z ?y), (communicated_rock_data ?y), (available ?x), (can_traverse ?x ?y ?z), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?y), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (available ?x), (at ?x ?z), (at_rock_sample ?z), (at_soil_sample ?z), (communicated_soil_data ?z), (communicated_rock_data ?y), 
;; communicate_soil_data action has changed: (communicated_soil_data ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (visible ?x ?p), (at ?r ?y), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (visible ?p ?x), (at_soil_sample ?y), (communicated_rock_data ?x), (communicated_soil_data ?p), (at_lander ?l ?p), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (available ?r), (at_rock_sample ?p), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (at_soil_sample ?y), (at_soil_sample ?p), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (at ?r ?p), (have_soil_analysis ?r ?p), (visible ?p ?y), (at ?r ?x), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (at_lander ?l ?x), (at_lander ?l ?x), (communicated_soil_data ?x), (at_rock_sample ?x), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (at_soil_sample ?p), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (at_rock_sample ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?x), (channel_free ?l), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (visible ?x ?y), (communicated_image_data ?o ?m), (visible_from ?o ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (at ?r ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (at_lander ?l ?y), (communicated_rock_data ?x), (at_lander ?l ?y), (available ?r), (have_soil_analysis ?r ?x), (at ?r ?x), (have_image ?r ?o ?m), (visible_from ?o ?y), (available ?r), (equipped_for_soil_analysis ?r), (visible ?y ?x), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), (store_of ?y ?x), 
;; calibrate action has changed: (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), 
;; Last_reduced_capability_num_dropped_pals: None

