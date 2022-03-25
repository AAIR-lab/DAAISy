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
			(visible ?z ?y)
			(at_rock_sample ?y)
			(at ?x ?y)
			(not (at_soil_sample ?z))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (available ?x)
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(not (communicated_soil_data ?z))
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (store_of ?s ?x))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
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
               (not (available ?x))
			(not (empty ?s))
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (at ?x ?p))
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			(equipped_for_rock_analysis ?x)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
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
			(not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(equipped_for_imaging ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(at_soil_sample ?w)
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
			(not (communicated_image_data ?o ?m))
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(visible_from ?o ?p)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
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
               (visible ?p ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (communicated_soil_data ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (visible ?p ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (can_traverse ?r ?x ?p))
			(not (communicated_soil_data ?p))
			(not (visible ?x ?p))
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
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?p)
			(at_lander ?l ?y)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
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
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(at_rock_sample ?y)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			
          )
    )

)

;; 
;; take_image action has changed: (communicated_rock_data ?p), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (have_image ?r ?o ?m), (communicated_soil_data ?p), (available ?r), (calibrated ?i ?r), (have_rock_analysis ?r ?p), (supports ?i ?m), (on_board ?i ?r), (calibrated ?i ?r), (at_rock_sample ?p), (supports ?i ?m), (calibration_target ?i ?o), (communicated_rock_data ?p), (have_image ?r ?o ?m), (calibration_target ?i ?o), (communicated_image_data ?o ?m), (at ?r ?p), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (visible ?p ?x), (communicated_soil_data ?p), (visible ?y ?p), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (at_rock_sample ?p), (visible ?x ?p), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (at ?r ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?p ?y), (available ?r), (available ?r), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (at_rock_sample ?x), (channel_free ?l), (at_soil_sample ?x), (at ?r ?y), (communicated_soil_data ?x), (visible ?p ?x), (communicated_rock_data ?p), (communicated_rock_data ?y), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (at_rock_sample ?p), 
;; sample_rock action has changed: (empty ?s), (have_soil_analysis ?x ?p), (full ?s), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (communicated_soil_data ?p), (have_soil_analysis ?x ?p), (available ?x), (full ?s), (empty ?s), (at_rock_sample ?p), (at ?x ?p), (store_of ?s ?x), (at_soil_sample ?p), (equipped_for_imaging ?x), (at ?x ?p), 
;; navigate action has changed: (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (visible ?z ?y), (have_soil_analysis ?x ?z), (available ?x), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), (visible ?z ?y), (communicated_soil_data ?z), (can_traverse ?x ?y ?z), (equipped_for_imaging ?x), (at_soil_sample ?z), (communicated_rock_data ?z), (at_soil_sample ?z), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?z), (visible ?y ?z), (equipped_for_rock_analysis ?x), (visible ?y ?z), (have_rock_analysis ?x ?y), (can_traverse ?x ?y ?z), (at ?x ?z), (communicated_rock_data ?y), 
;; calibrate action has changed: (at ?r ?w), (at_rock_sample ?w), (available ?r), (equipped_for_rock_analysis ?r), (communicated_soil_data ?w), (calibrated ?i ?r), (equipped_for_soil_analysis ?r), (visible_from ?t ?w), (on_board ?i ?r), (communicated_rock_data ?w), (on_board ?i ?r), (at_soil_sample ?w), (calibration_target ?i ?t), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (available ?r), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), 
;; communicate_image_data action has changed: (communicated_image_data ?o ?m), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (channel_free ?l), (communicated_rock_data ?x), (communicated_image_data ?o ?m), (at_rock_sample ?y), (visible_from ?o ?y), (at_rock_sample ?y), (at ?r ?y), (visible ?y ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (equipped_for_rock_analysis ?r), (at ?r ?y), (have_image ?r ?o ?m), (at_soil_sample ?y), (communicated_soil_data ?y), (at_rock_sample ?x), (at_soil_sample ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?y), 
;; communicate_rock_data action has changed: (at_lander ?l ?p), (visible ?x ?p), (at_rock_sample ?p), (at_lander ?l ?p), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (at ?r ?x), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (visible ?y ?x), (can_traverse ?r ?p ?y), (visible ?y ?p), (visible ?p ?y), (at_rock_sample ?y), (visible ?x ?p), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (available ?r), (at_lander ?l ?y), (can_traverse ?r ?p ?x), (visible ?x ?y), (communicated_rock_data ?x), (communicated_soil_data ?x), (can_traverse ?r ?x ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (at_rock_sample ?x), (at_soil_sample ?y), (available ?r), (communicated_soil_data ?p), (at_soil_sample ?x), 
;; sample_soil action has changed: (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (available ?x), (communicated_soil_data ?p), (at ?x ?p), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (empty ?s), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (full ?s), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (at_soil_sample ?p), 
;; drop action has changed: (full ?y), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None
