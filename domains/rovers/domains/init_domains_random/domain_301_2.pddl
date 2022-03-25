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
			(available ?x)
			(visible ?z ?y)
			(not (equipped_for_imaging ?x))
			(not (at_rock_sample ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(communicated_soil_data ?z)
			(not (equipped_for_rock_analysis ?x))
			(not (at ?x ?z))
			(not (have_soil_analysis ?x ?z))
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(have_rock_analysis ?x ?z)
			(available ?x)
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(have_soil_analysis ?x ?y)
			(not (at_soil_sample ?z))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?z))
			(not (visible ?y ?z))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(not (have_soil_analysis ?x ?z))
			(not (have_rock_analysis ?x ?y))
			(not (equipped_for_soil_analysis ?x))
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (available ?x)
			(at ?x ?p)
			(not (empty ?s))
			(not (full ?s))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(not (have_soil_analysis ?x ?p))
			(not (equipped_for_rock_analysis ?x))
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(at ?x ?p)
			(empty ?s)
			(not (equipped_for_imaging ?x))
			(store_of ?s ?x)
			(at_soil_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
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
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (store_of ?s ?x))
			(at_soil_sample ?p)
			(not (at_rock_sample ?p))
			(equipped_for_soil_analysis ?x)
			(not (have_soil_analysis ?x ?p))
			(communicated_rock_data ?p)
			(equipped_for_rock_analysis ?x)
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (at ?x ?p)
			(empty ?s)
			(full ?s)
			(not (equipped_for_soil_analysis ?x))
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (have_rock_analysis ?x ?p))
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (available ?x)
			(store_of ?y ?x)
			(empty ?y)
			(equipped_for_soil_analysis ?x)
			(full ?y)
			(not (equipped_for_imaging ?x))
			
          )
        :effect (and 
               (not (available ?x))
			(equipped_for_rock_analysis ?x)
			(not (equipped_for_soil_analysis ?x))
			(equipped_for_imaging ?x)
			
          )
    )
    
    (:action calibrate
         :parameters (?r - rover 
                      ?i - camera 
                      ?t - objective 
                      ?w - waypoint)
         :precondition (and 
               (equipped_for_rock_analysis ?r)
			(available ?r)
			(not (at_rock_sample ?w))
			(not (equipped_for_soil_analysis ?r))
			(not (visible_from ?t ?w))
			(not (have_rock_analysis ?r ?w))
			(at_soil_sample ?w)
			(calibrated ?i ?r)
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(equipped_for_rock_analysis ?r)
			(have_soil_analysis ?r ?w)
			(not (equipped_for_imaging ?r))
			(at ?r ?w)
			(on_board ?i ?r)
			(at_rock_sample ?w)
			(visible_from ?t ?w)
			(not (have_rock_analysis ?r ?w))
			(not (at_soil_sample ?w))
			
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
			(have_soil_analysis ?r ?p)
			(equipped_for_rock_analysis ?r)
			(not (equipped_for_soil_analysis ?r))
			(not (equipped_for_imaging ?r))
			(have_rock_analysis ?r ?p)
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(at ?r ?p)
			
          )
          :effect (and 
               (supports ?i ?m)
			(not (have_soil_analysis ?r ?p))
			(not (equipped_for_rock_analysis ?r))
			(not (have_image ?r ?o ?m))
			(not (calibration_target ?i ?o))
			(not (have_rock_analysis ?r ?p))
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(visible_from ?o ?p)
			(communicated_soil_data ?p)
			(not (communicated_rock_data ?p))
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
               (not (channel_free ?l))
			(not (equipped_for_imaging ?r))
			(not (have_soil_analysis ?r ?x))
			(not (communicated_rock_data ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(not (can_traverse ?r ?p ?y))
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(can_traverse ?r ?y ?p)
			(at_lander ?l ?x)
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(communicated_soil_data ?x)
			(have_rock_analysis ?r ?p)
			(not (can_traverse ?r ?x ?p))
			(at_lander ?l ?p)
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?y ?p)
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			
          )
          :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (visible ?p ?x))
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (have_soil_analysis ?r ?p))
			(available ?r)
			(at_rock_sample ?y)
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(visible ?x ?p)
			(not (visible ?y ?p))
			(can_traverse ?r ?y ?x)
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
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(at ?r ?y)
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(not (available ?r))
			(not (at_rock_sample ?y))
			(at_soil_sample ?p)
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(not (have_rock_analysis ?r ?x))
			(not (at_lander ?l ?p))
			(not (visible ?x ?p))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(not (visible ?p ?x))
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(available ?r)
			(not (at_rock_sample ?y))
			(at_rock_sample ?p)
			(at ?r ?x)
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(equipped_for_soil_analysis ?r)
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?p))
			(communicated_soil_data ?y)
			(can_traverse ?r ?x ?p)
			(have_rock_analysis ?r ?x)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?y ?p))
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
               (equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(have_soil_analysis ?r ?x)
			(communicated_rock_data ?x)
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(have_rock_analysis ?r ?y)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(not (at_soil_sample ?x))
			(not (visible_from ?o ?y))
			(equipped_for_rock_analysis ?r)
			(can_traverse ?r ?y ?x)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (channel_free ?l)
			(equipped_for_imaging ?r)
			(not (visible ?y ?x))
			(have_image ?r ?o ?m)
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (at_rock_sample ?y))
			(not (visible_from ?o ?x))
			(at ?r ?x)
			(at_lander ?l ?y)
			(not (have_rock_analysis ?r ?y))
			(not (at_soil_sample ?y))
			(not (at_soil_sample ?x))
			(not (communicated_soil_data ?y))
			(not (have_rock_analysis ?r ?x))
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(not (can_traverse ?r ?y ?x))
			(communicated_image_data ?o ?m)
			
          )
    )

)

