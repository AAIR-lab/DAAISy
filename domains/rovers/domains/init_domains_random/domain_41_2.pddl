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
			(visible ?z ?y)
			(at ?x ?y)
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (at ?x ?y))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(empty ?s)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			
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
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
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
               (store_of ?y ?x)
			(empty ?y)
			(not (equipped_for_soil_analysis ?x))
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
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			
          )
         :effect (and 
               (not (available ?r))
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
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(have_image ?r ?o ?m)
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
               (channel_free ?l)
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at_rock_sample ?y))
			(not (communicated_rock_data ?p))
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
			(not (visible ?x ?y))
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			
          )
          :effect (and 
               (not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?r))
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
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (can_traverse ?r ?y ?x))
			
          )
         :effect (and 
               (channel_free ?l)
			(have_image ?r ?o ?m)
			(not (visible_from ?o ?x))
			(communicated_soil_data ?y)
			(not (visible_from ?o ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (visible_from ?o ?x), (can_traverse ?r ?y ?x), (channel_free ?l), (have_image ?r ?o ?m), (visible_from ?o ?y), (communicated_soil_data ?y), 
;; navigate action has changed: (communicated_rock_data ?y), (visible ?z ?y), (at ?x ?z), (communicated_soil_data ?y), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_soil_analysis ?x), 
;; communicate_rock_data action has changed: (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (visible ?x ?y), 
;; take_image action has changed: (at ?r ?p), (communicated_soil_data ?p), (calibrated ?i ?r), (supports ?i ?m), (calibration_target ?i ?o), 
;; sample_soil action has changed: (equipped_for_soil_analysis ?x), (at ?x ?p), (store_of ?s ?x), (equipped_for_rock_analysis ?x), 
;; communicate_soil_data action has changed: (visible ?y ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (channel_free ?l), (at_rock_sample ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), 
;; sample_rock action has changed: (available ?x), (communicated_rock_data ?p), (at_soil_sample ?p), 
;; calibrate action has changed: (communicated_rock_data ?w), (visible_from ?t ?w), (available ?r), 
;; Last_reduced_capability_num_dropped_pals: None

