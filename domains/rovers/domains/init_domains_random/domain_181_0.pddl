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
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (have_soil_analysis ?x ?z))
			
          )
          :effect (and 
               (not (visible ?z ?y))
			(at_rock_sample ?y)
			(at ?x ?y)
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(at ?x ?z)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (full ?s))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (full ?s))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
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
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (equipped_for_rock_analysis ?x))
			(not (full ?y))
			
          )
        :effect (and 
               (store_of ?y ?x)
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
               (equipped_for_rock_analysis ?r)
			(available ?r)
			(at ?r ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
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
               (not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(visible_from ?o ?p)
			(communicated_rock_data ?p)
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (equipped_for_rock_analysis ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(equipped_for_imaging ?r)
			(not (have_rock_analysis ?r ?p))
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
			(not (visible ?y ?x))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(at_rock_sample ?y)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(visible ?x ?p)
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
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(communicated_rock_data ?p)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
			(not (can_traverse ?r ?p ?x))
			
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
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (at_soil_sample ?y))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(visible_from ?o ?x)
			(at_lander ?l ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; sample_rock action has changed: (equipped_for_imaging ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), (have_soil_analysis ?x ?p), (empty ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), 
;; calibrate action has changed: (on_board ?i ?r), (equipped_for_rock_analysis ?r), (available ?r), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (at_soil_sample ?w), (equipped_for_imaging ?r), (calibration_target ?i ?t), (calibration_target ?i ?t), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?w), (on_board ?i ?r), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (at_soil_sample ?w), 
;; communicate_rock_data action has changed: (available ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (visible ?x ?y), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (visible ?x ?p), (at ?r ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (communicated_rock_data ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (visible ?y ?x), (channel_free ?l), (visible ?y ?x), (visible ?x ?p), (at ?r ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (at_soil_sample ?y), (at_rock_sample ?y), (at_rock_sample ?x), (available ?r), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?p), (visible ?p ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?x), (visible ?p ?x), (equipped_for_rock_analysis ?r), 
;; navigate action has changed: (at_rock_sample ?y), (communicated_soil_data ?y), (at ?x ?y), (at_rock_sample ?y), (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (can_traverse ?x ?z ?y), (visible ?z ?y), (communicated_rock_data ?z), (visible ?y ?z), (at ?x ?y), (have_soil_analysis ?x ?z), (visible ?z ?y), (communicated_soil_data ?z), 
;; communicate_image_data action has changed: (at_soil_sample ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (visible_from ?o ?x), (can_traverse ?r ?y ?x), (visible_from ?o ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (communicated_image_data ?o ?m), (at_rock_sample ?x), (available ?r), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (have_image ?r ?o ?m), (visible ?x ?y), (visible ?y ?x), (have_soil_analysis ?r ?x), (channel_free ?l), (communicated_rock_data ?y), (visible ?x ?y), (communicated_rock_data ?y), 
;; drop action has changed: (store_of ?y ?x), (equipped_for_rock_analysis ?x), (full ?y), (available ?x), (store_of ?y ?x), 
;; sample_soil action has changed: (at_rock_sample ?p), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (at ?x ?p), (at_soil_sample ?p), (full ?s), (full ?s), (empty ?s), (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), 
;; communicate_soil_data action has changed: (visible ?p ?y), (equipped_for_imaging ?r), (at_rock_sample ?p), (visible ?x ?y), (at_soil_sample ?p), (visible ?x ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (channel_free ?l), (at_rock_sample ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?p), (available ?r), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (communicated_rock_data ?p), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (at ?r ?y), (communicated_rock_data ?y), (visible ?y ?x), (have_soil_analysis ?r ?p), (at_rock_sample ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (communicated_soil_data ?p), (visible ?y ?x), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (at_lander ?l ?p), (at ?r ?y), (visible ?x ?p), (visible ?x ?p), (have_rock_analysis ?r ?x), (at ?r ?p), (visible ?y ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?y), 
;; take_image action has changed: (communicated_rock_data ?p), (equipped_for_imaging ?r), (calibrated ?i ?r), (calibration_target ?i ?o), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (supports ?i ?m), (have_rock_analysis ?r ?p), (available ?r), (calibration_target ?i ?o), 
;; Last_reduced_capability_num_dropped_pals: None

