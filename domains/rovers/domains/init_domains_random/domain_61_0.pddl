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
               (not (available ?x))
			(at_rock_sample ?y)
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (visible ?z ?y)
			(not (at ?x ?y))
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			
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
			(empty ?s)
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
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
			(equipped_for_soil_analysis ?x)
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
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			
          )
         :effect (and 
               (available ?r)
			(communicated_rock_data ?w)
			(not (calibrated ?i ?r))
			
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
               (not (supports ?i ?m))
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
			(visible ?x ?y)
			(at ?r ?y)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?p ?x)
			(have_soil_analysis ?r ?y)
			(not (available ?r))
			(not (at_soil_sample ?p))
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
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?x)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			
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
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(equipped_for_soil_analysis ?r)
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (at_rock_sample ?x))
			(at_lander ?l ?x)
			(at_soil_sample ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; sample_soil action has changed: (available ?x), (store_of ?s ?x), 
;; communicate_soil_data action has changed: (channel_free ?l), (communicated_soil_data ?y), (at ?r ?y), (visible ?p ?x), (available ?r), (have_soil_analysis ?r ?p), (available ?r), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (at_soil_sample ?y), 
;; communicate_rock_data action has changed: (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?x), (communicated_rock_data ?p), (at_rock_sample ?y), (visible ?y ?p), (channel_free ?l), (at ?r ?y), (visible ?p ?x), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (at_rock_sample ?y), (at_soil_sample ?x), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (available ?r), (visible ?p ?y), 
;; communicate_image_data action has changed: (at_rock_sample ?x), (at_rock_sample ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), (visible ?y ?x), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (communicated_rock_data ?w), (available ?r), (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (calibrated ?i ?r), 
;; navigate action has changed: (at_rock_sample ?y), (visible ?z ?y), (equipped_for_rock_analysis ?x), (communicated_soil_data ?y), (available ?x), (visible ?y ?z), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?y), 
;; sample_rock action has changed: (communicated_rock_data ?p), (full ?s), (equipped_for_imaging ?x), (at ?x ?p), 
;; take_image action has changed: (supports ?i ?m), 
;; Last_reduced_capability_num_dropped_pals: None

