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
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(not (at_soil_sample ?z))
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at ?x ?y))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?y))
			
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
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(empty ?s)
			(equipped_for_imaging ?x)
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (not (available ?x))
			(not (store_of ?y ?x))
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
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (visible_from ?t ?w))
			(communicated_soil_data ?w)
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (on_board ?i ?r)
			(at_rock_sample ?w)
			(communicated_soil_data ?w)
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
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(have_image ?r ?o ?m)
			(on_board ?i ?r)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (calibrated ?i ?r))
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
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(visible ?p ?x)
			(visible ?x ?y)
			(at ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(visible ?y ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(communicated_rock_data ?x)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?p)
			(not (can_traverse ?r ?y ?p))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?y))
			(communicated_soil_data ?p)
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
			(not (visible ?x ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(not (have_rock_analysis ?r ?p))
			(at_lander ?l ?p)
			(visible ?x ?p)
			
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
               (not (channel_free ?l))
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(at ?r ?y)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?y)
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			
          )
         :effect (and 
               (at_rock_sample ?x)
			(available ?r)
			(not (at ?r ?x))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (communicated_rock_data ?y), (visible ?p ?x), (channel_free ?l), (communicated_soil_data ?y), (at_rock_sample ?p), (communicated_soil_data ?y), (visible ?y ?p), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?x), (available ?r), (at ?r ?p), (can_traverse ?r ?y ?p), (visible ?y ?x), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (equipped_for_imaging ?r), (channel_free ?l), (at ?r ?y), (can_traverse ?r ?p ?x), 
;; calibrate action has changed: (visible_from ?t ?w), (calibrated ?i ?r), (communicated_soil_data ?w), (at_rock_sample ?w), (communicated_soil_data ?w), (at_rock_sample ?w), (on_board ?i ?r), 
;; navigate action has changed: (at_rock_sample ?z), (have_rock_analysis ?x ?z), (communicated_soil_data ?y), (communicated_rock_data ?z), (at ?x ?z), (at_soil_sample ?z), (have_rock_analysis ?x ?y), (available ?x), (equipped_for_rock_analysis ?x), (can_traverse ?x ?y ?z), (at ?x ?y), (equipped_for_soil_analysis ?x), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (at ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (store_of ?s ?x), (at_rock_sample ?p), (available ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), (at ?x ?p), (available ?x), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (channel_free ?l), (communicated_rock_data ?x), (can_traverse ?r ?y ?x), (at ?r ?x), (at ?r ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?y), (communicated_soil_data ?x), (visible_from ?o ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (available ?r), 
;; communicate_rock_data action has changed: (equipped_for_soil_analysis ?r), (visible ?x ?p), (visible ?x ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (visible ?y ?p), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (communicated_soil_data ?x), (at ?r ?y), (at_lander ?l ?p), (at_rock_sample ?p), (visible ?x ?p), (available ?r), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (have_soil_analysis ?r ?p), 
;; take_image action has changed: (at ?r ?p), (supports ?i ?m), (have_image ?r ?o ?m), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (on_board ?i ?r), (on_board ?i ?r), (visible_from ?o ?p), (calibration_target ?i ?o), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (store_of ?y ?x), (available ?x), (store_of ?y ?x), (available ?x), 
;; sample_soil action has changed: (empty ?s), (communicated_soil_data ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (empty ?s), (have_soil_analysis ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

