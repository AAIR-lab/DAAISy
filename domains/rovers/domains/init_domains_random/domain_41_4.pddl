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
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (visible ?z ?y)
			(not (at ?x ?y))
			(visible ?y ?z)
			(at ?x ?z)
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (communicated_rock_data ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(not (communicated_soil_data ?p))
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
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (at ?x ?p)
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
               (store_of ?y ?x)
			(not (empty ?y))
			(full ?y)
			
          )
        :effect (and 
               (available ?x)
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
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(visible_from ?t ?w)
			
          )
         :effect (and 
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
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_soil_sample ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(not (calibrated ?i ?r))
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at ?r ?p)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			
          )
          :effect (and 
               (can_traverse ?r ?p ?y)
			(not (have_rock_analysis ?r ?x))
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
               (communicated_rock_data ?x)
			(visible ?x ?y)
			(not (available ?r))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?p))
			(not (visible ?x ?p))
			
          )
          :effect (and 
               (not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(have_rock_analysis ?r ?y)
			(not (have_rock_analysis ?r ?p))
			
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
			(not (have_image ?r ?o ?m))
			(visible ?x ?y)
			(not (available ?r))
			(at ?r ?x)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			
          )
         :effect (and 
               (communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (visible ?z ?y), 
;; communicate_soil_data action has changed: (visible ?p ?y), (at ?r ?p), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?x), (visible ?y ?x), (have_soil_analysis ?r ?x), 
;; sample_soil action has changed: (equipped_for_soil_analysis ?x), (empty ?s), (communicated_soil_data ?p), (communicated_rock_data ?p), 
;; take_image action has changed: (at_soil_sample ?p), (at ?r ?p), 
;; communicate_rock_data action has changed: (channel_free ?l), (communicated_rock_data ?p), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (communicated_soil_data ?p), (available ?r), (communicated_rock_data ?x), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?y), (visible ?x ?p), (can_traverse ?r ?y ?p), (at_soil_sample ?p), (at_rock_sample ?p), 
;; sample_rock action has changed: (available ?x), (at ?x ?p), (equipped_for_imaging ?x), 
;; drop action has changed: (available ?x), (empty ?y), (store_of ?y ?x), 
;; communicate_image_data action has changed: (equipped_for_soil_analysis ?r), (available ?r), (have_image ?r ?o ?m), 
;; calibrate action has changed: (on_board ?i ?r), 
;; Last_reduced_capability_num_dropped_pals: None

