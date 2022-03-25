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
			(available ?x)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(communicated_rock_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(not (can_traverse ?x ?y ?z))
			(communicated_rock_data ?y)
			(equipped_for_soil_analysis ?x)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(at ?x ?y)
			(have_soil_analysis ?x ?y)
			(not (communicated_soil_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_imaging ?x))
			(not (full ?s))
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_rock_data ?p)
			(not (equipped_for_rock_analysis ?x))
			
          )
        :effect (and 
               (empty ?s)
			(equipped_for_imaging ?x)
			(full ?s)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
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
			(full ?s)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(equipped_for_rock_analysis ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (store_of ?y ?x))
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			
          )
        :effect (and 
               (store_of ?y ?x)
			(equipped_for_soil_analysis ?x)
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
               (not (calibration_target ?i ?t))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			(not (calibrated ?i ?r))
			
          )
         :effect (and 
               (not (equipped_for_rock_analysis ?r))
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			
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
			(equipped_for_rock_analysis ?r)
			(available ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(calibrated ?i ?r)
			(not (at ?r ?p))
			
          )
          :effect (and 
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(equipped_for_rock_analysis ?r)
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_soil_analysis ?r))
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (visible_from ?o ?p))
			(communicated_rock_data ?p)
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
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(at_soil_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (communicated_rock_data ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			
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
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(communicated_rock_data ?y)
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (available ?r))
			(not (visible_from ?o ?x))
			(at_lander ?l ?y)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; navigate action has changed: (equipped_for_soil_analysis ?x), (at_rock_sample ?z), (can_traverse ?x ?y ?z), (communicated_rock_data ?y), (communicated_rock_data ?y), (at ?x ?y), (at_soil_sample ?z), (available ?x), (can_traverse ?x ?z ?y), (at_soil_sample ?y), (have_soil_analysis ?x ?z), (visible ?z ?y), (have_soil_analysis ?x ?y), (communicated_soil_data ?z), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (communicated_soil_data ?y), (communicated_rock_data ?z), (visible ?y ?z), (at_rock_sample ?z), (at ?x ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (communicated_soil_data ?y), 
;; sample_soil action has changed: (empty ?s), (at_soil_sample ?p), (at ?x ?p), (equipped_for_imaging ?x), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (full ?s), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), 
;; communicate_rock_data action has changed: (at_soil_sample ?y), (communicated_rock_data ?y), (can_traverse ?r ?y ?p), (channel_free ?l), (at_soil_sample ?x), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (channel_free ?l), (at_rock_sample ?x), (can_traverse ?r ?p ?y), (can_traverse ?r ?x ?y), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (have_soil_analysis ?r ?y), (can_traverse ?r ?x ?y), (visible ?p ?y), (communicated_rock_data ?p), (visible ?x ?y), (communicated_rock_data ?x), (at_rock_sample ?p), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (equipped_for_imaging ?r), (at_lander ?l ?p), (available ?r), (visible ?x ?p), (visible ?y ?x), (have_rock_analysis ?r ?y), (visible ?x ?p), (communicated_soil_data ?x), (at ?r ?y), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?p), (communicated_rock_data ?x), (at ?r ?x), (at_lander ?l ?x), (at_rock_sample ?p), (at_rock_sample ?y), (at_rock_sample ?y), (at ?r ?y), (equipped_for_rock_analysis ?r), (at_lander ?l ?p), (visible ?y ?p), (equipped_for_rock_analysis ?r), 
;; calibrate action has changed: (at_rock_sample ?w), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at_rock_sample ?w), (communicated_rock_data ?w), (on_board ?i ?r), (calibration_target ?i ?t), (calibrated ?i ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?w), (at ?r ?w), (calibrated ?i ?r), (available ?r), (visible_from ?t ?w), (visible_from ?t ?w), (communicated_soil_data ?w), 
;; communicate_soil_data action has changed: (communicated_soil_data ?y), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_rock_sample ?x), (channel_free ?l), (at_soil_sample ?y), (visible ?y ?x), (can_traverse ?r ?x ?p), (visible ?p ?y), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (visible ?p ?y), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (at_lander ?l ?y), (can_traverse ?r ?p ?y), (communicated_rock_data ?p), (at ?r ?p), (visible ?p ?x), (equipped_for_rock_analysis ?r), (communicated_soil_data ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?x), (at ?r ?p), (at_soil_sample ?y), (equipped_for_imaging ?r), (at ?r ?x), (available ?r), (have_rock_analysis ?r ?x), (communicated_soil_data ?p), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?p), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?x), (communicated_rock_data ?x), (communicated_rock_data ?x), (channel_free ?l), (at_lander ?l ?p), (communicated_soil_data ?p), (have_soil_analysis ?r ?y), (communicated_rock_data ?p), (visible ?x ?y), (can_traverse ?r ?x ?y), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), 
;; communicate_image_data action has changed: (communicated_soil_data ?y), (at_lander ?l ?x), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (channel_free ?l), (available ?r), (at ?r ?y), (visible ?x ?y), (available ?r), (communicated_image_data ?o ?m), (visible ?y ?x), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?x), (have_image ?r ?o ?m), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?y), (communicated_rock_data ?y), (communicated_rock_data ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (visible_from ?o ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (visible_from ?o ?x), (have_rock_analysis ?r ?x), (visible_from ?o ?x), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (communicated_rock_data ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (have_image ?r ?o ?m), 
;; take_image action has changed: (communicated_image_data ?o ?m), (have_image ?r ?o ?m), (at ?r ?p), (have_image ?r ?o ?m), (calibration_target ?i ?o), (on_board ?i ?r), (calibration_target ?i ?o), (supports ?i ?m), (communicated_rock_data ?p), (on_board ?i ?r), (have_soil_analysis ?r ?p), (calibrated ?i ?r), (at_soil_sample ?p), (supports ?i ?m), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (available ?r), (have_rock_analysis ?r ?p), (available ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?p), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (at ?r ?p), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (visible_from ?o ?p), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (store_of ?s ?x), (available ?x), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (at_rock_sample ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (full ?s), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_imaging ?x), (store_of ?y ?x), (empty ?y), (full ?y), (available ?x), (store_of ?y ?x), (equipped_for_soil_analysis ?x), 
;; Last_reduced_capability_num_dropped_pals: None

