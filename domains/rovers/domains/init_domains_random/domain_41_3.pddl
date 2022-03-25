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
			(at_soil_sample ?z)
			(not (communicated_soil_data ?z))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(have_rock_analysis ?x ?y)
			
          )
          :effect (and 
               (not (at ?x ?y))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
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
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
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
			(calibrated ?i ?r)
			
          )
         :effect (and 
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
               (equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (communicated_image_data ?o ?m))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(have_image ?r ?o ?m)
			(not (at_soil_sample ?p))
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
			(visible ?x ?y)
			(have_soil_analysis ?r ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?x ?y))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
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
			(not (equipped_for_imaging ?r))
			(visible ?x ?y)
			(available ?r)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(visible ?x ?p)
			
          )
          :effect (and 
               (communicated_rock_data ?x)
			(not (at ?r ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			
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
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			
          )
         :effect (and 
               (visible_from ?o ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; take_image action has changed: (available ?r), (supports ?i ?m), (communicated_image_data ?o ?m), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), 
;; drop action has changed: (store_of ?y ?x), 
;; communicate_soil_data action has changed: (communicated_rock_data ?y), (visible ?x ?p), (visible ?x ?y), (communicated_soil_data ?x), (channel_free ?l), (at_soil_sample ?y), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (available ?r), 
;; communicate_rock_data action has changed: (equipped_for_imaging ?r), (visible ?x ?p), (at ?r ?p), (at_soil_sample ?p), (communicated_rock_data ?x), (at_rock_sample ?p), (at_rock_sample ?p), 
;; navigate action has changed: (communicated_soil_data ?z), (at_soil_sample ?z), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?y), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (available ?x), (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (at_lander ?l ?x), (have_image ?r ?o ?m), (visible_from ?o ?y), 
;; calibrate action has changed: (calibrated ?i ?r), (at_soil_sample ?w), (at ?r ?w), 
;; sample_rock action has changed: (equipped_for_imaging ?x), (store_of ?s ?x), 
;; Last_reduced_capability_num_dropped_pals: None

