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
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(at ?x ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(not (equipped_for_imaging ?x))
			(not (at ?x ?y))
			(communicated_soil_data ?y)
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
			(not (communicated_soil_data ?p))
			
          )
        :effect (and 
               (full ?s)
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
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
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(store_of ?y ?x)
			(full ?y)
			
          )
        :effect (and 
               (empty ?y)
			(equipped_for_rock_analysis ?x)
			(not (full ?y))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			
          )
         :effect (and 
               (not (have_soil_analysis ?r ?w))
			(available ?r)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(have_rock_analysis ?r ?w)
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
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (available ?r)
			(have_image ?r ?o ?m)
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
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
			(not (equipped_for_imaging ?r))
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_lander ?l ?y)
			(not (can_traverse ?r ?x ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			
          )
          :effect (and 
               (at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at_rock_sample ?y)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			
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
			(visible ?y ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(visible ?y ?p)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(communicated_rock_data ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?r))
			
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
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			
          )
         :effect (and 
               (not (visible ?y ?x))
			(at ?r ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; sample_rock action has changed: (communicated_soil_data ?p), (empty ?s), (equipped_for_imaging ?x), (at_rock_sample ?p), (equipped_for_imaging ?x), (at ?x ?p), 
;; communicate_rock_data action has changed: (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (visible ?p ?x), (visible ?y ?x), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (at ?r ?p), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?x), (at_rock_sample ?p), (at_soil_sample ?p), (at ?r ?p), (channel_free ?l), (visible ?x ?y), (at_soil_sample ?y), (visible ?x ?y), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (visible ?p ?y), (have_rock_analysis ?r ?p), (visible ?y ?p), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (communicated_soil_data ?x), 
;; communicate_image_data action has changed: (at_soil_sample ?x), (communicated_soil_data ?x), (communicated_soil_data ?x), (visible_from ?o ?y), (have_rock_analysis ?r ?x), (available ?r), (visible ?y ?x), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (at ?r ?y), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (visible_from ?o ?x), 
;; calibrate action has changed: (on_board ?i ?r), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at ?r ?w), (available ?r), (calibration_target ?i ?t), (have_rock_analysis ?r ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (at_soil_sample ?w), (have_soil_analysis ?r ?w), 
;; navigate action has changed: (have_rock_analysis ?x ?z), (equipped_for_imaging ?x), (available ?x), (communicated_rock_data ?y), (communicated_soil_data ?y), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (visible ?z ?y), 
;; communicate_soil_data action has changed: (communicated_soil_data ?p), (at_lander ?l ?p), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?p), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (at ?r ?x), (equipped_for_imaging ?r), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (visible ?p ?x), (at ?r ?p), (can_traverse ?r ?p ?y), 
;; take_image action has changed: (available ?r), (communicated_rock_data ?p), (visible_from ?o ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (available ?r), (have_image ?r ?o ?m), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (empty ?s), 
;; drop action has changed: (available ?x), (equipped_for_rock_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

