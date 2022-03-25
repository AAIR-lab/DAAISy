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
			(not (available ?x))
			(not (can_traverse ?x ?z ?y))
			(at ?x ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at ?x ?y)
			(not (at ?x ?z))
			
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
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			
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
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_rock_sample ?p))
			
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
               (not (store_of ?y ?x))
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
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			
          )
         :effect (and 
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
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(have_image ?r ?o ?m)
			(have_rock_analysis ?r ?p)
			(calibrated ?i ?r)
			
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
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(communicated_soil_data ?y)
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
               (channel_free ?l)
			(visible ?p ?y)
			(visible ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(visible ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (at_lander ?l ?x))
			(not (communicated_soil_data ?x))
			(at_lander ?l ?p)
			
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
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(at_soil_sample ?x)
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(not (at ?r ?y))
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (communicated_soil_data ?x))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (communicated_soil_data ?y), (can_traverse ?r ?p ?y), (at ?r ?x), (can_traverse ?r ?x ?y), (visible ?x ?y), (visible ?y ?x), (available ?r), (communicated_soil_data ?y), (channel_free ?l), (at_soil_sample ?p), (visible ?p ?x), (at ?r ?y), (equipped_for_soil_analysis ?r), (visible ?p ?y), (visible ?x ?y), 
;; navigate action has changed: (at ?x ?y), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?z), (available ?x), (equipped_for_soil_analysis ?x), (at ?x ?z), 
;; sample_rock action has changed: (communicated_rock_data ?p), (have_rock_analysis ?x ?p), 
;; calibrate action has changed: (at_rock_sample ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), 
;; communicate_rock_data action has changed: (communicated_soil_data ?x), (communicated_rock_data ?p), (visible ?p ?y), (visible ?y ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (at_lander ?l ?x), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (at_soil_sample ?x), (at_lander ?l ?p), (visible ?p ?y), 
;; communicate_image_data action has changed: (visible ?y ?x), (communicated_soil_data ?x), (at_lander ?l ?x), (at ?r ?y), (at_rock_sample ?y), (at ?r ?x), (at_soil_sample ?x), (visible_from ?o ?x), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (visible_from ?o ?x), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (calibration_target ?i ?o), (visible_from ?o ?p), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (calibrated ?i ?r), 
;; drop action has changed: (store_of ?y ?x), (full ?y), 
;; sample_soil action has changed: (communicated_rock_data ?p), (at ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

