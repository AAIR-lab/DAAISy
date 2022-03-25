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
			(not (have_rock_analysis ?x ?z))
			(not (visible ?z ?y))
			(at_rock_sample ?y)
			(not (can_traverse ?x ?z ?y))
			(not (at ?x ?y))
			(have_soil_analysis ?x ?y)
			(at_soil_sample ?y)
			(communicated_rock_data ?z)
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(not (can_traverse ?x ?y ?z))
			(at ?x ?z)
			(have_rock_analysis ?x ?y)
			(communicated_rock_data ?y)
			(not (equipped_for_soil_analysis ?x))
			
          )
          :effect (and 
               (at_rock_sample ?z)
			(not (available ?x))
			(visible ?z ?y)
			(not (at ?x ?y))
			(not (have_soil_analysis ?x ?y))
			(not (at_soil_sample ?y))
			(not (communicated_rock_data ?z))
			(not (communicated_soil_data ?y))
			(not (visible ?y ?z))
			(not (equipped_for_rock_analysis ?x))
			(at ?x ?z)
			(have_rock_analysis ?x ?y)
			(not (communicated_rock_data ?y))
			(equipped_for_soil_analysis ?x)
			
          )
    )
    
    (:action sample_soil
        :parameters (?x - rover ?s - store ?p - waypoint)
        :precondition (and 
               (not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(at_rock_sample ?p)
			(not (equipped_for_soil_analysis ?x))
			(communicated_soil_data ?p)
			(communicated_rock_data ?p)
			(have_rock_analysis ?x ?p)
			
          )
        :effect (and 
               (not (available ?x))
			(not (at ?x ?p))
			(not (empty ?s))
			(equipped_for_imaging ?x)
			(store_of ?s ?x)
			(not (at_soil_sample ?p))
			(not (at_rock_sample ?p))
			(communicated_soil_data ?p)
			(not (have_soil_analysis ?x ?p))
			
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
			(not (communicated_soil_data ?p))
			(have_soil_analysis ?x ?p)
			(not (equipped_for_rock_analysis ?x))
			(not (have_rock_analysis ?x ?p))
			
          )
        :effect (and 
               (available ?x)
			(empty ?s)
			(equipped_for_imaging ?x)
			(not (full ?s))
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (have_soil_analysis ?x ?p))
			(equipped_for_rock_analysis ?x)
			
          )
    )
    
    (:action drop
        :parameters (?x - rover 
                     ?y - store)
        :precondition (and 
               (not (available ?x))
			(not (store_of ?y ?x))
			(not (empty ?y))
			(equipped_for_soil_analysis ?x)
			(not (full ?y))
			(equipped_for_imaging ?x)
			
          )
        :effect (and 
               (not (empty ?y))
			(not (equipped_for_rock_analysis ?x))
			(equipped_for_soil_analysis ?x)
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
               (have_soil_analysis ?r ?w)
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(on_board ?i ?r)
			(not (at_rock_sample ?w))
			(have_rock_analysis ?r ?w)
			(communicated_soil_data ?w)
			(not (at_soil_sample ?w))
			
          )
         :effect (and 
               (calibration_target ?i ?t)
			(not (equipped_for_rock_analysis ?r))
			(have_soil_analysis ?r ?w)
			(not (available ?r))
			(equipped_for_imaging ?r)
			(at ?r ?w)
			(not (equipped_for_soil_analysis ?r))
			(not (have_rock_analysis ?r ?w))
			(communicated_rock_data ?w)
			(at_soil_sample ?w)
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
               (have_soil_analysis ?r ?p)
			(available ?r)
			(have_image ?r ?o ?m)
			(not (calibration_target ?i ?o))
			(not (equipped_for_soil_analysis ?r))
			(not (on_board ?i ?r))
			(not (have_rock_analysis ?r ?p))
			(not (communicated_rock_data ?p))
			(not (calibrated ?i ?r))
			(not (at ?r ?p))
			
          )
          :effect (and 
               (communicated_image_data ?o ?m)
			(available ?r)
			(not (have_image ?r ?o ?m))
			(not (equipped_for_soil_analysis ?r))
			(on_board ?i ?r)
			(have_rock_analysis ?r ?p)
			(at_soil_sample ?p)
			(not (visible_from ?o ?p))
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
			(equipped_for_imaging ?r)
			(have_soil_analysis ?r ?x)
			(visible ?p ?x)
			(not (visible ?p ?y))
			(not (visible ?x ?y))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (at ?r ?y))
			(can_traverse ?r ?x ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_rock_sample ?p))
			(at ?r ?x)
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(not (communicated_soil_data ?x))
			(at_soil_sample ?x)
			(not (communicated_soil_data ?y))
			(not (can_traverse ?r ?x ?p))
			(communicated_soil_data ?p)
			(not (equipped_for_rock_analysis ?r))
			(not (visible ?x ?p))
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(communicated_rock_data ?y)
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (not (channel_free ?l))
			(visible ?p ?x)
			(visible ?p ?y)
			(visible ?x ?y)
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(not (at ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at_soil_sample ?p))
			(at_rock_sample ?p)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (have_rock_analysis ?r ?y))
			(equipped_for_soil_analysis ?r)
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?p)
			(communicated_soil_data ?y)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
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
			(not (equipped_for_imaging ?r))
			(have_soil_analysis ?r ?x)
			(not (communicated_rock_data ?x))
			(visible ?p ?y)
			(not (at_rock_sample ?x))
			(can_traverse ?r ?p ?y)
			(at ?r ?p)
			(not (have_soil_analysis ?r ?y))
			(not (can_traverse ?r ?x ?y))
			(not (have_soil_analysis ?r ?p))
			(at ?r ?x)
			(communicated_rock_data ?p)
			(not (can_traverse ?r ?y ?p))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(at_soil_sample ?x)
			(have_rock_analysis ?r ?p)
			(not (communicated_soil_data ?y))
			(can_traverse ?r ?x ?p)
			(not (at_lander ?l ?p))
			(communicated_soil_data ?p)
			(equipped_for_rock_analysis ?r)
			(not (visible ?y ?p))
			(not (can_traverse ?r ?y ?x))
			(not (communicated_rock_data ?y))
			(not (can_traverse ?r ?p ?x))
			
          )
          :effect (and 
               (channel_free ?l)
			(not (visible ?y ?x))
			(have_soil_analysis ?r ?x)
			(not (visible ?p ?x))
			(not (visible ?x ?y))
			(not (at_rock_sample ?x))
			(not (at ?r ?p))
			(have_soil_analysis ?r ?y)
			(have_soil_analysis ?r ?p)
			(at_rock_sample ?y)
			(not (at ?r ?x))
			(not (communicated_rock_data ?p))
			(not (can_traverse ?r ?y ?p))
			(not (at_lander ?l ?y))
			(at_lander ?l ?x)
			(not (at_soil_sample ?x))
			(not (have_rock_analysis ?r ?x))
			(at_lander ?l ?p)
			(not (communicated_soil_data ?p))
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
               (channel_free ?l)
			(not (equipped_for_imaging ?r))
			(not (visible ?y ?x))
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(not (at_rock_sample ?x))
			(not (have_soil_analysis ?r ?y))
			(at ?r ?y)
			(available ?r)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(not (at_lander ?l ?x))
			(not (equipped_for_soil_analysis ?r))
			(not (at_soil_sample ?y))
			(not (communicated_soil_data ?x))
			(have_rock_analysis ?r ?x)
			(visible_from ?o ?y)
			(equipped_for_rock_analysis ?r)
			(not (communicated_rock_data ?y))
			
          )
         :effect (and 
               (not (channel_free ?l))
			(equipped_for_imaging ?r)
			(visible ?y ?x)
			(not (have_image ?r ?o ?m))
			(not (have_soil_analysis ?r ?x))
			(visible ?x ?y)
			(at_rock_sample ?x)
			(have_soil_analysis ?r ?y)
			(at ?r ?y)
			(can_traverse ?r ?x ?y)
			(not (at_rock_sample ?y))
			(visible_from ?o ?x)
			(not (at ?r ?x))
			(at_lander ?l ?y)
			(at_lander ?l ?x)
			(have_rock_analysis ?r ?y)
			(not (equipped_for_soil_analysis ?r))
			(at_soil_sample ?y)
			(communicated_soil_data ?x)
			(not (at_soil_sample ?x))
			(not (visible_from ?o ?y))
			(not (equipped_for_rock_analysis ?r))
			(not (communicated_rock_data ?y))
			
          )
    )

)

