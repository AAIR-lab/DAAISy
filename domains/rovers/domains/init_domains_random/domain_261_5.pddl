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
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(available ?x)
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(equipped_for_imaging ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (have_soil_analysis ?r ?w)
			(available ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
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
               (not (supports ?i ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (visible_from ?o ?p))
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
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
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
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
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
			(can_traverse ?r ?p ?x)
			
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
			(not (have_soil_analysis ?r ?x))
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(have_soil_analysis ?r ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; calibrate action has changed: (communicated_soil_data ?w), (calibrated ?i ?r), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (at ?r ?w), (have_soil_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (on_board ?i ?r), (communicated_rock_data ?w), (available ?r), (on_board ?i ?r), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (at_rock_sample ?w), (calibrated ?i ?r), (available ?r), (at ?r ?w), 
;; communicate_soil_data action has changed: (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (visible ?y ?x), (at_soil_sample ?p), (communicated_rock_data ?x), (have_rock_analysis ?r ?x), (available ?r), (communicated_rock_data ?x), (available ?r), (can_traverse ?r ?p ?y), (visible ?x ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?p), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (visible ?x ?p), (channel_free ?l), (visible ?x ?y), (visible ?p ?x), (have_soil_analysis ?r ?y), (communicated_soil_data ?p), (communicated_soil_data ?x), (visible ?y ?x), (visible ?x ?p), (equipped_for_soil_analysis ?r), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (at ?r ?y), (at ?r ?x), (communicated_rock_data ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?p), (at_rock_sample ?p), (channel_free ?l), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?p), (at ?r ?y), (at_soil_sample ?x), (at ?r ?x), (at_soil_sample ?y), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (empty ?s), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (at ?x ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (communicated_rock_data ?p), (full ?s), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (empty ?s), (at ?x ?p), (equipped_for_imaging ?x), 
;; communicate_rock_data action has changed: (visible ?p ?x), (visible ?p ?y), (equipped_for_imaging ?r), (at_rock_sample ?x), (at_soil_sample ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at_lander ?l ?x), (at ?r ?p), (have_soil_analysis ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?p), (visible ?p ?x), (communicated_rock_data ?p), (at ?r ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (visible ?x ?y), (have_rock_analysis ?r ?y), (channel_free ?l), (visible ?x ?p), (at_lander ?l ?y), (at ?r ?x), (have_rock_analysis ?r ?p), (at_rock_sample ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?x ?p), (visible ?x ?y), (visible ?y ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?y), (at ?r ?p), (can_traverse ?r ?x ?p), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (at_soil_sample ?p), (available ?r), (can_traverse ?r ?p ?x), (visible ?p ?y), (at_rock_sample ?y), (communicated_soil_data ?x), (at_rock_sample ?y), (at_rock_sample ?p), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (visible ?y ?x), 
;; communicate_image_data action has changed: (available ?r), (have_image ?r ?o ?m), (visible_from ?o ?y), (have_soil_analysis ?r ?y), (communicated_soil_data ?y), (have_image ?r ?o ?m), (equipped_for_soil_analysis ?r), (at ?r ?y), (at_lander ?l ?x), (visible_from ?o ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (communicated_soil_data ?x), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (at_rock_sample ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (at ?r ?x), (channel_free ?l), (communicated_rock_data ?y), (equipped_for_imaging ?r), (communicated_soil_data ?x), (visible ?x ?y), (equipped_for_rock_analysis ?r), (visible_from ?o ?x), (communicated_rock_data ?y), (available ?r), (have_rock_analysis ?r ?x), 
;; navigate action has changed: (at_rock_sample ?z), (at_soil_sample ?z), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (communicated_soil_data ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (equipped_for_rock_analysis ?x), (visible ?y ?z), (at ?x ?y), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?y), (can_traverse ?x ?y ?z), (visible ?z ?y), (communicated_rock_data ?y), (have_rock_analysis ?x ?y), (at_rock_sample ?y), (at_rock_sample ?y), (communicated_rock_data ?z), (can_traverse ?x ?z ?y), (at ?x ?z), (communicated_soil_data ?y), (have_rock_analysis ?x ?z), (communicated_soil_data ?z), (at ?x ?y), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (visible ?y ?z), (equipped_for_imaging ?x), (have_soil_analysis ?x ?z), (at_soil_sample ?y), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (full ?y), (equipped_for_imaging ?x), (empty ?y), (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_soil_analysis ?x), (empty ?y), (available ?x), (equipped_for_rock_analysis ?x), 
;; take_image action has changed: (at ?r ?p), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (supports ?i ?m), (calibration_target ?i ?o), (visible_from ?o ?p), (equipped_for_imaging ?r), (at_soil_sample ?p), (on_board ?i ?r), (have_soil_analysis ?r ?p), (available ?r), (at_rock_sample ?p), (supports ?i ?m), (communicated_soil_data ?p), (have_image ?r ?o ?m), (communicated_rock_data ?p), (available ?r), (calibration_target ?i ?o), (have_rock_analysis ?r ?p), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (full ?s), (equipped_for_soil_analysis ?x), (empty ?s), (communicated_soil_data ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (communicated_rock_data ?p), (available ?x), (equipped_for_imaging ?x), (at ?x ?p), (equipped_for_rock_analysis ?x), (empty ?s), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), 
;; Last_reduced_capability_num_dropped_pals: None
