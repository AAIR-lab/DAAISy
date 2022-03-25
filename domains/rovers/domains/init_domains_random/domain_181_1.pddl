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
               (not (visible ?z ?y))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(communicated_soil_data ?z)
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(not (visible ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(full ?s)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (at ?r ?w))
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
			(at_soil_sample ?w)
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
			(not (communicated_image_data ?o ?m))
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(have_rock_analysis ?r ?p)
			(visible_from ?o ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
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
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(communicated_soil_data ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
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
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
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
			(not (equipped_for_imaging ?r))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (available ?r))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(not (communicated_soil_data ?x))
			(not (visible_from ?o ?y))
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(at ?r ?x)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (at ?r ?y), (visible ?x ?y), (visible ?x ?y), (communicated_soil_data ?p), (at ?r ?p), (at_soil_sample ?p), (can_traverse ?r ?x ?y), (available ?r), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?x), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (at ?r ?y), (at_lander ?l ?x), (visible ?p ?y), (have_rock_analysis ?r ?y), (at_rock_sample ?p), (communicated_soil_data ?y), (at_soil_sample ?p), (communicated_rock_data ?y), (visible ?y ?p), (can_traverse ?r ?p ?y), (visible ?p ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?x), (communicated_rock_data ?p), (visible ?x ?p), (at_lander ?l ?p), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (empty ?s), (available ?x), (at ?x ?p), (equipped_for_imaging ?x), (at_rock_sample ?p), (communicated_rock_data ?p), 
;; communicate_rock_data action has changed: (at_soil_sample ?x), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (visible ?y ?p), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), (communicated_soil_data ?p), (at_soil_sample ?y), (communicated_soil_data ?y), (visible ?x ?p), (at_soil_sample ?p), (channel_free ?l), (can_traverse ?r ?y ?p), (at ?r ?x), (have_soil_analysis ?r ?p), (at_lander ?l ?x), (visible ?y ?p), (at_soil_sample ?y), (communicated_rock_data ?y), (visible ?y ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?x), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?y), (at ?r ?p), (communicated_rock_data ?x), 
;; navigate action has changed: (at_rock_sample ?z), (at_soil_sample ?z), (have_rock_analysis ?x ?z), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?y), (can_traverse ?x ?z ?y), (communicated_rock_data ?y), (at ?x ?z), (have_soil_analysis ?x ?z), (visible ?y ?z), (have_soil_analysis ?x ?y), (visible ?z ?y), (available ?x), (communicated_soil_data ?z), (communicated_soil_data ?z), (at ?x ?y), (visible ?z ?y), 
;; communicate_image_data action has changed: (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (communicated_soil_data ?x), (at ?r ?x), (communicated_rock_data ?x), (available ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (equipped_for_rock_analysis ?r), (visible_from ?o ?x), (at ?r ?y), (communicated_rock_data ?y), (channel_free ?l), (visible_from ?o ?y), (at_rock_sample ?x), (at_soil_sample ?x), (visible ?y ?x), (at_soil_sample ?y), (can_traverse ?r ?x ?y), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (have_image ?r ?o ?m), 
;; sample_soil action has changed: (available ?x), (full ?s), (full ?s), (store_of ?s ?x), (equipped_for_imaging ?x), (communicated_soil_data ?p), (available ?x), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (empty ?s), (equipped_for_soil_analysis ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (at ?x ?p), (store_of ?s ?x), (equipped_for_rock_analysis ?x), 
;; calibrate action has changed: (equipped_for_rock_analysis ?r), (at_soil_sample ?w), (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (available ?r), (communicated_rock_data ?w), (equipped_for_soil_analysis ?r), (at ?r ?w), (calibration_target ?i ?t), (on_board ?i ?r), (at_soil_sample ?w), (calibration_target ?i ?t), (communicated_soil_data ?w), (on_board ?i ?r), (visible_from ?t ?w), 
;; drop action has changed: (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_soil_analysis ?x), (empty ?y), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (equipped_for_imaging ?r), (on_board ?i ?r), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (calibration_target ?i ?o), (at ?r ?p), (have_rock_analysis ?r ?p), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (on_board ?i ?r), (at ?r ?p), 
;; Last_reduced_capability_num_dropped_pals: None

