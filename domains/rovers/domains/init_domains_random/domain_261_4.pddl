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
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_rock_data ?z))
			(equipped_for_rock_analysis ?x)
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(at_soil_sample ?z)
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (visible ?y ?z))
			(not (at ?x ?z))
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(not (at_soil_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			
          )
        :effect (and 
               (available ?x)
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (full ?s))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(not (full ?s))
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(empty ?y)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (store_of ?y ?x))
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
               (not (have_soil_analysis ?r ?w))
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_soil_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(not (communicated_soil_data ?w))
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
               (supports ?i ?m)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (calibration_target ?i ?o))
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (visible_from ?o ?p))
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
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(visible ?y ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
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
               (not (channel_free ?l))
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?p))
			(not (at_rock_sample ?y))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(not (available ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(at_lander ?l ?p)
			(visible ?x ?p)
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			
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
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (at_rock_sample ?x))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?x))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (visible ?p ?y), (at_lander ?l ?p), (at_lander ?l ?x), (communicated_soil_data ?p), (have_rock_analysis ?r ?y), (visible ?x ?y), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?x), (at ?r ?x), (at ?r ?x), (communicated_soil_data ?x), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?p), (channel_free ?l), (visible ?x ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (visible ?y ?x), (communicated_soil_data ?y), (visible ?y ?p), (available ?r), (at_rock_sample ?p), (visible ?p ?x), (equipped_for_rock_analysis ?r), (visible ?p ?y), (communicated_rock_data ?y), (communicated_rock_data ?x), (visible ?p ?x), (visible ?x ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (at_rock_sample ?x), (at_soil_sample ?x), (at ?r ?y), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (can_traverse ?r ?x ?p), (available ?r), (visible ?y ?p), (have_soil_analysis ?r ?x), 
;; sample_rock action has changed: (at ?x ?p), (at_rock_sample ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (full ?s), (communicated_soil_data ?p), (empty ?s), (at ?x ?p), (equipped_for_rock_analysis ?x), (at_soil_sample ?p), (store_of ?s ?x), (store_of ?s ?x), (empty ?s), (equipped_for_soil_analysis ?x), (full ?s), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), 
;; communicate_soil_data action has changed: (at_rock_sample ?y), (at ?r ?y), (communicated_rock_data ?y), (communicated_soil_data ?p), (have_soil_analysis ?r ?p), (communicated_rock_data ?x), (at_soil_sample ?x), (at_soil_sample ?y), (visible ?x ?y), (can_traverse ?r ?y ?p), (at_rock_sample ?p), (can_traverse ?r ?p ?x), (channel_free ?l), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?p), (at ?r ?p), (at_soil_sample ?p), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (available ?r), (can_traverse ?r ?y ?x), (have_rock_analysis ?r ?x), (visible ?x ?p), (at_lander ?l ?p), (communicated_soil_data ?y), (communicated_soil_data ?y), (at_lander ?l ?y), (at_lander ?l ?p), (communicated_soil_data ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (visible ?p ?y), (at_rock_sample ?x), (can_traverse ?r ?p ?y), (communicated_rock_data ?y), (visible ?p ?x), (communicated_soil_data ?x), (at_rock_sample ?p), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?p), (available ?r), (equipped_for_soil_analysis ?r), (at ?r ?x), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (visible ?y ?x), (can_traverse ?r ?x ?y), (visible ?p ?y), (communicated_soil_data ?p), 
;; communicate_image_data action has changed: (at_rock_sample ?x), (available ?r), (at ?r ?x), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (at ?r ?x), (communicated_rock_data ?x), (communicated_rock_data ?y), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (visible ?y ?x), (communicated_soil_data ?x), (at_lander ?l ?x), (equipped_for_imaging ?r), (visible_from ?o ?y), (at ?r ?y), (communicated_image_data ?o ?m), (visible_from ?o ?x), (can_traverse ?r ?y ?x), (at_rock_sample ?y), (channel_free ?l), (at_soil_sample ?x), (channel_free ?l), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (visible ?y ?x), (communicated_rock_data ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (visible ?x ?y), (available ?r), (can_traverse ?r ?y ?x), (at_rock_sample ?y), 
;; take_image action has changed: (have_image ?r ?o ?m), (calibration_target ?i ?o), (available ?r), (have_image ?r ?o ?m), (communicated_image_data ?o ?m), (supports ?i ?m), (at_soil_sample ?p), (have_soil_analysis ?r ?p), (visible_from ?o ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (communicated_rock_data ?p), (visible_from ?o ?p), (have_rock_analysis ?r ?p), (available ?r), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (calibrated ?i ?r), (on_board ?i ?r), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (calibration_target ?i ?o), 
;; navigate action has changed: (at ?x ?z), (communicated_rock_data ?z), (at_soil_sample ?z), (visible ?z ?y), (at ?x ?z), (have_rock_analysis ?x ?y), (communicated_soil_data ?z), (equipped_for_imaging ?x), (available ?x), (available ?x), (have_soil_analysis ?x ?y), (at ?x ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?z), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (communicated_rock_data ?z), (visible ?y ?z), (visible ?y ?z), (at_soil_sample ?y), (communicated_rock_data ?y), (at_rock_sample ?y), (can_traverse ?x ?z ?y), (communicated_rock_data ?y), (can_traverse ?x ?z ?y), (visible ?z ?y), (at_soil_sample ?z), (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (at_rock_sample ?y), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (available ?x), (full ?y), (empty ?y), (store_of ?y ?x), (store_of ?y ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (available ?x), 
;; calibrate action has changed: (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (calibrated ?i ?r), (on_board ?i ?r), (calibration_target ?i ?t), (available ?r), (have_soil_analysis ?r ?w), (calibration_target ?i ?t), (at_soil_sample ?w), (equipped_for_imaging ?r), (available ?r), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (at_rock_sample ?w), (at_soil_sample ?w), (communicated_soil_data ?w), (visible_from ?t ?w), (at ?r ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (on_board ?i ?r), 
;; sample_soil action has changed: (empty ?s), (available ?x), (communicated_soil_data ?p), (store_of ?s ?x), (at_soil_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (empty ?s), (equipped_for_soil_analysis ?x), (full ?s), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (store_of ?s ?x), 
;; Last_reduced_capability_num_dropped_pals: None

