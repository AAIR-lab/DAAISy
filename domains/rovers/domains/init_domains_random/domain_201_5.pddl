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
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(visible ?y ?z)
			(not (have_rock_analysis ?x ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (available ?x))
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?y)
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?z)
			(communicated_soil_data ?z)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(at ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			
          )
        :effect (and 
               (empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(at_soil_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (empty ?s)
			(not (equipped_for_imaging ?x))
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (store_of ?y ?x)
			(empty ?y)
			(not (full ?y))
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (calibration_target ?i ?t)
			(available ?r)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(at_rock_sample ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(communicated_rock_data ?w)
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (not (calibration_target ?i ?t))
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(available ?r)
			(not (on_board ?i ?r))
			(at_rock_sample ?w)
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?w))
			(at_soil_sample ?w)
			
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
			(not (equipped_for_rock_analysis ?r))
			(calibration_target ?i ?o)
			(equipped_for_soil_analysis ?r)
			(equipped_for_imaging ?r)
			(not (on_board ?i ?r))
			(have_rock_analysis ?r ?p)
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(have_image ?r ?o ?m)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(calibrated ?i ?r)
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
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?y)
			(not (visible ?x ?y))
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (communicated_soil_data ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (at ?r ?x))
			(communicated_rock_data ?p)
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(not (at_soil_sample ?y))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (visible ?x ?p))
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
			(not (visible ?y ?x))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (at ?r ?p))
			(not (have_soil_analysis ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at ?r ?x)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(not (can_traverse ?r ?x ?y))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(communicated_soil_data ?y)
			(not (communicated_soil_data ?p))
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
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
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(available ?r)
			(visible_from ?o ?x)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(have_rock_analysis ?r ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(have_soil_analysis ?r ?y)
			(at_rock_sample ?y)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(not (communicated_image_data ?o ?m))
			
          )
    )

)

;; 
;; communicate_image_data action has changed: (equipped_for_imaging ?r), (visible ?y ?x), (at_rock_sample ?x), (visible ?x ?y), (have_rock_analysis ?r ?x), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?x), (visible_from ?o ?x), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?y), (visible_from ?o ?y), (communicated_rock_data ?x), (at_rock_sample ?y), (have_image ?r ?o ?m), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?x), (visible_from ?o ?y), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (at ?r ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?x), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?y), 
;; drop action has changed: (full ?y), (empty ?y), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (full ?y), 
;; take_image action has changed: (have_rock_analysis ?r ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (visible_from ?o ?p), (calibrated ?i ?r), (supports ?i ?m), (equipped_for_rock_analysis ?r), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (at ?r ?p), (equipped_for_imaging ?r), (at ?r ?p), (calibration_target ?i ?o), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?p), (on_board ?i ?r), (communicated_image_data ?o ?m), (on_board ?i ?r), (calibrated ?i ?r), 
;; calibrate action has changed: (have_soil_analysis ?r ?w), (communicated_rock_data ?w), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (at_soil_sample ?w), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (calibrated ?i ?r), (on_board ?i ?r), (calibration_target ?i ?t), (at_soil_sample ?w), (on_board ?i ?r), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (equipped_for_imaging ?r), (at_rock_sample ?w), (available ?r), (available ?r), 
;; communicate_rock_data action has changed: (can_traverse ?r ?x ?y), (visible ?y ?p), (visible ?y ?x), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (have_rock_analysis ?r ?p), (at ?r ?p), (visible ?y ?p), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?y), (communicated_rock_data ?x), (at_rock_sample ?y), (communicated_soil_data ?x), (have_rock_analysis ?r ?y), (at_lander ?l ?y), (at_soil_sample ?x), (visible ?p ?y), (communicated_soil_data ?y), (can_traverse ?r ?p ?y), (equipped_for_imaging ?r), (at_lander ?l ?y), (at_rock_sample ?x), (at_rock_sample ?x), (channel_free ?l), (communicated_soil_data ?p), (communicated_rock_data ?y), (visible ?p ?x), (communicated_soil_data ?y), (visible ?p ?y), (channel_free ?l), (at_rock_sample ?p), (have_soil_analysis ?r ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?p), (visible ?x ?p), (have_soil_analysis ?r ?p), (equipped_for_rock_analysis ?r), (visible ?p ?x), 
;; sample_soil action has changed: (have_soil_analysis ?x ?p), (empty ?s), (communicated_soil_data ?p), (equipped_for_imaging ?x), (full ?s), (communicated_rock_data ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (communicated_rock_data ?p), (equipped_for_imaging ?x), (have_rock_analysis ?x ?p), (available ?x), (at_rock_sample ?p), (at_soil_sample ?p), (at ?x ?p), (empty ?s), 
;; communicate_soil_data action has changed: (communicated_soil_data ?p), (at_rock_sample ?x), (can_traverse ?r ?x ?p), (communicated_rock_data ?p), (at_soil_sample ?y), (at ?r ?x), (at_lander ?l ?x), (communicated_rock_data ?p), (have_soil_analysis ?r ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (at_soil_sample ?p), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?p), (communicated_soil_data ?x), (visible ?x ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?x), (visible ?x ?y), (communicated_soil_data ?y), (at_soil_sample ?p), (can_traverse ?r ?y ?x), (at_soil_sample ?y), (communicated_soil_data ?y), (at ?r ?x), (equipped_for_rock_analysis ?r), (visible ?x ?y), (can_traverse ?r ?p ?y), (visible ?y ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (can_traverse ?r ?p ?x), (at_rock_sample ?y), (visible ?p ?y), (visible ?y ?p), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?x), (at_lander ?l ?x), (channel_free ?l), (visible ?y ?x), (at_lander ?l ?y), (at_lander ?l ?p), 
;; navigate action has changed: (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (have_soil_analysis ?x ?y), (communicated_soil_data ?y), (at_rock_sample ?z), (communicated_rock_data ?z), (have_soil_analysis ?x ?y), (at_rock_sample ?y), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (at_soil_sample ?z), (at_soil_sample ?z), (available ?x), (at_rock_sample ?y), (at_rock_sample ?z), (at ?x ?y), (have_rock_analysis ?x ?y), (can_traverse ?x ?y ?z), (have_rock_analysis ?x ?z), 
;; sample_rock action has changed: (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_rock_analysis ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (store_of ?s ?x), (store_of ?s ?x), (at_rock_sample ?p), 
;; Last_reduced_capability_num_dropped_pals: None

