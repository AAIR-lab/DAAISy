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
			(not (visible ?z ?y))
			(not (can_traverse ?x ?z ?y))
			(not (have_soil_analysis ?x ?y))
			(at_soil_sample ?z)
			(at_soil_sample ?y)
			(communicated_soil_data ?z)
			(not (communicated_soil_data ?y))
			(visible ?y ?z)
			(not (equipped_for_rock_analysis ?x))
			(can_traverse ?x ?y ?z)
			(not (at ?x ?z))
			(have_soil_analysis ?x ?z)
			(have_rock_analysis ?x ?y)
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(not (have_rock_analysis ?x ?z))
			(not (available ?x))
			(not (at_rock_sample ?y))
			(not (can_traverse ?x ?z ?y))
			(not (have_soil_analysis ?x ?y))
			(not (communicated_soil_data ?z))
			(not (communicated_rock_data ?z))
			(communicated_soil_data ?y)
			(equipped_for_rock_analysis ?x)
			(not (can_traverse ?x ?y ?z))
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(full ?s)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(not (communicated_rock_data ?p))
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (available ?x)
			(not (empty ?s))
			(not (store_of ?s ?x))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(at ?x ?p)
			(empty ?s)
			(full ?s)
			(equipped_for_soil_analysis ?x)
			(not (communicated_rock_data ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (empty ?y)
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (available ?x))
			(store_of ?y ?x)
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
			(equipped_for_rock_analysis ?r)
			(not (have_soil_analysis ?r ?w))
			(available ?r)
			(not (equipped_for_imaging ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(visible_from ?t ?w)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(equipped_for_soil_analysis ?r)
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
               (not (supports ?i ?m))
			(equipped_for_rock_analysis ?r)
			(equipped_for_imaging ?r)
			(on_board ?i ?r)
			(at_soil_sample ?p)
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(not (communicated_rock_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (supports ?i ?m)
			(available ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(communicated_rock_data ?p)
			
          )
    )
    
    (:action communicate_soil_data
         :parameters (?r - rover 
                      ?l - lander 
                      ?p - waypoint 
                      ?x - waypoint 
                      ?y - waypoint)
         :precondition (and 
               (not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(can_traverse ?r ?p ?x)
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?y ?x)
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (can_traverse ?r ?y ?x))
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
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(communicated_rock_data ?x)
			(not (visible ?p ?x))
			(visible ?p ?y)
			(not (visible ?x ?y))
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (have_soil_analysis ?r ?p))
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (can_traverse ?r ?x ?p))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(visible ?x ?p)
			(not (visible ?y ?p))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(have_soil_analysis ?r ?y)
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (communicated_soil_data ?x))
			(communicated_soil_data ?y)
			(have_rock_analysis ?r ?x)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
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
               (not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(available ?r)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?x)
			(can_traverse ?r ?y ?x)
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(not (visible ?x ?y))
			(at_rock_sample ?x)
			(not (at ?r ?y))
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(can_traverse ?r ?y ?x)
			(communicated_rock_data ?y)
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; calibrate action has changed: (calibrated ?i ?r), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (available ?r), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (communicated_rock_data ?w), (calibration_target ?i ?t), (have_soil_analysis ?r ?w), (at ?r ?w), (at_rock_sample ?w), (on_board ?i ?r), (at ?r ?w), (available ?r), (on_board ?i ?r), (equipped_for_soil_analysis ?r), (have_rock_analysis ?r ?w), 
;; sample_soil action has changed: (at_rock_sample ?p), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (communicated_rock_data ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (empty ?s), (have_soil_analysis ?x ?p), (have_rock_analysis ?x ?p), (at ?x ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (at ?x ?p), (equipped_for_imaging ?x), (available ?x), (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (store_of ?s ?x), 
;; navigate action has changed: (communicated_rock_data ?z), (have_soil_analysis ?x ?z), (have_rock_analysis ?x ?y), (at ?x ?z), (at_rock_sample ?z), (can_traverse ?x ?z ?y), (available ?x), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?z), (communicated_soil_data ?y), (have_soil_analysis ?x ?y), (at ?x ?y), (communicated_soil_data ?z), (at_soil_sample ?y), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?y), (communicated_rock_data ?y), (can_traverse ?x ?z ?y), (communicated_soil_data ?z), (at_rock_sample ?y), (communicated_soil_data ?y), (equipped_for_rock_analysis ?x), (at ?x ?z), (have_soil_analysis ?x ?y), (available ?x), (can_traverse ?x ?y ?z), (equipped_for_rock_analysis ?x), (at_soil_sample ?z), (at ?x ?y), (visible ?z ?y), (have_rock_analysis ?x ?z), 
;; communicate_rock_data action has changed: (at_lander ?l ?x), (at ?r ?p), (available ?r), (visible ?x ?y), (have_rock_analysis ?r ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?p), (can_traverse ?r ?y ?x), (channel_free ?l), (have_rock_analysis ?r ?y), (at_rock_sample ?x), (have_soil_analysis ?r ?x), (at_rock_sample ?p), (visible ?x ?y), (channel_free ?l), (communicated_soil_data ?x), (have_soil_analysis ?r ?p), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?y), (equipped_for_rock_analysis ?r), (at_rock_sample ?p), (communicated_soil_data ?y), (can_traverse ?r ?x ?p), (visible ?y ?x), (have_rock_analysis ?r ?y), (at ?r ?x), (visible ?p ?y), (communicated_rock_data ?x), (at ?r ?y), (communicated_soil_data ?p), (at ?r ?p), (available ?r), (visible ?p ?y), (at_lander ?l ?p), (visible ?p ?x), (at_lander ?l ?x), (at_lander ?l ?p), (have_soil_analysis ?r ?y), (communicated_soil_data ?x), (visible ?x ?p), (at_soil_sample ?p), (communicated_rock_data ?p), (can_traverse ?r ?x ?y), (visible ?y ?p), (communicated_soil_data ?p), (at_rock_sample ?y), (communicated_rock_data ?y), (equipped_for_imaging ?r), (at_rock_sample ?y), (can_traverse ?r ?y ?p), 
;; communicate_soil_data action has changed: (at ?r ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?p ?x), (visible ?x ?p), (can_traverse ?r ?y ?x), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?x), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (available ?r), (visible ?p ?y), (communicated_rock_data ?p), (have_soil_analysis ?r ?x), (at_lander ?l ?x), (have_soil_analysis ?r ?x), (visible ?x ?p), (have_soil_analysis ?r ?p), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?x), (have_rock_analysis ?r ?p), (communicated_rock_data ?y), (communicated_rock_data ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (communicated_soil_data ?p), (at_soil_sample ?p), (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (have_rock_analysis ?r ?y), (equipped_for_imaging ?r), (visible ?x ?y), (visible ?y ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (have_rock_analysis ?r ?x), (at ?r ?x), (can_traverse ?r ?y ?p), (communicated_soil_data ?p), (can_traverse ?r ?x ?y), (communicated_rock_data ?x), (communicated_soil_data ?x), (at_soil_sample ?x), (can_traverse ?r ?x ?p), (channel_free ?l), (communicated_soil_data ?x), (can_traverse ?r ?x ?y), (at_rock_sample ?x), (at_soil_sample ?x), (visible ?y ?x), (channel_free ?l), (at_soil_sample ?y), (communicated_soil_data ?y), (visible ?p ?x), (at_lander ?l ?x), 
;; take_image action has changed: (communicated_rock_data ?p), (at_rock_sample ?p), (equipped_for_imaging ?r), (visible_from ?o ?p), (supports ?i ?m), (communicated_rock_data ?p), (supports ?i ?m), (calibration_target ?i ?o), (at_soil_sample ?p), (available ?r), (have_rock_analysis ?r ?p), (on_board ?i ?r), (at_soil_sample ?p), (visible_from ?o ?p), (equipped_for_soil_analysis ?r), (at ?r ?p), (equipped_for_rock_analysis ?r), (calibrated ?i ?r), (communicated_soil_data ?p), 
;; communicate_image_data action has changed: (have_rock_analysis ?r ?x), (have_rock_analysis ?r ?x), (equipped_for_imaging ?r), (at ?r ?x), (have_rock_analysis ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (communicated_rock_data ?x), (visible ?x ?y), (can_traverse ?r ?y ?x), (at_soil_sample ?x), (visible ?x ?y), (communicated_image_data ?o ?m), (at ?r ?y), (at_rock_sample ?x), (at_rock_sample ?y), (at ?r ?x), (communicated_soil_data ?x), (channel_free ?l), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (at_soil_sample ?y), (communicated_soil_data ?x), (at_rock_sample ?x), (visible ?y ?x), (at ?r ?y), (have_soil_analysis ?r ?x), (channel_free ?l), (have_image ?r ?o ?m), (visible_from ?o ?y), (have_soil_analysis ?r ?y), (communicated_rock_data ?y), (communicated_rock_data ?x), (at_soil_sample ?y), (equipped_for_imaging ?r), 
;; drop action has changed: (equipped_for_imaging ?x), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (store_of ?y ?x), (full ?y), (empty ?y), (equipped_for_rock_analysis ?x), (available ?x), 
;; sample_rock action has changed: (communicated_rock_data ?p), (equipped_for_rock_analysis ?x), (empty ?s), (equipped_for_soil_analysis ?x), (available ?x), (have_soil_analysis ?x ?p), (equipped_for_soil_analysis ?x), (have_rock_analysis ?x ?p), (have_rock_analysis ?x ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (store_of ?s ?x), (at_rock_sample ?p), (empty ?s), (available ?x), (at ?x ?p), (at ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None
