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
			(not (available ?x))
			(not (visible ?z ?y))
			(equipped_for_imaging ?x)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(not (have_soil_analysis ?x ?y))
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (available ?x))
			(equipped_for_imaging ?x)
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (available ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			
          )
        :effect (and 
               (not (store_of ?y ?x))
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
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
			(not (equipped_for_rock_analysis ?r))
			(not (have_soil_analysis ?r ?w))
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(at ?r ?w)
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (communicated_rock_data ?w))
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
               (not (supports ?i ?m))
			(communicated_image_data ?o ?m)
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(not (have_rock_analysis ?r ?p))
			(at_rock_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
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
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(not (available ?r))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
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
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(visible ?y ?p)
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(visible ?y ?p)
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
               (not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(not (communicated_rock_data ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (at ?r ?x))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (at_lander ?l ?y), (communicated_rock_data ?x), (visible ?x ?p), (have_rock_analysis ?r ?p), (at ?r ?x), (at_rock_sample ?p), (communicated_rock_data ?p), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (at_lander ?l ?y), (at_soil_sample ?x), (at_soil_sample ?x), (visible ?p ?x), (have_rock_analysis ?r ?x), (communicated_soil_data ?p), (available ?r), (visible ?y ?p), (visible ?y ?p), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?y), (visible ?p ?y), (available ?r), (equipped_for_soil_analysis ?r), (at ?r ?y), (equipped_for_soil_analysis ?r), (visible ?y ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?p), (at ?r ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (at_soil_sample ?y), (have_soil_analysis ?r ?p), (at ?r ?x), (at_soil_sample ?p), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?p), (at_rock_sample ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?p), (have_rock_analysis ?r ?y), (can_traverse ?r ?y ?p), (at_lander ?l ?x), 
;; communicate_rock_data action has changed: (equipped_for_soil_analysis ?r), (at ?r ?y), (visible ?y ?p), (available ?r), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?p), (can_traverse ?r ?x ?p), (at_rock_sample ?x), (communicated_soil_data ?x), (at_rock_sample ?p), (at ?r ?x), (communicated_soil_data ?x), (at_soil_sample ?p), (visible ?x ?y), (at_lander ?l ?x), (communicated_soil_data ?y), (at_soil_sample ?p), (at ?r ?p), (at_lander ?l ?p), (can_traverse ?r ?p ?x), (visible ?p ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (equipped_for_rock_analysis ?r), (at ?r ?p), (visible ?p ?x), (have_soil_analysis ?r ?p), (channel_free ?l), (have_rock_analysis ?r ?x), (visible ?p ?x), (at_soil_sample ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?p), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (can_traverse ?r ?p ?y), (communicated_rock_data ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (at_rock_sample ?p), (at_rock_sample ?y), (visible ?x ?p), (communicated_soil_data ?y), (visible ?p ?y), (visible ?y ?x), (at_soil_sample ?y), (can_traverse ?r ?x ?p), (can_traverse ?r ?x ?y), (at_soil_sample ?x), (communicated_soil_data ?p), (at ?r ?x), (available ?r), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (at_lander ?l ?p), (visible ?y ?p), (communicated_rock_data ?y), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (at ?r ?y), (have_soil_analysis ?r ?x), (visible ?x ?y), (equipped_for_rock_analysis ?r), (communicated_soil_data ?x), (have_image ?r ?o ?m), (equipped_for_rock_analysis ?r), (communicated_rock_data ?y), (available ?r), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (communicated_image_data ?o ?m), (at_lander ?l ?x), (visible_from ?o ?x), (at_soil_sample ?x), (have_rock_analysis ?r ?x), (visible_from ?o ?x), (at_rock_sample ?y), (have_rock_analysis ?r ?x), (channel_free ?l), (at_rock_sample ?x), (at ?r ?x), (communicated_image_data ?o ?m), (at_lander ?l ?x), (visible ?y ?x), (at_soil_sample ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?x), (visible ?x ?y), (equipped_for_soil_analysis ?r), (visible_from ?o ?y), (have_rock_analysis ?r ?y), (at ?r ?x), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (visible_from ?o ?y), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (available ?r), (at_lander ?l ?y), (visible ?y ?x), (at_rock_sample ?x), 
;; drop action has changed: (empty ?y), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (full ?y), (full ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), 
;; take_image action has changed: (communicated_image_data ?o ?m), (at_soil_sample ?p), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (available ?r), (have_rock_analysis ?r ?p), (at ?r ?p), (calibration_target ?i ?o), (visible_from ?o ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?p), (communicated_soil_data ?p), (have_image ?r ?o ?m), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (supports ?i ?m), (calibration_target ?i ?o), (at_rock_sample ?p), (available ?r), (at_rock_sample ?p), (on_board ?i ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), 
;; calibrate action has changed: (at_soil_sample ?w), (at ?r ?w), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (available ?r), (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (at_rock_sample ?w), (have_rock_analysis ?r ?w), (equipped_for_imaging ?r), (calibrated ?i ?r), (at ?r ?w), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (available ?r), (on_board ?i ?r), (communicated_rock_data ?w), (at_soil_sample ?w), 
;; navigate action has changed: (at_rock_sample ?y), (at ?x ?y), (available ?x), (communicated_rock_data ?y), (communicated_soil_data ?y), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (visible ?y ?z), (available ?x), (communicated_soil_data ?y), (equipped_for_imaging ?x), (at_soil_sample ?z), (communicated_soil_data ?z), (at_soil_sample ?y), (at_rock_sample ?z), (at ?x ?z), (equipped_for_soil_analysis ?x), (visible ?z ?y), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?z), (equipped_for_imaging ?x), (have_soil_analysis ?x ?y), (communicated_soil_data ?z), (at ?x ?z), (can_traverse ?x ?y ?z), (communicated_rock_data ?y), (visible ?y ?z), 
;; sample_rock action has changed: (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (full ?s), (communicated_rock_data ?p), (empty ?s), (have_rock_analysis ?x ?p), (communicated_soil_data ?p), (store_of ?s ?x), (at ?x ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (empty ?s), 
;; sample_soil action has changed: (empty ?s), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (store_of ?s ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (at_soil_sample ?p), (communicated_soil_data ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (available ?x), (at ?x ?p), (full ?s), (have_soil_analysis ?x ?p), (communicated_rock_data ?p), (available ?x), 
;; Last_reduced_capability_num_dropped_pals: None