;; 
;; communicate_rock_data action has changed: (communicated_rock_data ?y), (visible ?x ?y), (can_traverse ?r ?p ?x), (at_soil_sample ?x), (have_soil_analysis ?r ?x), (available ?r), (at_lander ?l ?p), (channel_free ?l), (can_traverse ?r ?x ?y), (visible ?y ?p), (at_rock_sample ?y), (have_soil_analysis ?r ?p), (visible ?p ?y), (communicated_rock_data ?x), (communicated_soil_data ?p), (equipped_for_rock_analysis ?r), (at_rock_sample ?x), (at ?r ?p), (can_traverse ?r ?y ?x), (at_lander ?l ?p), (can_traverse ?r ?p ?y), (can_traverse ?r ?p ?x), (channel_free ?l), (have_rock_analysis ?r ?x), (at_rock_sample ?x), (at ?r ?x), (have_soil_analysis ?r ?p), (visible ?x ?y), (communicated_rock_data ?p), (at_lander ?l ?x), (at_soil_sample ?y), (can_traverse ?r ?y ?p), (communicated_rock_data ?p), (at_lander ?l ?y), (communicated_soil_data ?y), (have_soil_analysis ?r ?x), (can_traverse ?r ?y ?x), (equipped_for_imaging ?r), (at ?r ?p), (at_lander ?l ?x), (at_soil_sample ?x), (equipped_for_soil_analysis ?r), (can_traverse ?r ?y ?p), (can_traverse ?r ?x ?p), (communicated_soil_data ?p), (visible ?y ?x), (visible ?p ?x), (have_soil_analysis ?r ?y), (have_soil_analysis ?r ?y), 
;; communicate_image_data action has changed: (equipped_for_rock_analysis ?r), (at_soil_sample ?x), (visible_from ?o ?y), (at_lander ?l ?x), (at_rock_sample ?x), (equipped_for_rock_analysis ?r), (have_soil_analysis ?r ?x), (visible ?y ?x), (channel_free ?l), (at_soil_sample ?y), (at_lander ?l ?y), (have_rock_analysis ?r ?x), (equipped_for_soil_analysis ?r), (have_soil_analysis ?r ?y), (at ?r ?x), (at_lander ?l ?x), (equipped_for_imaging ?r), (at_soil_sample ?y), (communicated_soil_data ?x), (communicated_image_data ?o ?m), (communicated_rock_data ?y), (at ?r ?x), (equipped_for_soil_analysis ?r), (visible_from ?o ?x), (communicated_soil_data ?x), (visible_from ?o ?y), (have_rock_analysis ?r ?y), (visible ?y ?x), (visible ?x ?y), (have_image ?r ?o ?m), (have_soil_analysis ?r ?x), (at ?r ?y), (at ?r ?y), (can_traverse ?r ?x ?y), (communicated_rock_data ?y), (have_image ?r ?o ?m), (at_rock_sample ?x), (have_soil_analysis ?r ?y), (at_rock_sample ?y), (equipped_for_imaging ?r), 
;; sample_soil action has changed: (at ?x ?p), (equipped_for_imaging ?x), (equipped_for_imaging ?x), (at ?x ?p), (have_rock_analysis ?x ?p), (available ?x), (store_of ?s ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (empty ?s), (full ?s), (at_soil_sample ?p), (communicated_soil_data ?p), (at_rock_sample ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?x), (communicated_soil_data ?p), 
;; navigate action has changed: (equipped_for_rock_analysis ?x), (can_traverse ?x ?y ?z), (communicated_rock_data ?z), (at ?x ?z), (have_rock_analysis ?x ?y), (visible ?z ?y), (have_rock_analysis ?x ?z), (have_soil_analysis ?x ?y), (at_rock_sample ?z), (visible ?y ?z), (can_traverse ?x ?z ?y), (available ?x), (visible ?y ?z), (at ?x ?y), (equipped_for_soil_analysis ?x), (equipped_for_soil_analysis ?x), (visible ?z ?y), (communicated_rock_data ?y), (have_soil_analysis ?x ?y), (at_rock_sample ?z), (have_rock_analysis ?x ?y), (equipped_for_rock_analysis ?x), (communicated_rock_data ?z), (available ?x), (communicated_soil_data ?y), (at_rock_sample ?y), (at_soil_sample ?y), (communicated_rock_data ?y), (at_soil_sample ?y), 
;; calibrate action has changed: (have_rock_analysis ?r ?w), (at_soil_sample ?w), (have_rock_analysis ?r ?w), (available ?r), (equipped_for_rock_analysis ?r), (equipped_for_imaging ?r), (at_rock_sample ?w), (visible_from ?t ?w), (equipped_for_soil_analysis ?r), (communicated_rock_data ?w), (calibration_target ?i ?t), (calibration_target ?i ?t), (have_soil_analysis ?r ?w), (communicated_soil_data ?w), (at_soil_sample ?w), (calibrated ?i ?r), (have_soil_analysis ?r ?w), (at ?r ?w), 
;; communicate_soil_data action has changed: (visible ?x ?y), (can_traverse ?r ?x ?y), (equipped_for_rock_analysis ?r), (communicated_soil_data ?p), (communicated_rock_data ?p), (equipped_for_soil_analysis ?r), (at ?r ?y), (at_soil_sample ?x), (available ?r), (have_soil_analysis ?r ?y), (at_rock_sample ?p), (can_traverse ?r ?y ?p), (at_lander ?l ?x), (can_traverse ?r ?y ?x), (visible ?x ?y), (at_lander ?l ?y), (equipped_for_imaging ?r), (communicated_rock_data ?y), (communicated_soil_data ?x), (have_soil_analysis ?r ?p), (visible ?p ?x), (at_rock_sample ?y), (can_traverse ?r ?x ?p), (have_rock_analysis ?r ?y), (at ?r ?p), (have_rock_analysis ?r ?y), (visible ?p ?y), (communicated_rock_data ?p), (communicated_soil_data ?x), (at ?r ?x), (channel_free ?l), (at ?r ?p), (visible ?y ?p), (at ?r ?y), (can_traverse ?r ?p ?x), (have_soil_analysis ?r ?x), (at_lander ?l ?x), (at_soil_sample ?y), (can_traverse ?r ?p ?x), (at_lander ?l ?y), (at_soil_sample ?y), (at_rock_sample ?p), (at_soil_sample ?p), (have_soil_analysis ?r ?y), (have_rock_analysis ?r ?p), (can_traverse ?r ?p ?y), (equipped_for_soil_analysis ?r), (visible ?p ?y), (at_lander ?l ?p), (communicated_soil_data ?y), (at_rock_sample ?y), (visible ?p ?x), (communicated_soil_data ?y), (can_traverse ?r ?x ?y), (visible ?x ?p), 
;; drop action has changed: (available ?x), (equipped_for_imaging ?x), (store_of ?y ?x), (empty ?y), (equipped_for_rock_analysis ?x), (equipped_for_soil_analysis ?x), (equipped_for_imaging ?x), (equipped_for_soil_analysis ?x), (empty ?y), (full ?y), 
;; sample_rock action has changed: (available ?x), (communicated_soil_data ?p), (have_rock_analysis ?x ?p), (empty ?s), (equipped_for_rock_analysis ?x), (at_rock_sample ?p), (have_soil_analysis ?x ?p), (have_soil_analysis ?x ?p), (available ?x), (equipped_for_rock_analysis ?x), (have_rock_analysis ?x ?p), (full ?s), (equipped_for_imaging ?x), (store_of ?s ?x), (at_soil_sample ?p), (at ?x ?p), (full ?s), (at_rock_sample ?p), 
;; take_image action has changed: (at ?r ?p), (equipped_for_soil_analysis ?r), (on_board ?i ?r), (have_rock_analysis ?r ?p), (communicated_soil_data ?p), (available ?r), (available ?r), (have_image ?r ?o ?m), (on_board ?i ?r), (communicated_rock_data ?p), (communicated_image_data ?o ?m), (have_soil_analysis ?r ?p), (communicated_rock_data ?p), (have_rock_analysis ?r ?p), (equipped_for_imaging ?r), (equipped_for_soil_analysis ?r), (visible_from ?o ?p), (supports ?i ?m), (have_image ?r ?o ?m), (at ?r ?p), (visible_from ?o ?p), (calibrated ?i ?r), (at_soil_sample ?p), (calibrated ?i ?r), (calibration_target ?i ?o), 
;; Last_reduced_capability_num_dropped_pals: None
