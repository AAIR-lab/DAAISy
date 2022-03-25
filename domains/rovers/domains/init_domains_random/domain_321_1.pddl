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
               (not (at_rock_sample ?z))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (available ?x))
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(empty ?s)
			(not (full ?s))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
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
               (equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(store_of ?y ?x)
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(full ?y)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(have_rock_analysis ?r ?w)
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
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
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(at ?r ?p)
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(communicated_image_data ?o ?m)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
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
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(visible ?p ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
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
			(equipped_for_imaging ?r)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (communicated_rock_data ?p), (available ?r), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (channel_free ?l), (can_traverse ?r ?y ?x), (at ?r ?x), (have_rock_analysis ?r ?p), (at_soil_sample ?x), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (have_rock_analysis ?r ?y), (visible ?p ?y), (can_traverse ?r ?p ?y), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (at_rock_sample ?p), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (at_soil_sample ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (at_lander ?l ?p), (at_lander ?l ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?p), (communicated_soil_data ?x), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (visible ?p ?y), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (communicated_rock_data ?x), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?y), (at ?r ?y), (visible ?x ?p), (channel_free ?l), (visible ?y ?p), (at ?r ?p), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (available ?r), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (visible ?y ?p), (at ?r ?x), (communicated_soil_data ?y), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?p), (visible ?p ?x), (have_rock_analysis ?r ?p), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (at_rock_sample ?w), (communicated_rock_data ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at ?r ?w), (at_soil_sample ?w), (calibrated ?i ?r), (communicated_soil_data ?w), (calibration_target ?i ?t), (visible_from ?t ?w), (visible_from ?t ?w), (have_soil_analysis ?r ?w), (available ?r), (have_rock_analysis ?r ?w), (calibration_target ?i ?t), (at_soil_sample ?w), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (on_board ?i ?r), (communicated_rock_data ?w), 
;; sample_soil action has changed: (at ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (empty ?s), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (available ?x), (have_soil_analysis ?x ?p), (full ?s), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (communicated_rock_data ?p), (at ?x ?p), (available ?x), (store_of ?s ?x), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), 
;; sample_rock action has changed: (at_soil_sample ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), (full ?s), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (full ?s), (at_rock_sample ?p), (communicated_soil_data ?p), (empty ?s), (empty ?s), (equipped_for_rock_analysis ?x), 
;; navigate action has changed: (communicated_rock_data ?y), (available ?x), (at ?x ?y), (visible ?z ?y), (at ?x ?z), (communicated_soil_data ?y), (can_traverse ?x ?z ?y), (visible ?y ?z), (have_soil_analysis ?x ?y), (visible ?y ?z), (can_traverse ?x ?z ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (at ?x ?y), (can_traverse ?x ?y ?z), (equipped_for_imaging ?x), (communicated_rock_data ?y), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?z), (at_soil_sample ?z), (communicated_soil_data ?z), (communicated_soil_data ?z), (at_soil_sample ?y), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (at_rock_sample ?y), (at_rock_sample ?z), (available ?x), (visible ?z ?y), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), 
;; communicate_image_data action has changed: (visible_from ?o ?x), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (at ?r ?y), (communicated_rock_data ?x), (communicated_image_data ?o ?m), (at_rock_sample ?x), (equipped_for_imaging ?r), (have_image ?r ?o ?m), (at_soil_sample ?y), (available ?r), (communicated_rock_data ?y), (have_soil_analysis ?r ?y), (have_image ?r ?o ?m), (channel_free ?l), (at_soil_sample ?y), (communicated_soil_data ?y), (visible_from ?o ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?y), (equipped_for_imaging ?r), (visible ?x ?y), (at_rock_sample ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (at ?r ?x), (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), (visible_from ?o ?x), (at_lander ?l ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (at ?r ?x), (visible_from ?o ?y), (at ?r ?y), 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (at_rock_sample ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?x), (visible ?p ?y), (communicated_rock_data ?x), (at_soil_sample ?x), (communicated_rock_data ?y), (at_soil_sample ?x), (communicated_soil_data ?y), (channel_free ?l), (visible ?x ?y), (have_soil_analysis ?r ?p), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (at ?r ?y), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?p), (communicated_soil_data ?x), (visible ?y ?p), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?p), (visible ?x ?p), (visible ?p ?x), (visible ?x ?y), (available ?r), (at_lander ?l ?p), (visible ?y ?p), (at_lander ?l ?p), (equipped_for_rock_analysis ?r), (visible ?x ?p), (at_rock_sample ?y), (at ?r ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?y), (equipped_for_imaging ?r), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?x), (visible ?y ?x), (at_soil_sample ?y), (at ?r ?y), (at_lander ?l ?x), (communicated_rock_data ?p), (can_traverse ?r ?x ?y), (at_lander ?l ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?p), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (equipped_for_rock_analysis ?r), (at ?r ?x), (at_rock_sample ?x), 
;; drop action has changed: (empty ?y), (empty ?y), (full ?y), (equipped_for_rock_analysis ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (full ?y), (store_of ?y ?x), (available ?x), (available ?x), (store_of ?y ?x), 
;; take_image action has changed: (on_board ?i ?r), (at_soil_sample ?p), (visible_from ?o ?p), (at_rock_sample ?p), (supports ?i ?m), (on_board ?i ?r), (have_image ?r ?o ?m), (communicated_soil_data ?p), (calibration_target ?i ?o), (communicated_image_data ?o ?m), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (visible_from ?o ?p), (at_soil_sample ?p), (calibrated ?i ?r), (calibrated ?i ?r), (equipped_for_imaging ?r), (at_rock_sample ?p), (available ?r), (communicated_soil_data ?p), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (at ?r ?p), (available ?r), (calibration_target ?i ?o), 
;; Last_reduced_capability_num_dropped_pals: None

