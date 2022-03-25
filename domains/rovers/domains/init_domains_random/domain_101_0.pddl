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
			(at ?x ?y)
			(at_soil_sample ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (available ?x)
			(not (equipped_for_imaging ?x))
			(communicated_rock_data ?z)
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
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
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?y))
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
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?t ?w)
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
			(available ?r)
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (on_board ?i ?r))
			(visible_from ?o ?p)
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
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(not (at_lander ?l ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(at ?r ?y)
			(not (available ?r))
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?p)
			(can_traverse ?r ?p ?x)
			
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
			(visible ?y ?x)
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at_rock_sample ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(visible ?y ?p)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?p ?x)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(communicated_rock_data ?p)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
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
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (have_image ?r ?o ?m)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at ?r ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (available ?r), (on_board ?i ?r), (on_board ?i ?r), (at ?r ?p), (supports ?i ?m), (visible_from ?o ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (calibration_target ?i ?o), 
;; communicate_soil_data action has changed: (visible ?p ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?p), (available ?r), (channel_free ?l), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?x), (communicated_rock_data ?p), (at ?r ?y), (visible ?y ?p), (can_traverse ?r ?p ?x), (at_rock_sample ?x), (visible ?p ?x), (can_traverse ?r ?p ?x), (at_lander ?l ?p), (can_traverse ?r ?y ?p), 
;; communicate_image_data action has changed: (have_image ?r ?o ?m), (available ?r), (communicated_soil_data ?y), (at ?r ?x), (at_soil_sample ?x), (visible ?y ?x), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (have_image ?r ?o ?m), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?y ?x), 
;; communicate_rock_data action has changed: (at ?r ?y), (can_traverse ?r ?p ?y), (at_lander ?l ?p), (communicated_rock_data ?y), (visible ?p ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?y), (visible ?x ?p), (have_rock_analysis ?r ?y), (at_rock_sample ?y), (at_soil_sample ?x), (visible ?x ?y), (can_traverse ?r ?y ?x), (channel_free ?l), (equipped_for_imaging ?r), (visible ?y ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (communicated_soil_data ?p), (communicated_rock_data ?y), (have_soil_analysis ?r ?p), (at_rock_sample ?y), (visible ?y ?p), (communicated_soil_data ?x), (visible ?p ?x), (at_soil_sample ?y), (at_rock_sample ?p), (at_rock_sample ?x), 
;; drop action has changed: (empty ?y), (available ?x), (equipped_for_imaging ?x), (empty ?y), 
;; navigate action has changed: (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (equipped_for_imaging ?x), (available ?x), (communicated_rock_data ?z), (at ?x ?z), (at_soil_sample ?y), (at ?x ?y), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (at_soil_sample ?p), (communicated_rock_data ?p), 
;; calibrate action has changed: (equipped_for_rock_analysis ?r), (available ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (on_board ?i ?r), (communicated_soil_data ?w), (at_rock_sample ?w), (visible_from ?t ?w), 
;; sample_soil action has changed: (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), (empty ?s), 
;; Last_reduced_capability_num_dropped_pals: None

