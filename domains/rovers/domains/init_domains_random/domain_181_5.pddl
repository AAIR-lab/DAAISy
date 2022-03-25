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
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(can_traverse ?x ?y ?z)
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(not (at_rock_sample ?y))
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(have_soil_analysis ?x ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(at ?x ?p)
			(not (empty ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(equipped_for_rock_analysis ?x)
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(equipped_for_imaging ?x)
			
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
			(available ?r)
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(communicated_rock_data ?w)
			
          )
    )  
    
    (:action take_image
         :parameters (?r - rover 
                      ?p - waypoint 
                      ?o - objective 
                      ?i - camera 
                      ?m - mode)
         :precondition (and 
               (not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
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
               (channel_free ?l)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(available ?r)
			(at_lander ?l ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(visible ?y ?p)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?x)
			(not (can_traverse ?r ?x ?p))
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
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(equipped_for_rock_analysis ?r)
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
               (not (channel_free ?l))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(have_soil_analysis ?r ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?y)
			(not (visible_from ?o ?y))
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (at ?r ?y), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?x), (at_rock_sample ?y), (equipped_for_rock_analysis ?r), (visible ?y ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (at_lander ?l ?p), (communicated_soil_data ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?y), (at_rock_sample ?x), (at ?r ?p), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (at_soil_sample ?x), (communicated_soil_data ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?y ?p), (visible ?p ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (channel_free ?l), (visible ?p ?x), (at ?r ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?p), (visible ?x ?y), 
;; navigate action has changed: (have_soil_analysis ?x ?y), (have_soil_analysis ?x ?z), (equipped_for_imaging ?x), (visible ?z ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?z ?y), (at ?x ?y), (available ?x), (communicated_soil_data ?y), (communicated_soil_data ?z), (at_soil_sample ?z), (communicated_soil_data ?y), (at_rock_sample ?z), (at_rock_sample ?y), (communicated_rock_data ?z), (equipped_for_rock_analysis ?x), (can_traverse ?x ?z ?y), (can_traverse ?x ?y ?z), (at_rock_sample ?y), (at_soil_sample ?z), (communicated_rock_data ?z), (have_rock_analysis ?x ?z), 
;; calibrate action has changed: (equipped_for_imaging ?r), (calibration_target ?i ?t), (at ?r ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (communicated_soil_data ?w), (calibrated ?i ?r), (at_soil_sample ?w), (available ?r), (communicated_rock_data ?w), (communicated_rock_data ?w), (equipped_for_imaging ?r), (on_board ?i ?r), (at_rock_sample ?w), 
;; take_image action has changed: (at_soil_sample ?p), (available ?r), (have_image ?r ?o ?m), (at ?r ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (on_board ?i ?r), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (supports ?i ?m), (available ?r), (at_rock_sample ?p), (at ?r ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (supports ?i ?m), (communicated_rock_data ?p), (on_board ?i ?r), (have_soil_analysis ?r ?p), 
;; communicate_soil_data action has changed: (at ?r ?x), (visible ?x ?y), (at_rock_sample ?x), (visible ?p ?x), (at_soil_sample ?x), (at_lander ?l ?p), (visible ?p ?x), (have_soil_analysis ?r ?y), (channel_free ?l), (equipped_for_imaging ?r), (at ?r ?p), (at_soil_sample ?y), (can_traverse ?r ?p ?x), (visible ?y ?x), (at ?r ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?y ?p), (can_traverse ?r ?x ?p), (communicated_rock_data ?x), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), 
;; communicate_image_data action has changed: (channel_free ?l), (at_lander ?l ?y), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?y), (at ?r ?x), (available ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?y), (at_rock_sample ?y), (visible_from ?o ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?x), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (visible ?x ?y), (communicated_rock_data ?x), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (communicated_soil_data ?y), (visible_from ?o ?y), (communicated_image_data ?o ?m), (at_rock_sample ?y), (have_soil_analysis ?r ?x), 
;; sample_rock action has changed: (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (empty ?s), (empty ?s), (available ?x), (at_rock_sample ?p), (available ?x), (at_soil_sample ?p), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (communicated_soil_data ?p), (at ?x ?p), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (at ?x ?p), (available ?x), (empty ?s), (empty ?s), (communicated_rock_data ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (full ?s), 
;; drop action has changed: (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None

