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
			(available ?x)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(not (communicated_rock_data ?z))
			(visible ?y ?z)
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (at_rock_sample ?y)
			(not (at ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
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
			(store_of ?y ?x)
			(empty ?y)
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
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
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
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(not (at_soil_sample ?p))
			(not (communicated_soil_data ?p))
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
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(communicated_soil_data ?x)
			(not (visible ?x ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(visible ?x ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?p))
			
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
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?p)
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			
          )
          :effect (and 
               (visible ?p ?y)
			(can_traverse ?r ?x ?y)
			(communicated_rock_data ?p)
			(not (at_soil_sample ?y))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
			
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
			(not (available ?r))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (have_rock_analysis ?r ?y))
			(communicated_soil_data ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (can_traverse ?r ?x ?y), (communicated_soil_data ?p), (visible ?x ?y), (communicated_soil_data ?x), (communicated_rock_data ?x), (at_rock_sample ?p), (visible ?x ?p), (equipped_for_soil_analysis ?r), (channel_free ?l), (at_rock_sample ?x), (visible ?y ?x), 
;; communicate_image_data action has changed: (visible ?x ?y), (at ?r ?x), (have_soil_analysis ?r ?x), (available ?r), (communicated_soil_data ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?x), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (full ?s), (at ?x ?p), (available ?x), (communicated_soil_data ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), 
;; calibrate action has changed: (have_rock_analysis ?r ?w), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), 
;; navigate action has changed: (have_rock_analysis ?x ?z), (communicated_rock_data ?z), (equipped_for_rock_analysis ?x), (can_traverse ?x ?z ?y), (communicated_rock_data ?y), (at ?x ?z), (at_rock_sample ?y), 
;; take_image action has changed: (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), 
;; communicate_rock_data action has changed: (at_soil_sample ?y), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (visible ?p ?y), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?y), (at_lander ?l ?p), 
;; drop action has changed: (empty ?y), (available ?x), (equipped_for_soil_analysis ?x), (store_of ?y ?x), 
;; sample_soil action has changed: (full ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

