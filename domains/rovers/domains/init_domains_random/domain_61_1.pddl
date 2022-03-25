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
               (not (have_rock_analysis ?x ?z))
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(communicated_rock_data ?z)
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			
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
			(not (equipped_for_rock_analysis ?x))
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
			(not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(on_board ?i ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
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
			(communicated_image_data ?o ?m)
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (have_image ?r ?o ?m)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
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
               (visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (equipped_for_rock_analysis ?r))
			
          )
          :effect (and 
               (not (at ?r ?p))
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
			(visible ?x ?y)
			(at_rock_sample ?x)
			(at ?r ?p)
			(at ?r ?y)
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (communicated_soil_data ?x))
			
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
			(visible ?x ?y)
			(available ?r)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(communicated_soil_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?x))
			(equipped_for_soil_analysis ?r)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (available ?r), (communicated_rock_data ?p), (communicated_image_data ?o ?m), (at_rock_sample ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (calibrated ?i ?r), (equipped_for_imaging ?r), 
;; communicate_rock_data action has changed: (communicated_soil_data ?x), (at_rock_sample ?x), (at_rock_sample ?y), (at ?r ?p), (at_lander ?l ?x), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (at ?r ?y), (at_lander ?l ?y), (visible ?x ?y), (available ?r), (at_lander ?l ?y), (communicated_rock_data ?y), (can_traverse ?r ?p ?x), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (visible_from ?o ?x), (at_rock_sample ?x), (equipped_for_imaging ?r), (visible ?y ?x), (channel_free ?l), (equipped_for_soil_analysis ?r), (at ?r ?x), (communicated_image_data ?o ?m), (visible ?x ?y), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (available ?x), (store_of ?s ?x), (at ?x ?p), (at ?x ?p), (store_of ?s ?x), 
;; sample_rock action has changed: (at ?x ?p), (empty ?s), (equipped_for_rock_analysis ?x), (communicated_soil_data ?p), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), 
;; drop action has changed: (store_of ?y ?x), (full ?y), (equipped_for_rock_analysis ?x), 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (channel_free ?l), (at ?r ?p), (equipped_for_rock_analysis ?r), 
;; calibrate action has changed: (at ?r ?w), (have_soil_analysis ?r ?w), (communicated_rock_data ?w), 
;; navigate action has changed: (have_rock_analysis ?x ?z), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), 
;; Last_reduced_capability_num_dropped_pals: None

