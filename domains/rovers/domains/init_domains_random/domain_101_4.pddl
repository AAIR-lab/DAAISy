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
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			
          )
          :effect (and 
               (not (visible ?z ?y))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
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
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (full ?s))
			(at_rock_sample ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(empty ?y)
			(not (full ?y))
			
          )
        :effect (and 
               (not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(not (on_board ?i ?r))
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(equipped_for_imaging ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
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
               (have_soil_analysis ?r ?p)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_image ?r ?o ?m)
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
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (can_traverse ?r ?p ?y))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
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
               (visible ?p ?x)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
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
			(have_image ?r ?o ?m)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(can_traverse ?r ?x ?y)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_rock_analysis ?r)
			
          )
         :effect (and 
               (not (have_image ?r ?o ?m))
			(available ?r)
			(communicated_soil_data ?y)
			(visible_from ?o ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?p), (at_rock_sample ?y), (visible ?p ?x), (at ?r ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (visible ?p ?y), (communicated_soil_data ?x), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?p), (visible ?x ?y), (have_soil_analysis ?r ?x), (channel_free ?l), (at ?r ?x), (equipped_for_imaging ?r), (communicated_rock_data ?y), 
;; communicate_image_data action has changed: (can_traverse ?r ?x ?y), (available ?r), (communicated_rock_data ?x), (available ?r), (communicated_soil_data ?y), (at_rock_sample ?y), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (visible_from ?o ?y), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), 
;; calibrate action has changed: (at_rock_sample ?w), (have_rock_analysis ?r ?w), (communicated_rock_data ?w), (calibrated ?i ?r), (equipped_for_imaging ?r), (visible_from ?t ?w), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (at_soil_sample ?w), (communicated_soil_data ?w), 
;; navigate action has changed: (at ?x ?y), (at ?x ?z), (can_traverse ?x ?z ?y), (at ?x ?y), (have_soil_analysis ?x ?z), (visible ?z ?y), (communicated_soil_data ?z), (at_rock_sample ?z), (at ?x ?z), (have_soil_analysis ?x ?y), 
;; drop action has changed: (empty ?y), (full ?y), (full ?y), (empty ?y), (equipped_for_rock_analysis ?x), 
;; sample_rock action has changed: (full ?s), (empty ?s), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_imaging ?x), (available ?x), (communicated_rock_data ?p), (full ?s), 
;; sample_soil action has changed: (at_rock_sample ?p), (full ?s), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (available ?x), (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (at_rock_sample ?y), (visible ?p ?y), (at_lander ?l ?y), (can_traverse ?r ?p ?y), (at ?r ?p), (at_lander ?l ?p), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (can_traverse ?r ?x ?y), (at ?r ?y), (visible ?p ?x), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), 
;; take_image action has changed: (communicated_soil_data ?p), (supports ?i ?m), (at_rock_sample ?p), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), 
;; Last_reduced_capability_num_dropped_pals: None

