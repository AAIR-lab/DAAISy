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
			(not (equipped_for_imaging ?x))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (at_soil_sample ?y))
			(communicated_soil_data ?z)
			(communicated_rock_data ?z)
			(communicated_soil_data ?y)
			(visible ?y ?z)
			(at ?x ?z)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (not (at_rock_sample ?z))
			(have_rock_analysis ?x ?z)
			(not (available ?x))
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?z))
			(at_soil_sample ?y)
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(can_traverse ?x ?y ?z)
			(at ?x ?z)
			(have_soil_analysis ?x ?z)
			(not (have_rock_analysis ?x ?y))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(full ?s)
			(store_of ?s ?x)
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(have_soil_analysis ?x ?p)
			(not (communicated_rock_data ?p))
			
          )
        :effect (and 
               (not (available ?x))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action sample_rock
        :parameters (?x - rover 
                     ?s - store 
                     ?p - waypoint)
        :precondition (and 
               (at ?x ?p)
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(full ?s)
			(store_of ?s ?x)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(equipped_for_rock_analysis ?x)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(not (equipped_for_imaging ?x))
			(full ?s)
			(not (store_of ?s ?x))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (store_of ?y ?x))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(full ?y)
			
          )
        :effect (and 
               (available ?x)
			(store_of ?y ?x)
			(not (empty ?y))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(not (full ?y))
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
			(not (at ?r ?w))
			(not (on_board ?i ?r))
			(not (at_rock_sample ?w))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?w)
			(not (communicated_rock_data ?w))
			(not (at_soil_sample ?w))
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(available ?r)
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(communicated_soil_data ?w)
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
			(have_soil_analysis ?r ?p)
			(available ?r)
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(on_board ?i ?r)
			(not (at_rock_sample ?p))
			(not (visible_from ?o ?p))
			(not (communicated_soil_data ?p))
			(calibrated ?i ?r)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(not (have_image ?r ?o ?m))
			(equipped_for_soil_analysis ?r)
			(not (equipped_for_imaging ?r))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
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
			(visible ?y ?x)
			(not (have_soil_analysis ?r ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(at ?r ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (can_traverse ?r ?y ?p))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(visible ?p ?y)
			(not (can_traverse ?r ?p ?y))
			(at ?r ?p)
			(at ?r ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_soil_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
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
               (channel_free ?l)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?x ?y)
			(can_traverse ?r ?p ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(can_traverse ?r ?y ?p)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(not (visible ?x ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(communicated_rock_data ?x)
			(not (visible ?p ?y))
			(visible ?x ?y)
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(communicated_rock_data ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (have_rock_analysis ?r ?p))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
			(visible ?x ?p)
			(not (can_traverse ?r ?y ?x))
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
			(not (equipped_for_imaging ?r))
			(visible ?y ?x)
			(have_image ?r ?o ?m)
			(not (communicated_rock_data ?x))
			(at ?r ?y)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(communicated_soil_data ?x)
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			(communicated_image_data ?o ?m)
			
          )
         :effect (and 
               (channel_free ?l)
			(not (have_image ?r ?o ?m))
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(available ?r)
			(at_rock_sample ?y)
			(at ?r ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (communicated_rock_data ?p), (at_soil_sample ?p), (at ?r ?x), (communicated_soil_data ?x), (have_rock_analysis ?r ?y), (at_soil_sample ?x), (channel_free ?l), (equipped_for_imaging ?r), (communicated_soil_data ?x), (visible ?x ?p), (at_lander ?l ?p), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?p), (have_soil_analysis ?r ?p), (at_lander ?l ?y), (visible ?y ?x), (at ?r ?p), (can_traverse ?r ?p ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?x ?p), (at_lander ?l ?x), (have_rock_analysis ?r ?y), (can_traverse ?r ?p ?x), (at_soil_sample ?y), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?x), (communicated_rock_data ?y), (available ?r), (have_soil_analysis ?r ?p), (visible ?p ?y), (visible ?p ?y), (communicated_soil_data ?y), (equipped_for_soil_analysis ?r), (at ?r ?y), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (at ?r ?p), (visible ?p ?x), (can_traverse ?r ?y ?p), (at_soil_sample ?x), (at_rock_sample ?y), (communicated_rock_data ?x), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (visible ?y ?x), (at ?r ?y), (can_traverse ?r ?y ?p), 
;; calibrate action has changed: (calibrated ?i ?r), (communicated_soil_data ?w), (at_rock_sample ?w), (communicated_soil_data ?w), (have_rock_analysis ?r ?w), (have_soil_analysis ?r ?w), (at_rock_sample ?w), (at ?r ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (available ?r), (on_board ?i ?r), (at_soil_sample ?w), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (visible_from ?t ?w), (communicated_rock_data ?w), (equipped_for_imaging ?r), (on_board ?i ?r), (equipped_for_imaging ?r), (calibration_target ?i ?t), 
;; communicate_rock_data action has changed: (visible ?x ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?y), (at_lander ?l ?p), (communicated_soil_data ?p), (at_soil_sample ?y), (at_lander ?l ?y), (at_soil_sample ?p), (channel_free ?l), (can_traverse ?r ?p ?x), (visible ?y ?x), (can_traverse ?r ?x ?p), (communicated_soil_data ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (communicated_rock_data ?p), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (at_lander ?l ?x), (at ?r ?y), (at ?r ?x), (communicated_rock_data ?x), (have_rock_analysis ?r ?y), (visible ?x ?p), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (at_lander ?l ?x), (visible ?y ?x), (can_traverse ?r ?y ?p), (have_rock_analysis ?r ?x), (can_traverse ?r ?p ?y), (equipped_for_imaging ?r), (at_soil_sample ?x), (can_traverse ?r ?p ?y), (have_rock_analysis ?r ?p), (at ?r ?p), (available ?r), (can_traverse ?r ?x ?y), (visible ?p ?y), (at_soil_sample ?p), (visible ?x ?y), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (at_soil_sample ?y), (at_lander ?l ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?y), 
;; drop action has changed: (equipped_for_soil_analysis ?x), (store_of ?y ?x), (equipped_for_soil_analysis ?x), (available ?x), (equipped_for_rock_analysis ?x), (store_of ?y ?x), (empty ?y), (equipped_for_imaging ?x), (equipped_for_rock_analysis ?x), 
;; communicate_image_data action has changed: (equipped_for_rock_analysis ?r), (equipped_for_rock_analysis ?r), (communicated_image_data ?o ?m), (have_rock_analysis ?r ?y), (at ?r ?y), (at_lander ?l ?y), (channel_free ?l), (have_image ?r ?o ?m), (at ?r ?x), (at_soil_sample ?x), (equipped_for_imaging ?r), (available ?r), (at_rock_sample ?y), (at_rock_sample ?y), (equipped_for_soil_analysis ?r), (communicated_soil_data ?x), (communicated_rock_data ?y), (at ?r ?y), (communicated_soil_data ?y), (can_traverse ?r ?y ?x), (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?y), (equipped_for_soil_analysis ?r), (visible ?x ?y), (have_rock_analysis ?r ?y), (channel_free ?l), (communicated_rock_data ?x), (visible_from ?o ?y), (communicated_image_data ?o ?m), (available ?r), (visible_from ?o ?x), (have_rock_analysis ?r ?x), (visible ?y ?x), (at_rock_sample ?x), (at_lander ?l ?x), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (communicated_rock_data ?y), 
;; take_image action has changed: (at ?r ?p), (calibration_target ?i ?o), (have_image ?r ?o ?m), (equipped_for_imaging ?r), (have_soil_analysis ?r ?p), (equipped_for_imaging ?r), (at_rock_sample ?p), (supports ?i ?m), (communicated_soil_data ?p), (available ?r), (at_rock_sample ?p), (visible_from ?o ?p), (communicated_rock_data ?p), (supports ?i ?m), (equipped_for_soil_analysis ?r), (equipped_for_soil_analysis ?r), (at ?r ?p), (have_soil_analysis ?r ?p), (have_image ?r ?o ?m), (visible_from ?o ?p), (available ?r), 
;; navigate action has changed: (can_traverse ?x ?y ?z), (equipped_for_imaging ?x), (communicated_rock_data ?y), (available ?x), (visible ?y ?z), (at_soil_sample ?y), (at ?x ?z), (have_soil_analysis ?x ?z), (at_rock_sample ?z), (communicated_soil_data ?y), (can_traverse ?x ?z ?y), (at_soil_sample ?y), (communicated_soil_data ?y), (at ?x ?y), (at_rock_sample ?z), (have_soil_analysis ?x ?y), (communicated_rock_data ?z), (equipped_for_soil_analysis ?x), (communicated_soil_data ?z), (communicated_rock_data ?z), (at_soil_sample ?z), (can_traverse ?x ?y ?z), (can_traverse ?x ?z ?y), (available ?x), (have_rock_analysis ?x ?y), (have_rock_analysis ?x ?z), 
;; sample_soil action has changed: (have_rock_analysis ?x ?p), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (have_soil_analysis ?x ?p), (at_soil_sample ?p), (empty ?s), (store_of ?s ?x), (empty ?s), (communicated_soil_data ?p), (full ?s), (communicated_soil_data ?p), (equipped_for_imaging ?x), (available ?x), 
;; sample_rock action has changed: (store_of ?s ?x), (equipped_for_soil_analysis ?x), (at_soil_sample ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (communicated_rock_data ?p), (communicated_soil_data ?p), (full ?s), (at ?x ?p), (empty ?s), (equipped_for_soil_analysis ?x), (have_soil_analysis ?x ?p), (communicated_soil_data ?p), (equipped_for_rock_analysis ?x), (available ?x), (have_rock_analysis ?x ?p), 
;; Last_reduced_capability_num_dropped_pals: None

