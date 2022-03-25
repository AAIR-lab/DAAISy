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
			(not (visible ?z ?y))
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(communicated_soil_data ?y)
			(equipped_for_rock_analysis ?x)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(visible ?z ?y)
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (available ?x))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (equipped_for_imaging ?x))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
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
			(empty ?s)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (available ?x)
			(not (empty ?y))
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
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (visible_from ?t ?w))
			(not (communicated_soil_data ?w))
			(not (communicated_rock_data ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(available ?r)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_rock_data ?w)
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
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (equipped_for_rock_analysis ?r))
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
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
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(at_rock_sample ?x)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
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
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (have_rock_analysis ?r ?p))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
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
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(at ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(communicated_soil_data ?y)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (equipped_for_imaging ?r), (at_rock_sample ?x), (visible ?x ?p), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (at_rock_sample ?y), (available ?r), (can_traverse ?r ?x ?y), (visible ?y ?x), (at_lander ?l ?x), (visible ?p ?x), (at_soil_sample ?x), (at ?r ?p), (at_soil_sample ?p), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (at_rock_sample ?x), (at ?r ?x), (at_rock_sample ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?x), (equipped_for_rock_analysis ?r), (visible ?x ?y), (at_lander ?l ?y), (at_soil_sample ?y), (visible ?y ?p), (communicated_rock_data ?x), (communicated_rock_data ?p), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (at ?r ?p), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?p), (visible ?p ?y), (visible ?x ?y), (communicated_rock_data ?x), (equipped_for_imaging ?r), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (can_traverse ?r ?y ?x), (visible ?y ?x), (at_lander ?l ?p), (at_lander ?l ?p), (at_soil_sample ?p), (at_rock_sample ?p), (communicated_soil_data ?y), (have_rock_analysis ?r ?p), (at ?r ?y), (channel_free ?l), (equipped_for_rock_analysis ?r), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?x), (visible ?y ?p), (at_lander ?l ?y), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (at ?r ?y), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?y), (at_rock_sample ?p), 
;; take_image action has changed: (supports ?i ?m), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (equipped_for_imaging ?r), (communicated_rock_data ?p), (calibrated ?i ?r), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (at_rock_sample ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (at ?r ?p), (communicated_soil_data ?p), (on_board ?i ?r), (at_soil_sample ?p), (have_soil_analysis ?r ?p), (calibrated ?i ?r), (on_board ?i ?r), (equipped_for_rock_analysis ?r), (supports ?i ?m), (at ?r ?p), (calibration_target ?i ?o), (communicated_image_data ?o ?m), 
;; sample_rock action has changed: (empty ?s), (at_soil_sample ?p), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (available ?x), (communicated_rock_data ?p), (at_rock_sample ?p), (store_of ?s ?x), (full ?s), (communicated_soil_data ?p), (equipped_for_imaging ?x), (at ?x ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (store_of ?s ?x), (at_rock_sample ?p), (full ?s), (equipped_for_rock_analysis ?x), (at ?x ?p), (available ?x), (communicated_rock_data ?p), 
;; sample_soil action has changed: (equipped_for_imaging ?x), (available ?x), (have_rock_analysis ?x ?p), (store_of ?s ?x), (full ?s), (at_rock_sample ?p), (equipped_for_imaging ?x), (full ?s), (have_rock_analysis ?x ?p), (empty ?s), (at ?x ?p), (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (empty ?s), (communicated_soil_data ?p), (at ?x ?p), (at_rock_sample ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), 
;; communicate_rock_data action has changed: (at_rock_sample ?y), (visible ?y ?x), (at ?r ?p), (visible ?x ?p), (at_rock_sample ?p), (equipped_for_soil_analysis ?r), (visible ?p ?x), (at_soil_sample ?p), (communicated_rock_data ?y), (at_lander ?l ?x), (communicated_rock_data ?p), (equipped_for_imaging ?r), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?x), (can_traverse ?r ?y ?x), (at ?r ?p), (at_lander ?l ?p), (communicated_soil_data ?y), (visible ?x ?p), (at ?r ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (available ?r), (at_rock_sample ?x), (at_rock_sample ?y), (can_traverse ?r ?x ?p), (at ?r ?y), (visible ?p ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?y), (visible ?x ?y), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?x), (can_traverse ?r ?x ?y), (visible ?p ?y), (have_rock_analysis ?r ?p), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (at_lander ?l ?y), (visible ?x ?y), (communicated_rock_data ?x), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (at_lander ?l ?x), (visible ?y ?x), (at_lander ?l ?p), (communicated_soil_data ?p), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (communicated_soil_data ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?y), (communicated_soil_data ?p), 
;; navigate action has changed: (have_soil_analysis ?x ?y), (equipped_for_imaging ?x), (at ?x ?z), (at_rock_sample ?z), (can_traverse ?x ?z ?y), (have_rock_analysis ?x ?y), (have_soil_analysis ?x ?z), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?z ?y), (visible ?y ?z), (available ?x), (communicated_rock_data ?y), (visible ?z ?y), (communicated_soil_data ?y), (communicated_soil_data ?z), (at ?x ?z), (visible ?z ?y), (have_soil_analysis ?x ?z), (equipped_for_rock_analysis ?x), (available ?x), (communicated_soil_data ?y), (have_soil_analysis ?x ?y), (equipped_for_imaging ?x), (have_rock_analysis ?x ?y), (at_soil_sample ?z), (visible ?y ?z), (communicated_rock_data ?y), (can_traverse ?x ?y ?z), (at_soil_sample ?z), (equipped_for_rock_analysis ?x), (at_rock_sample ?y), (at_rock_sample ?z), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (store_of ?y ?x), (empty ?y), (available ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (available ?x), 
;; calibrate action has changed: (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (equipped_for_rock_analysis ?r), (calibration_target ?i ?t), (calibrated ?i ?r), (at_rock_sample ?w), (at ?r ?w), (on_board ?i ?r), (communicated_rock_data ?w), (at_soil_sample ?w), (available ?r), (communicated_rock_data ?w), (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (on_board ?i ?r), (visible_from ?t ?w), (available ?r), (visible_from ?t ?w), (equipped_for_rock_analysis ?r), 
;; communicate_image_data action has changed: (at_lander ?l ?y), (communicated_rock_data ?x), (communicated_rock_data ?y), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (equipped_for_imaging ?r), (at ?r ?x), (communicated_soil_data ?y), (at_soil_sample ?y), (available ?r), (at_lander ?l ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?y), (visible ?x ?y), (visible_from ?o ?y), (visible_from ?o ?x), (at_soil_sample ?y), (visible ?y ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (at_rock_sample ?y), (at ?r ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?x), (at_soil_sample ?x), (at_rock_sample ?y), (have_rock_analysis ?r ?y), (visible ?x ?y), (at ?r ?y), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (channel_free ?l), (have_image ?r ?o ?m), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (available ?r), (channel_free ?l), (communicated_soil_data ?x), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (visible_from ?o ?x), (can_traverse ?r ?y ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), 
;; Last_reduced_capability_num_dropped_pals: None

