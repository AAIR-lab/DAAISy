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
			(visible ?z ?y)
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (visible ?z ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(communicated_soil_data ?z)
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(equipped_for_imaging ?x)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (empty ?s))
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (have_soil_analysis ?x ?p))
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
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(at_rock_sample ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			(not (full ?y))
			
          )
        :effect (and 
               (empty ?y)
			(not (equipped_for_rock_analysis ?x))
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
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
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
               (not (supports ?i ?m))
			(have_image ?r ?o ?m)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(not (visible_from ?o ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (available ?r))
			(have_image ?r ?o ?m)
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(visible_from ?o ?p)
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?x)
			(visible ?y ?p)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(visible ?p ?y)
			(can_traverse ?r ?x ?y)
			(not (at_soil_sample ?p))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?p)
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
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (available ?r))
			(at_soil_sample ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?x))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(not (at_lander ?l ?p))
			(visible ?y ?p)
			
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
               (not (channel_free ?l))
			(have_image ?r ?o ?m)
			(visible ?x ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			
          )
         :effect (and 
               (communicated_rock_data ?x)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(at ?r ?x)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; navigate action has changed: (communicated_soil_data ?z), (have_rock_analysis ?x ?z), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), (visible ?z ?y), (communicated_soil_data ?y), (visible ?z ?y), (have_soil_analysis ?x ?z), (visible ?y ?z), (at ?x ?y), (have_soil_analysis ?x ?y), (communicated_soil_data ?y), 
;; communicate_soil_data action has changed: (have_rock_analysis ?r ?p), (at_soil_sample ?p), (visible ?p ?y), (at_rock_sample ?y), (visible ?y ?p), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?p ?y), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?p), (visible ?p ?x), (at_soil_sample ?x), (communicated_rock_data ?p), (at_lander ?l ?x), (at_lander ?l ?y), (at ?r ?y), (visible ?p ?x), (communicated_rock_data ?p), (at_soil_sample ?y), (communicated_rock_data ?y), (channel_free ?l), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?p), (communicated_soil_data ?x), (communicated_soil_data ?x), 
;; take_image action has changed: (visible_from ?o ?p), (on_board ?i ?r), (supports ?i ?m), (available ?r), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (supports ?i ?m), (at ?r ?p), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (calibrated ?i ?r), 
;; sample_rock action has changed: (store_of ?s ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (store_of ?s ?x), (at_rock_sample ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (full ?s), 
;; communicate_rock_data action has changed: (at ?r ?x), (at ?r ?x), (equipped_for_rock_analysis ?r), (visible ?y ?p), (communicated_rock_data ?p), (visible ?p ?y), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (available ?r), (visible ?y ?x), (can_traverse ?r ?y ?p), (communicated_soil_data ?y), (at_lander ?l ?x), (visible ?x ?y), (channel_free ?l), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (have_soil_analysis ?r ?p), (available ?r), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?p), (at_soil_sample ?p), (visible ?p ?x), (at_lander ?l ?p), (at_rock_sample ?x), (at_soil_sample ?p), (can_traverse ?r ?x ?p), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), 
;; communicate_image_data action has changed: (visible_from ?o ?y), (communicated_image_data ?o ?m), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?y), (channel_free ?l), (at_rock_sample ?y), (communicated_soil_data ?x), (communicated_rock_data ?x), (at ?r ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?x), (at_lander ?l ?y), (available ?r), (communicated_soil_data ?x), (communicated_rock_data ?y), (at_lander ?l ?x), (at ?r ?y), 
;; calibrate action has changed: (visible_from ?t ?w), (on_board ?i ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?w), (at_soil_sample ?w), (equipped_for_imaging ?r), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (store_of ?s ?x), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (empty ?s), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (empty ?y), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

