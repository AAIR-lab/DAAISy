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
               (not (at_rock_sample ?z))
			(available ?x)
			(at ?x ?y)
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			
          )
          :effect (and 
               (equipped_for_imaging ?x)
			(not (at ?x ?y))
			(at_soil_sample ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
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
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (full ?s))
			(not (communicated_soil_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (full ?y)
			
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
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
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
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?p))
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
			(not (visible ?x ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(available ?r)
			(not (at_soil_sample ?p))
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
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
			(not (visible ?y ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(available ?r)
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(at_lander ?l ?p)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(communicated_rock_data ?p)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			
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
               (have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (visible ?x ?y)
			(not (at_soil_sample ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (supports ?i ?m), 
;; navigate action has changed: (at_soil_sample ?y), (at_rock_sample ?z), (have_soil_analysis ?x ?z), (can_traverse ?x ?y ?z), (can_traverse ?x ?y ?z), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), 
;; communicate_image_data action has changed: (communicated_image_data ?o ?m), (visible_from ?o ?y), (visible ?x ?y), (channel_free ?l), (have_rock_analysis ?r ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?y), 
;; communicate_soil_data action has changed: (communicated_rock_data ?y), (at_soil_sample ?x), (visible ?p ?y), (equipped_for_imaging ?r), (visible ?x ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (available ?r), (can_traverse ?r ?p ?y), (at ?r ?y), (at_soil_sample ?p), (communicated_rock_data ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?p), (at_soil_sample ?p), (communicated_soil_data ?x), (channel_free ?l), 
;; sample_soil action has changed: (at ?x ?p), (full ?s), (store_of ?s ?x), (available ?x), (at_rock_sample ?p), (communicated_soil_data ?p), (communicated_rock_data ?p), 
;; calibrate action has changed: (at ?r ?w), (equipped_for_rock_analysis ?r), (available ?r), (have_soil_analysis ?r ?w), (calibration_target ?i ?t), 
;; communicate_rock_data action has changed: (visible ?y ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?p), (at_rock_sample ?x), (visible ?p ?x), (have_rock_analysis ?r ?p), (at_soil_sample ?y), (visible ?x ?y), (can_traverse ?r ?x ?y), (at_lander ?l ?p), (communicated_soil_data ?x), (communicated_soil_data ?y), (at ?r ?x), (communicated_rock_data ?x), (channel_free ?l), (visible ?p ?y), (visible ?y ?x), (at ?r ?y), 
;; sample_rock action has changed: (available ?x), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (full ?s), 
;; drop action has changed: (store_of ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

