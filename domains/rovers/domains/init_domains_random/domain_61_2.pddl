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
               (have_rock_analysis ?x ?z)
			(available ?x)
			(at ?x ?y)
			(not (at_soil_sample ?z))
			(communicated_rock_data ?z)
			(visible ?y ?z)
			(not (can_traverse ?x ?y ?z))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at ?x ?y))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			
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
               (equipped_for_imaging ?x)
			(not (full ?s))
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
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_rock_sample ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
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
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(communicated_soil_data ?w)
			
          )
         :effect (and 
               (on_board ?i ?r)
			(not (visible_from ?t ?w))
			(have_rock_analysis ?r ?w)
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
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(have_image ?r ?o ?m)
			(equipped_for_soil_analysis ?r)
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
               (not (channel_free ?l))
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_soil_sample ?p))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?p))
			(not (visible ?x ?p))
			
          )
          :effect (and 
               (visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?p))
			(not (communicated_soil_data ?y))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(communicated_rock_data ?y)
			
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
			(not (visible ?x ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			
          )
          :effect (and 
               (not (can_traverse ?r ?p ?y))
			(not (at ?r ?y))
			(communicated_rock_data ?p)
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
			
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
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(at_lander ?l ?y)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (have_soil_analysis ?r ?x))
			(available ?r)
			(communicated_soil_data ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?x), (available ?r), (have_rock_analysis ?r ?x), (communicated_soil_data ?x), (at_rock_sample ?y), (communicated_soil_data ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?y), (channel_free ?l), 
;; communicate_soil_data action has changed: (communicated_soil_data ?y), (at_soil_sample ?p), (at ?r ?y), (visible ?x ?p), (communicated_rock_data ?y), (channel_free ?l), (have_soil_analysis ?r ?y), (at_lander ?l ?p), (at_rock_sample ?p), (at ?r ?x), (visible ?x ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (visible ?x ?p), 
;; sample_soil action has changed: (empty ?s), (full ?s), (equipped_for_imaging ?x), 
;; take_image action has changed: (available ?r), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (at ?r ?p), (supports ?i ?m), (available ?r), (communicated_soil_data ?p), 
;; navigate action has changed: (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?z), (at_soil_sample ?z), (can_traverse ?x ?y ?z), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), 
;; sample_rock action has changed: (full ?s), (have_rock_analysis ?x ?p), 
;; drop action has changed: (available ?x), (equipped_for_rock_analysis ?x), 
;; communicate_rock_data action has changed: (at ?r ?y), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?y), (visible ?x ?y), (have_rock_analysis ?r ?p), (at ?r ?p), (can_traverse ?r ?x ?p), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (at ?r ?y), 
;; calibrate action has changed: (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (on_board ?i ?r), (visible_from ?t ?w), 
;; Last_reduced_capability_num_dropped_pals: None

