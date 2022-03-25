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
			
          )
          :effect (and 
               (not (at ?x ?y))
			(at ?x ?z)
			(communicated_rock_data ?y)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
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
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
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
			(full ?y)
			
          )
        :effect (and 
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
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (at ?r ?w))
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
			(not (on_board ?i ?r))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
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
			(have_soil_analysis ?r ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (can_traverse ?r ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
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
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			
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
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (at ?r ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; sample_soil action has changed: (full ?s), (store_of ?s ?x), 
;; sample_rock action has changed: (equipped_for_imaging ?x), 
;; communicate_soil_data action has changed: (visible ?p ?x), (visible ?y ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?y), 
;; communicate_image_data action has changed: (at_rock_sample ?y), (at ?r ?x), (communicated_rock_data ?y), 
;; communicate_rock_data action has changed: (at_soil_sample ?p), (communicated_rock_data ?y), (can_traverse ?r ?y ?p), 
;; calibrate action has changed: (at ?r ?w), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), 
;; take_image action has changed: (on_board ?i ?r), (visible_from ?o ?p), 
;; navigate action has changed: (communicated_rock_data ?y), 
;; drop action has changed: (store_of ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

