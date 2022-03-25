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
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(have_rock_analysis ?x ?y)
			
          )
          :effect (and 
               (visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(not (communicated_rock_data ?z))
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(equipped_for_imaging ?x)
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
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (empty ?s)
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(full ?y)
			
          )
        :effect (and 
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
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?w))
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(communicated_rock_data ?w)
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
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (available ?r)
			(have_image ?r ?o ?m)
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
			(visible ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(at_soil_sample ?x)
			(can_traverse ?r ?x ?p)
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(at ?r ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(can_traverse ?r ?x ?p)
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
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at ?r ?y))
			(available ?r)
			(at_soil_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(not (have_soil_analysis ?r ?y))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
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
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			
          )
         :effect (and 
               (not (at_rock_sample ?y))
			(not (equipped_for_rock_analysis ?r))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at ?r ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (communicated_rock_data ?p), (visible ?y ?x), (can_traverse ?r ?y ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?x), (at_soil_sample ?p), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?y), (visible ?p ?x), (at_lander ?l ?x), (can_traverse ?r ?p ?x), (visible ?p ?y), (visible ?p ?x), (at_rock_sample ?p), 
;; sample_soil action has changed: (available ?x), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (communicated_soil_data ?p), (equipped_for_imaging ?x), 
;; communicate_soil_data action has changed: (at_lander ?l ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (visible ?y ?x), (visible ?p ?x), (at ?r ?x), (at ?r ?y), (at_soil_sample ?x), (at_rock_sample ?p), (can_traverse ?r ?x ?p), 
;; sample_rock action has changed: (store_of ?s ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (empty ?s), (communicated_rock_data ?p), 
;; drop action has changed: (available ?x), (empty ?y), 
;; navigate action has changed: (communicated_rock_data ?z), (visible ?z ?y), (communicated_rock_data ?z), (have_soil_analysis ?x ?z), (at ?x ?z), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), 
;; communicate_image_data action has changed: (at_rock_sample ?y), (available ?r), (communicated_rock_data ?x), (visible ?x ?y), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), 
;; calibrate action has changed: (communicated_rock_data ?w), (at ?r ?w), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), 
;; take_image action has changed: (communicated_soil_data ?p), (available ?r), 
;; Last_reduced_capability_num_dropped_pals: None