;; 
;; communicate_soil_data action has changed: (communicated_soil_data ?x), (available ?r), (have_soil_analysis ?r ?y), (at_lander ?l ?x), (at_lander ?l ?p), (can_traverse ?r ?x ?p), (can_traverse ?r ?y ?p), (visible ?y ?p), (communicated_soil_data ?p), (visible ?y ?p), (at ?r ?x), (equipped_for_soil_analysis ?r), (at_soil_sample ?p), (have_rock_analysis ?r ?y), (channel_free ?l), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?y), (available ?r), (visible ?y ?x), (at_lander ?l ?y), (can_traverse ?r ?x ?p), (at_lander ?l ?y), (have_rock_analysis ?r ?p), (visible ?p ?y), (have_soil_analysis ?r ?p), (have_rock_analysis ?r ?x), (can_traverse ?r ?x ?y), (at_lander ?l ?x), (communicated_rock_data ?y), (at_lander ?l ?p), (have_rock_analysis ?r ?p), (visible ?x ?p), (can_traverse ?r ?p ?x), (communicated_rock_data ?x), (can_traverse ?r ?x ?y), (at ?r ?y), (have_soil_analysis ?r ?x), (at_soil_sample ?p), (visible ?x ?y), (at_rock_sample ?p), (visible ?p ?x), (at_rock_sample ?y), (at_rock_sample ?x), (visible ?x ?y), (can_traverse ?r ?p ?y), (can_traverse ?r ?y ?p), (communicated_rock_data ?y), (visible ?p ?x), (can_traverse ?r ?y ?x), (at_rock_sample ?p), (communicated_rock_data ?p), (visible ?p ?y), (can_traverse ?r ?p ?y), (at_rock_sample ?y), (at ?r ?y), (at_soil_sample ?x), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (at ?r ?x), (channel_free ?l), (equipped_for_imaging ?r), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (have_rock_analysis ?r ?y), 
;; communicate_image_data action has changed: (can_traverse ?r ?y ?x), (have_soil_analysis ?r ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?x), (at_lander ?l ?y), (have_rock_analysis ?r ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?x ?y), (communicated_soil_data ?y), (equipped_for_imaging ?r), (communicated_rock_data ?x), (have_soil_analysis ?r ?x), (visible ?x ?y), (channel_free ?l), (have_soil_analysis ?r ?y), (visible ?y ?x), (at ?r ?x), (at_rock_sample ?y), (at_soil_sample ?x), (communicated_rock_data ?y), (at ?r ?x), (equipped_for_imaging ?r), (visible_from ?o ?x), (at_lander ?l ?y), (have_image ?r ?o ?m), (communicated_soil_data ?x), (at_soil_sample ?y), (at_rock_sample ?y), (visible ?y ?x), (at ?r ?y), (have_image ?r ?o ?m), (at_lander ?l ?x), (channel_free ?l), (have_rock_analysis ?r ?x), (at_soil_sample ?x), (can_traverse ?r ?y ?x), (equipped_for_rock_analysis ?r), (visible ?x ?y), (available ?r), (visible_from ?o ?x), (visible_from ?o ?y), (at ?r ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?y), (visible_from ?o ?y), (equipped_for_rock_analysis ?r), 
;; sample_rock action has changed: (have_soil_analysis ?x ?p), (at_rock_sample ?p), (at ?x ?p), (have_soil_analysis ?x ?p), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (available ?x), (at ?x ?p), (empty ?s), (have_rock_analysis ?x ?p), (empty ?s), (have_rock_analysis ?x ?p), (full ?s), (store_of ?s ?x), (at_soil_sample ?p), (communicated_rock_data ?p), (at_rock_sample ?p), (communicated_soil_data ?p), (equipped_for_soil_analysis ?x), 
;; drop action has changed: (empty ?y), (equipped_for_imaging ?x), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (available ?x), (full ?y), (available ?x), 
;; navigate action has changed: (can_traverse ?x ?y ?z), (have_soil_analysis ?x ?y), (can_traverse ?x ?y ?z), (at_rock_sample ?z), (communicated_rock_data ?y), (at_rock_sample ?y), (have_rock_analysis ?x ?z), (have_rock_analysis ?x ?z), (available ?x), (at ?x ?y), (at_soil_sample ?z), (at_soil_sample ?y), (visible ?y ?z), (communicated_soil_data ?z), (at_soil_sample ?z), (equipped_for_imaging ?x), (visible ?z ?y), (have_soil_analysis ?x ?z), (at ?x ?z), (equipped_for_soil_analysis ?x), (visible ?y ?z), (communicated_soil_data ?z), (have_rock_analysis ?x ?y), (equipped_for_soil_analysis ?x), (can_traverse ?x ?z ?y), (have_soil_analysis ?x ?y), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?y), (at_rock_sample ?y), (at ?x ?y), (have_soil_analysis ?x ?z), 
;; communicate_rock_data action has changed: (visible ?x ?p), (equipped_for_imaging ?r), (at ?r ?p), (at_rock_sample ?y), (at ?r ?y), (at ?r ?x), (communicated_rock_data ?p), (at_lander ?l ?x), (have_soil_analysis ?r ?y), (channel_free ?l), (equipped_for_imaging ?r), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (communicated_soil_data ?x), (can_traverse ?r ?x ?y), (available ?r), (at_rock_sample ?y), (at_soil_sample ?y), (have_rock_analysis ?r ?x), (at_lander ?l ?x), (communicated_rock_data ?x), (communicated_rock_data ?y), (visible ?y ?p), (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (have_soil_analysis ?r ?p), (communicated_soil_data ?x), (at_soil_sample ?y), (visible ?x ?y), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (have_rock_analysis ?r ?x), (communicated_soil_data ?y), (visible ?y ?x), (equipped_for_soil_analysis ?r), (communicated_rock_data ?y), (at_soil_sample ?p), (visible ?x ?y), (at_lander ?l ?p), (at_rock_sample ?p), (available ?r), (equipped_for_soil_analysis ?r), (can_traverse ?r ?x ?p), (at_rock_sample ?p), (at ?r ?x), (at_rock_sample ?x), (can_traverse ?r ?y ?x), (visible ?p ?y), (at_lander ?l ?y), (visible ?p ?y), (communicated_soil_data ?y), (visible ?p ?x), (at_lander ?l ?y), (can_traverse ?r ?x ?y), (can_traverse ?r ?y ?p), (at ?r ?y), (visible ?y ?x), (have_rock_analysis ?r ?p), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?y), (at ?r ?p), (visible ?p ?x), (have_rock_analysis ?r ?p), (at_rock_sample ?x), 
;; sample_soil action has changed: (available ?x), (store_of ?s ?x), (at_soil_sample ?p), (equipped_for_rock_analysis ?x), (full ?s), (empty ?s), (have_rock_analysis ?x ?p), (have_soil_analysis ?x ?p), (store_of ?s ?x), (empty ?s), (equipped_for_soil_analysis ?x), (available ?x), (communicated_soil_data ?p), (at ?x ?p), (have_rock_analysis ?x ?p), (equipped_for_soil_analysis ?x), (communicated_rock_data ?p), (have_soil_analysis ?x ?p), (at_rock_sample ?p), (equipped_for_imaging ?x), (full ?s), 
;; calibrate action has changed: (at_rock_sample ?w), (equipped_for_imaging ?r), (equipped_for_imaging ?r), (calibration_target ?i ?t), (have_soil_analysis ?r ?w), (visible_from ?t ?w), (at_soil_sample ?w), (at_soil_sample ?w), (equipped_for_rock_analysis ?r), (equipped_for_soil_analysis ?r), (calibrated ?i ?r), (calibrated ?i ?r), (available ?r), (on_board ?i ?r), (have_rock_analysis ?r ?w), (at_rock_sample ?w), (calibration_target ?i ?t), (visible_from ?t ?w), (at ?r ?w), (have_rock_analysis ?r ?w), (at ?r ?w), (on_board ?i ?r), (equipped_for_rock_analysis ?r), 
;; take_image action has changed: (calibrated ?i ?r), (supports ?i ?m), (communicated_soil_data ?p), (at ?r ?p), (at_rock_sample ?p), (have_rock_analysis ?r ?p), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?p), (visible_from ?o ?p), (communicated_rock_data ?p), (supports ?i ?m), (equipped_for_imaging ?r), (on_board ?i ?r), (have_soil_analysis ?r ?p), (communicated_image_data ?o ?m), (calibration_target ?i ?o), (calibrated ?i ?r), (at_soil_sample ?p), (communicated_soil_data ?p), (have_rock_analysis ?r ?p), (equipped_for_soil_analysis ?r), (equipped_for_rock_analysis ?r), (have_image ?r ?o ?m), 
;; Last_reduced_capability_num_dropped_pals: None

