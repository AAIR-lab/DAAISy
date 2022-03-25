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
			(not (have_rock_analysis ?x ?z))
			(available ?x)
			(at_rock_sample ?y)
			(can_traverse ?x ?z ?y)
			(at ?x ?y)
			(at_soil_sample ?z)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (have_soil_analysis ?x ?z))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(not (communicated_rock_data ?z))
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (store_of ?s ?x))
			(at_soil_sample ?p)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(equipped_for_imaging ?x)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
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
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(empty ?y)
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			(have_rock_analysis ?r ?w)
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (have_soil_analysis ?r ?w))
			(not (equipped_for_imaging ?r))
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(communicated_soil_data ?w)
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
			(not (communicated_image_data ?o ?m))
			(have_soil_analysis ?r ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (available ?r))
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_rock_sample ?p)
			(not (communicated_soil_data ?p))
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
			(at ?r ?p)
			
          )
          :effect (and 
               (not (have_soil_analysis ?r ?p))
			(not (have_image ?r ?o ?m))
			(calibration_target ?i ?o)
			(not (equipped_for_imaging ?r))
			(not (on_board ?i ?r))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
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
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(can_traverse ?r ?x ?y)
			(not (at_rock_sample ?p))
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?y))
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (at ?r ?y))
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (at_rock_sample ?y))
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(visible ?x ?p)
			(not (visible ?y ?p))
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
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (at ?r ?p))
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(not (have_rock_analysis ?r ?x))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(available ?r)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (at_lander ?l ?y))
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(visible ?x ?p)
			(not (visible ?y ?p))
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
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(at ?r ?x)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (available ?r))
			(at_rock_sample ?y)
			(not (visible_from ?o ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (can_traverse ?r ?p ?y), (available ?r), (visible ?x ?y), (available ?r), (at ?r ?y), (have_rock_analysis ?r ?x), (have_soil_analysis ?r ?x), (channel_free ?l), (have_rock_analysis ?r ?p), (at_rock_sample ?p), (at_lander ?l ?y), (at_lander ?l ?x), (communicated_soil_data ?y), (at_soil_sample ?y), (visible ?y ?p), (can_traverse ?r ?y ?x), (visible ?p ?x), (communicated_rock_data ?y), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (visible ?y ?x), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?p), (visible ?y ?p), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (at_rock_sample ?y), (at_soil_sample ?x), (communicated_rock_data ?x), (at_soil_sample ?y), (can_traverse ?r ?x ?p), (have_soil_analysis ?r ?p), (can_traverse ?r ?x ?y), (at ?r ?x), (visible ?x ?p), (equipped_for_rock_analysis ?r), (can_traverse ?r ?y ?p), (at_lander ?l ?p), (communicated_rock_data ?p), (visible ?x ?p), (visible ?p ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?p), (visible ?y ?x), (at ?r ?x), 
;; take_image action has changed: (calibration_target ?i ?o), (have_image ?r ?o ?m), (communicated_soil_data ?p), (equipped_for_soil_analysis ?r), (available ?r), (visible_from ?o ?p), (at_soil_sample ?p), (at_rock_sample ?p), (on_board ?i ?r), (communicated_image_data ?o ?m), (communicated_rock_data ?p), (at ?r ?p), (have_soil_analysis ?r ?p), (supports ?i ?m), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (at_rock_sample ?p), (have_soil_analysis ?r ?p), 
;; sample_rock action has changed: (communicated_soil_data ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (equipped_for_soil_analysis ?x), (full ?s), (have_rock_analysis ?x ?p), (at ?x ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), 
;; navigate action has changed: (have_rock_analysis ?x ?z), (communicated_soil_data ?z), (equipped_for_soil_analysis ?x), (can_traverse ?x ?z ?y), (communicated_rock_data ?z), (at_rock_sample ?y), (at_rock_sample ?z), (communicated_rock_data ?z), (visible ?y ?z), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?z), (communicated_rock_data ?y), (at_soil_sample ?y), (at_soil_sample ?z), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?z), (at ?x ?y), (can_traverse ?x ?z ?y), (at_rock_sample ?y), 
;; communicate_image_data action has changed: (visible ?x ?y), (equipped_for_imaging ?r), (equipped_for_rock_analysis ?r), (at_rock_sample ?y), (can_traverse ?r ?x ?y), (visible_from ?o ?x), (at_lander ?l ?y), (have_soil_analysis ?r ?x), (communicated_rock_data ?x), (at_soil_sample ?x), (communicated_image_data ?o ?m), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (at_rock_sample ?x), (visible ?y ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?y), (available ?r), (equipped_for_soil_analysis ?r), (at_lander ?l ?x), (visible_from ?o ?x), (communicated_soil_data ?y), (channel_free ?l), (visible ?y ?x), (have_image ?r ?o ?m), (at_soil_sample ?x), (visible_from ?o ?y), (at ?r ?y), (at_soil_sample ?y), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (have_rock_analysis ?r ?y), (at ?r ?y), (have_image ?r ?o ?m), (have_rock_analysis ?r ?x), (at_rock_sample ?y), 
;; sample_soil action has changed: (available ?x), (at ?x ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (empty ?s), (full ?s), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (empty ?s), (store_of ?s ?x), 
;; communicate_rock_data action has changed: (have_rock_analysis ?r ?y), (available ?r), (at_lander ?l ?y), (visible ?y ?p), (at_soil_sample ?y), (at_soil_sample ?x), (visible ?x ?y), (at_rock_sample ?p), (visible ?p ?y), (at_lander ?l ?x), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (communicated_rock_data ?p), (at_lander ?l ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (at ?r ?y), (equipped_for_rock_analysis ?r), (communicated_rock_data ?x), (channel_free ?l), (can_traverse ?r ?y ?p), (have_soil_analysis ?r ?x), (visible ?x ?p), (at ?r ?x), (at ?r ?p), (equipped_for_imaging ?r), (at ?r ?p), (communicated_soil_data ?y), (available ?r), (can_traverse ?r ?p ?y), (visible ?p ?x), (visible ?y ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?p ?y), (communicated_rock_data ?p), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?x), (have_rock_analysis ?r ?x), (at_rock_sample ?y), 
;; calibrate action has changed: (equipped_for_imaging ?r), (have_soil_analysis ?r ?w), (equipped_for_soil_analysis ?r), (at_rock_sample ?w), (communicated_soil_data ?w), (have_soil_analysis ?r ?w), (equipped_for_rock_analysis ?r), (communicated_rock_data ?w), (calibration_target ?i ?t), (at ?r ?w), (have_rock_analysis ?r ?w), (at_soil_sample ?w), (on_board ?i ?r), (equipped_for_imaging ?r), (at_soil_sample ?w), (at ?r ?w), (on_board ?i ?r), (calibration_target ?i ?t), (calibrated ?i ?r), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (full ?y), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (available ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (available ?x), 
;; Last_reduced_capability_num_dropped_pals: None

