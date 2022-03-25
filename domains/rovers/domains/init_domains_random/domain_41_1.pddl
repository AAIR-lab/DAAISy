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
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (not (at ?x ?y))
			(at ?x ?z)
			
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
			(not (have_soil_analysis ?x ?p))
			
          )
        :effect (and 
               (not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
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
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
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
			(not (have_soil_analysis ?r ?w))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			
          )
         :effect (and 
               (equipped_for_soil_analysis ?r)
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
               (supports ?i ?m)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
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
			(not (visible ?p ?y))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			
          )
          :effect (and 
               (at ?r ?y)
			(at_rock_sample ?p)
			(can_traverse ?r ?y ?p)
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
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(not (visible ?x ?p))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(not (at_soil_sample ?x))
			
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
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?x)
			
          )
         :effect (and 
               (communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (can_traverse ?r ?p ?y), (visible ?x ?p), (at_lander ?l ?x), (communicated_rock_data ?x), (at ?r ?y), (can_traverse ?r ?x ?y), (at ?r ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (have_soil_analysis ?r ?p), (channel_free ?l), (have_soil_analysis ?r ?y), 
;; calibrate action has changed: (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?w), 
;; take_image action has changed: (calibrated ?i ?r), 
;; communicate_soil_data action has changed: (can_traverse ?r ?y ?x), (visible ?x ?p), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?y), (at_rock_sample ?p), (at ?r ?y), (visible ?p ?y), (visible ?y ?p), (at_soil_sample ?p), 
;; sample_soil action has changed: (full ?s), (store_of ?s ?x), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), 
;; sample_rock action has changed: (at_soil_sample ?p), (at_soil_sample ?p), (full ?s), (equipped_for_soil_analysis ?x), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (available ?r), (have_rock_analysis ?r ?x), (visible ?y ?x), 
;; drop action has changed: (available ?x), (store_of ?y ?x), 
;; Last_reduced_capability_num_dropped_pals: None

