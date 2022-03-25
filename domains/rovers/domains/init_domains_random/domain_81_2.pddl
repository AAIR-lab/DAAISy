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
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (not (at ?x ?y))
			(not (at_soil_sample ?z))
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (at ?x ?z))
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
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
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
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
			(full ?y)
			
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
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (equipped_for_soil_analysis ?r))
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
			(have_soil_analysis ?r ?p)
			(available ?r)
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (available ?r)
			(have_image ?r ?o ?m)
			
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
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (visible ?y ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			
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
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?p))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			
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
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?y))
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?y), (at_soil_sample ?y), (at_rock_sample ?x), (visible ?p ?x), (visible ?y ?x), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (have_soil_analysis ?r ?p), (visible ?y ?x), (communicated_soil_data ?x), 
;; sample_rock action has changed: (full ?s), (available ?x), (have_soil_analysis ?x ?p), 
;; communicate_rock_data action has changed: (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?p), (communicated_soil_data ?p), (at ?r ?y), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (available ?r), (at_lander ?l ?x), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (store_of ?s ?x), (communicated_rock_data ?p), (store_of ?s ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (full ?s), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), 
;; communicate_image_data action has changed: (communicated_image_data ?o ?m), (at_rock_sample ?y), (communicated_soil_data ?y), (available ?r), (visible_from ?o ?y), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (at_lander ?l ?x), 
;; drop action has changed: (full ?y), 
;; calibrate action has changed: (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (available ?r), (calibration_target ?i ?t), (communicated_soil_data ?w), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), 
;; navigate action has changed: (communicated_soil_data ?z), (equipped_for_rock_analysis ?x), (at_soil_sample ?z), (communicated_rock_data ?z), (have_rock_analysis ?x ?y), (at ?x ?z), (can_traverse ?x ?z ?y), (equipped_for_rock_analysis ?x), (at ?x ?y), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (calibrated ?i ?r), (have_soil_analysis ?r ?p), (visible_from ?o ?p), (available ?r), (available ?r), (equipped_for_soil_analysis ?r), 
;; Last_reduced_capability_num_dropped_pals: None

