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
			(visible ?z ?y)
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?z))
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			
          )
          :effect (and 
               (not (have_rock_analysis ?x ?z))
			(visible ?z ?y)
			(equipped_for_imaging ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(not (visible ?y ?z))
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
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
			(not (full ?s))
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_imaging ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?x ?p))
			
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
			(equipped_for_soil_analysis ?x)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(store_of ?y ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (calibration_target ?i ?t))
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(have_rock_analysis ?r ?w)
			(not (communicated_rock_data ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_imaging ?r)
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (communicated_soil_data ?w))
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
               (not (supports ?i ?m))
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(available ?r)
			(have_image ?r ?o ?m)
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (communicated_image_data ?o ?m))
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?p))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
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
               (visible ?y ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(at_rock_sample ?x)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (communicated_rock_data ?p))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(not (communicated_soil_data ?p))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(not (available ?r))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
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
               (not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?x))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (communicated_image_data ?o ?m))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (visible ?p ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?y), (have_soil_analysis ?r ?p), (at_rock_sample ?p), (communicated_rock_data ?x), (communicated_soil_data ?p), (at ?r ?y), (visible ?p ?x), (communicated_soil_data ?x), (channel_free ?l), (equipped_for_rock_analysis ?r), (at ?r ?p), (communicated_rock_data ?p), (can_traverse ?r ?x ?p), (available ?r), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (can_traverse ?r ?x ?p), (visible ?x ?y), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?p ?y), (at_lander ?l ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (at_rock_sample ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (at_lander ?l ?y), (at ?r ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?y), (can_traverse ?r ?p ?y), (at_lander ?l ?x), (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?y ?p), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (visible ?p ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (at_lander ?l ?x), (communicated_rock_data ?y), (visible ?p ?y), (at ?r ?p), (at_lander ?l ?y), (visible ?y ?p), (equipped_for_soil_analysis ?r), (at_rock_sample ?x), (visible ?x ?p), (communicated_soil_data ?x), (at_soil_sample ?p), (have_rock_analysis ?r ?x), (communicated_rock_data ?y), (communicated_soil_data ?p), (channel_free ?l), (have_soil_analysis ?r ?x), (visible ?y ?p), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), (visible ?y ?x), (communicated_soil_data ?y), (have_rock_analysis ?r ?p), (at_lander ?l ?p), (visible ?y ?x), (visible ?x ?p), (at ?r ?y), 
;; take_image action has changed: (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (visible_from ?o ?p), (equipped_for_soil_analysis ?r), (communicated_soil_data ?p), (calibration_target ?i ?o), (calibrated ?i ?r), (available ?r), (supports ?i ?m), (equipped_for_rock_analysis ?r), (have_image ?r ?o ?m), (on_board ?i ?r), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?p), (supports ?i ?m), (at ?r ?p), (communicated_soil_data ?p), (communicated_rock_data ?p), (visible_from ?o ?p), (equipped_for_soil_analysis ?r), (calibration_target ?i ?o), (equipped_for_rock_analysis ?r), (at_soil_sample ?p), (at_rock_sample ?p), (available ?r), (communicated_image_data ?o ?m), (communicated_image_data ?o ?m), (at ?r ?p), (have_image ?r ?o ?m), (at_soil_sample ?p), (equipped_for_imaging ?r), (at_rock_sample ?p), 
;; communicate_image_data action has changed: (visible ?y ?x), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (visible_from ?o ?y), (at_rock_sample ?x), (at_lander ?l ?y), (channel_free ?l), (at_lander ?l ?y), (visible ?y ?x), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?x), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (communicated_image_data ?o ?m), (can_traverse ?r ?y ?x), (channel_free ?l), (at_soil_sample ?x), (at_soil_sample ?x), (visible ?x ?y), (available ?r), (at_soil_sample ?y), (at ?r ?y), (available ?r), (at ?r ?y), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (visible_from ?o ?y), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (have_soil_analysis ?r ?x), (communicated_soil_data ?y), (at ?r ?x), (communicated_rock_data ?y), (at_lander ?l ?x), (visible ?x ?y), (have_image ?r ?o ?m), (have_image ?r ?o ?m), (communicated_rock_data ?x), (at_rock_sample ?x), (have_rock_analysis ?r ?x), (visible_from ?o ?x), (at ?r ?x), (communicated_rock_data ?x), (communicated_rock_data ?y), (can_traverse ?r ?x ?y), 
;; communicate_rock_data action has changed: (channel_free ?l), (communicated_rock_data ?x), (at_soil_sample ?y), (visible ?p ?y), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?y), (at_lander ?l ?x), (communicated_soil_data ?y), (equipped_for_imaging ?r), (at_soil_sample ?x), (channel_free ?l), (communicated_rock_data ?y), (equipped_for_soil_analysis ?r), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (visible ?y ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (at_rock_sample ?y), (available ?r), (communicated_soil_data ?y), (have_soil_analysis ?r ?y), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (at_soil_sample ?p), (at_lander ?l ?p), (visible ?x ?p), (have_rock_analysis ?r ?p), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (at ?r ?y), (equipped_for_imaging ?r), (at ?r ?y), (visible ?y ?x), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?y), (at_soil_sample ?y), (visible ?y ?x), (at_soil_sample ?p), (at ?r ?x), (at ?r ?p), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (visible ?p ?x), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (communicated_rock_data ?y), (at ?r ?p), (communicated_rock_data ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?y), (at ?r ?x), (can_traverse ?r ?y ?x), (visible ?x ?y), (visible ?x ?y), (have_soil_analysis ?r ?x), (at_rock_sample ?x), 
;; sample_rock action has changed: (have_rock_analysis ?x ?p), (empty ?s), (at_soil_sample ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (at ?x ?p), (full ?s), (have_soil_analysis ?x ?p), (store_of ?s ?x), (at ?x ?p), (communicated_rock_data ?p), (have_rock_analysis ?x ?p), (available ?x), (at_soil_sample ?p), (equipped_for_soil_analysis ?x), (store_of ?s ?x), (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), 
;; navigate action has changed: (at_rock_sample ?y), (equipped_for_rock_analysis ?x), (visible ?z ?y), (visible ?z ?y), (communicated_soil_data ?z), (can_traverse ?x ?z ?y), (equipped_for_soil_analysis ?x), (visible ?y ?z), (have_soil_analysis ?x ?y), (at_soil_sample ?z), (equipped_for_imaging ?x), (at ?x ?z), (at ?x ?y), (at ?x ?y), (can_traverse ?x ?y ?z), (at_soil_sample ?z), (can_traverse ?x ?z ?y), (at_soil_sample ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (have_soil_analysis ?x ?z), (communicated_rock_data ?z), (at ?x ?z), (communicated_rock_data ?z), (visible ?y ?z), (have_soil_analysis ?x ?y), (have_rock_analysis ?x ?z), (can_traverse ?x ?y ?z), (at_rock_sample ?y), (communicated_rock_data ?y), (have_rock_analysis ?x ?y), 
;; calibrate action has changed: (at ?r ?w), (communicated_soil_data ?w), (visible_from ?t ?w), (have_soil_analysis ?r ?w), (have_rock_analysis ?r ?w), (on_board ?i ?r), (calibrated ?i ?r), (communicated_rock_data ?w), (available ?r), (calibrated ?i ?r), (at_rock_sample ?w), (equipped_for_imaging ?r), (communicated_rock_data ?w), (at ?r ?w), (equipped_for_imaging ?r), (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (calibration_target ?i ?t), (calibration_target ?i ?t), (visible_from ?t ?w), (on_board ?i ?r), 
;; sample_soil action has changed: (communicated_soil_data ?p), (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (empty ?s), (at_soil_sample ?p), (available ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (at_rock_sample ?p), (available ?x), (store_of ?s ?x), (at_soil_sample ?p), (equipped_for_imaging ?x), (full ?s), (at ?x ?p), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_soil_analysis ?x), (store_of ?y ?x), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (empty ?y), (equipped_for_imaging ?x), (available ?x), (full ?y), (available ?x), (store_of ?y ?x), (full ?y), 
;; Last_reduced_capability_num_dropped_pals: None
